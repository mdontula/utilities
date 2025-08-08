#!/bin/bash

echo "🚀 Manual GitHub Pages Deployment"
echo "================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "frontend/package.json" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

print_status "Building frontend..."
cd frontend

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    print_status "Installing dependencies..."
    npm install
fi

# Build the project
print_status "Building React app..."
npm run build

if [ $? -eq 0 ]; then
    print_success "Build completed successfully!"
else
    echo "❌ Build failed!"
    exit 1
fi

# Deploy to GitHub Pages
print_status "Deploying to GitHub Pages..."
npm run deploy

if [ $? -eq 0 ]; then
    print_success "Deployment completed successfully!"
    echo ""
    echo "🎉 Your app should be live in a few minutes at:"
    echo "   https://mdontula.github.io/utilities"
    echo ""
    echo "Note: It may take a few minutes for the changes to appear."
else
    echo "❌ Deployment failed!"
    echo ""
    echo "Troubleshooting:"
    echo "1. Make sure you have write access to the repository"
    echo "2. Check that GitHub Pages is enabled in repository settings"
    echo "3. Try running: git push origin gh-pages"
    exit 1
fi

cd ..
print_success "Manual deployment completed! 🚀"
