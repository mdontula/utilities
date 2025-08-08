#!/bin/bash

echo "🚀 Full-Stack Deployment Setup"
echo "=============================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    print_error "npm is not installed. Please install npm first."
    exit 1
fi

print_success "Node.js and npm are installed"

# Get deployment information
echo ""
print_status "Please provide the following information for deployment:"
read -p "GitHub Username: " GITHUB_USERNAME
read -p "Repository Name: " REPO_NAME
read -p "Backend Platform (heroku/vercel): " BACKEND_PLATFORM
read -p "MongoDB Atlas URI: " MONGODB_URI
read -p "JWT Secret (leave empty to generate): " JWT_SECRET

# Generate JWT secret if not provided
if [ -z "$JWT_SECRET" ]; then
    JWT_SECRET=$(openssl rand -base64 32)
    print_status "Generated JWT secret: $JWT_SECRET"
fi

# Update configurations
print_status "Updating configurations..."

# Update frontend package.json
sed -i '' "s|https://yourusername.github.io/your-repo-name|https://$GITHUB_USERNAME.github.io/$REPO_NAME|g" frontend/package.json

# Update frontend production environment
sed -i '' "s|https://your-backend-url.herokuapp.com|https://your-backend-url.herokuapp.com|g" frontend/env.production

# Update backend environment example
sed -i '' "s|http://localhost:3000|https://$GITHUB_USERNAME.github.io|g" backend/env.example

# Create backend .env file
print_status "Creating backend environment file..."
cat > backend/.env << EOF
# Server Configuration
PORT=5000
NODE_ENV=production

# Database Configuration
MONGODB_URI=$MONGODB_URI

# JWT Configuration
JWT_SECRET=$JWT_SECRET
JWT_EXPIRE=7d

# CORS Configuration
CORS_ORIGIN=https://$GITHUB_USERNAME.github.io
EOF

print_success "Backend .env file created"

# Install dependencies
print_status "Installing dependencies..."
npm install
cd backend && npm install && cd ..
cd frontend && npm install && cd ..

# Build backend
print_status "Building backend..."
cd backend
npm run build
cd ..

print_success "Backend built successfully"

# Deploy backend based on platform
if [ "$BACKEND_PLATFORM" = "heroku" ]; then
    print_status "Setting up Heroku deployment..."
    
    # Check if Heroku CLI is installed
    if ! command -v heroku &> /dev/null; then
        print_warning "Heroku CLI not found. Please install it:"
        echo "npm install -g heroku"
        echo "Then run: heroku login"
    else
        print_status "Creating Heroku app..."
        cd backend
        heroku create $REPO_NAME-backend || true
        
        print_status "Setting environment variables..."
        heroku config:set NODE_ENV=production
        heroku config:set JWT_SECRET="$JWT_SECRET"
        heroku config:set JWT_EXPIRE=7d
        heroku config:set CORS_ORIGIN="https://$GITHUB_USERNAME.github.io"
        heroku config:set MONGODB_URI="$MONGODB_URI"
        
        print_status "Deploying to Heroku..."
        git add .
        git commit -m "Deploy to Heroku" || true
        git push heroku main || true
        
        # Get the Heroku URL
        HEROKU_URL=$(heroku info -s | grep web_url | cut -d= -f2)
        cd ..
        
        # Update frontend production environment with Heroku URL
        sed -i '' "s|https://your-backend-url.herokuapp.com|$HEROKU_URL|g" frontend/env.production
        
        print_success "Backend deployed to Heroku: $HEROKU_URL"
    fi
    
elif [ "$BACKEND_PLATFORM" = "vercel" ]; then
    print_status "Setting up Vercel deployment..."
    
    # Check if Vercel CLI is installed
    if ! command -v vercel &> /dev/null; then
        print_warning "Vercel CLI not found. Please install it:"
        echo "npm install -g vercel"
        echo "Then run: vercel login"
    else
        print_status "Deploying to Vercel..."
        cd backend
        vercel --prod || true
        cd ..
        
        print_warning "Please update frontend/env.production with your Vercel URL"
    fi
fi

# Deploy frontend to GitHub Pages
print_status "Deploying frontend to GitHub Pages..."
cd frontend
npm run deploy
cd ..

print_success "Frontend deployed to GitHub Pages"

echo ""
print_success "🎉 Deployment setup complete!"
echo ""
echo "📋 Summary:"
echo "- Frontend: https://$GITHUB_USERNAME.github.io/$REPO_NAME"
echo "- Backend: $BACKEND_PLATFORM"
echo "- JWT Secret: $JWT_SECRET"
echo ""
echo "🔧 Next steps:"
echo "1. Push your code to GitHub:"
echo "   git add . && git commit -m 'Deploy setup' && git push origin main"
echo ""
echo "2. Enable GitHub Pages:"
echo "   - Go to repository Settings → Pages"
echo "   - Source: 'Deploy from a branch'"
echo "   - Branch: 'gh-pages'"
echo ""
echo "3. Set up GitHub Actions secrets (optional):"
echo "   - Go to repository Settings → Secrets and variables → Actions"
echo "   - Add REACT_APP_API_URL with your backend URL"
echo ""
echo "4. Test your deployment:"
echo "   - Visit your GitHub Pages URL"
echo "   - Try registering and logging in"
echo ""
print_success "Happy deploying! 🚀"
