#!/bin/bash

echo "🧪 Testing Deployment Configuration"
echo "=================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# Test 1: Check if all required files exist
print_status "Checking required files..."

REQUIRED_FILES=(
    "frontend/package.json"
    "backend/package.json"
    "frontend/src/config/api.ts"
    "backend/src/index.ts"
    "backend/Procfile"
    "backend/vercel.json"
    ".github/workflows/deploy.yml"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        print_success "✓ $file exists"
    else
        print_error "✗ $file missing"
    fi
done

# Test 2: Check if dependencies are installed
print_status "Checking dependencies..."

if [ -d "frontend/node_modules" ]; then
    print_success "✓ Frontend dependencies installed"
else
    print_warning "⚠ Frontend dependencies not installed"
fi

if [ -d "backend/node_modules" ]; then
    print_success "✓ Backend dependencies installed"
else
    print_warning "⚠ Backend dependencies not installed"
fi

# Test 3: Check if backend builds successfully
print_status "Testing backend build..."

cd backend
if npm run build > /dev/null 2>&1; then
    print_success "✓ Backend builds successfully"
else
    print_error "✗ Backend build failed"
fi
cd ..

# Test 4: Check if frontend builds successfully
print_status "Testing frontend build..."

cd frontend
if npm run build > /dev/null 2>&1; then
    print_success "✓ Frontend builds successfully"
else
    print_error "✗ Frontend build failed"
fi
cd ..

# Test 5: Check environment configuration
print_status "Checking environment configuration..."

if [ -f "backend/.env" ]; then
    print_success "✓ Backend .env file exists"
    
    # Check if required variables are set
    if grep -q "MONGODB_URI" backend/.env; then
        print_success "✓ MONGODB_URI is configured"
    else
        print_warning "⚠ MONGODB_URI not found in backend/.env"
    fi
    
    if grep -q "JWT_SECRET" backend/.env; then
        print_success "✓ JWT_SECRET is configured"
    else
        print_warning "⚠ JWT_SECRET not found in backend/.env"
    fi
else
    print_warning "⚠ Backend .env file not found"
fi

# Test 6: Check GitHub Pages configuration
print_status "Checking GitHub Pages configuration..."

if grep -q "homepage" frontend/package.json; then
    print_success "✓ Homepage configured in package.json"
else
    print_warning "⚠ Homepage not configured in package.json"
fi

if [ -f "frontend/public/404.html" ]; then
    print_success "✓ 404.html exists for client-side routing"
else
    print_error "✗ 404.html missing"
fi

# Test 7: Check API configuration
print_status "Checking API configuration..."

if [ -f "frontend/src/config/api.ts" ]; then
    print_success "✓ API configuration file exists"
else
    print_error "✗ API configuration file missing"
fi

# Test 8: Check deployment scripts
print_status "Checking deployment scripts..."

if [ -f "deploy.sh" ] && [ -x "deploy.sh" ]; then
    print_success "✓ Deploy script exists and is executable"
else
    print_warning "⚠ Deploy script missing or not executable"
fi

if [ -f "setup-github-pages.sh" ] && [ -x "setup-github-pages.sh" ]; then
    print_success "✓ GitHub Pages setup script exists and is executable"
else
    print_warning "⚠ GitHub Pages setup script missing or not executable"
fi

echo ""
echo "📊 Test Summary:"
echo "================"

# Count results
PASS_COUNT=$(grep -c "\[PASS\]" <<< "$(cat /dev/stdin)" 2>/dev/null || echo "0")
WARN_COUNT=$(grep -c "\[WARN\]" <<< "$(cat /dev/stdin)" 2>/dev/null || echo "0")
FAIL_COUNT=$(grep -c "\[FAIL\]" <<< "$(cat /dev/stdin)" 2>/dev/null || echo "0")

echo "✅ Passed: $PASS_COUNT"
echo "⚠️  Warnings: $WARN_COUNT"
echo "❌ Failed: $FAIL_COUNT"

echo ""
if [ "$FAIL_COUNT" -eq 0 ]; then
    print_success "🎉 All critical tests passed! Your deployment is ready."
    echo ""
    echo "Next steps:"
    echo "1. Run: ./deploy.sh"
    echo "2. Follow the prompts to configure your deployment"
    echo "3. Push your code to GitHub"
    echo "4. Enable GitHub Pages in your repository settings"
else
    print_error "❌ Some tests failed. Please fix the issues before deploying."
    echo ""
    echo "Common fixes:"
    echo "1. Run: npm install (in both frontend and backend directories)"
    echo "2. Create backend/.env file with your configuration"
    echo "3. Update frontend/package.json homepage field"
fi

echo ""
print_status "Happy testing! 🚀"
