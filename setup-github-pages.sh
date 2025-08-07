#!/bin/bash

echo "🚀 Setting up GitHub Pages Deployment"
echo "===================================="

# Get repository information
echo "Please provide the following information:"
read -p "GitHub Username: " GITHUB_USERNAME
read -p "Repository Name: " REPO_NAME
read -p "Backend URL (e.g., https://your-app.herokuapp.com): " BACKEND_URL

# Update homepage in package.json
echo "📝 Updating homepage in package.json..."
sed -i '' "s|https://yourusername.github.io/your-repo-name|https://$GITHUB_USERNAME.github.io/$REPO_NAME|g" frontend/package.json

# Update production environment
echo "📝 Updating production environment..."
sed -i '' "s|https://your-backend-url.herokuapp.com|$BACKEND_URL|g" frontend/env.production

# Update backend CORS origin
echo "📝 Updating backend CORS configuration..."
sed -i '' "s|http://localhost:3000|https://$GITHUB_USERNAME.github.io|g" backend/env.example

echo ""
echo "✅ Configuration updated!"
echo ""
echo "Next steps:"
echo "1. Update backend/.env with your production settings"
echo "2. Deploy your backend to Heroku/Vercel"
echo "3. Push your code to GitHub"
echo "4. Enable GitHub Pages in your repository settings"
echo "5. Set up GitHub Actions secrets (optional)"
echo ""
echo "Your app will be available at: https://$GITHUB_USERNAME.github.io/$REPO_NAME"
echo ""
echo "Happy deploying! 🚀"
