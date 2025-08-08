#!/bin/bash

echo "⚡ Quick Deployment Test"
echo "======================="

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
    "frontend/public/404.html"
    "frontend/tailwind.config.js"
    "backend/tsconfig.json"
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

# Test 3: Check TypeScript compilation (fast check)
print_status "Checking TypeScript configuration..."

if [ -f "backend/tsconfig.json" ]; then
    print_success "✓ Backend TypeScript config exists"
fi

if [ -f "frontend/tsconfig.json" ]; then
    print_success "✓ Frontend TypeScript config exists"
fi

# Test 4: Check environment configuration
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

# Test 5: Check GitHub Pages configuration
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

# Test 6: Check API configuration
print_status "Checking API configuration..."

if [ -f "frontend/src/config/api.ts" ]; then
    print_success "✓ API configuration file exists"
else
    print_error "✗ API configuration file missing"
fi

# Test 7: Check deployment scripts
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

# Test 8: Check package.json scripts
print_status "Checking package.json scripts..."

if grep -q "deploy" frontend/package.json; then
    print_success "✓ Frontend deploy script configured"
else
    print_warning "⚠ Frontend deploy script not found"
fi

if grep -q "build" backend/package.json; then
    print_success "✓ Backend build script configured"
else
    print_warning "⚠ Backend build script not found"
fi

# Test 9: Check for required dependencies
print_status "Checking required dependencies..."

if grep -q "gh-pages" frontend/package.json; then
    print_success "✓ gh-pages dependency configured"
else
    print_warning "⚠ gh-pages dependency not found"
fi

if grep -q "express" backend/package.json; then
    print_success "✓ Express dependency configured"
else
    print_warning "⚠ Express dependency not found"
fi

echo ""
echo "📊 Quick Test Summary:"
echo "======================"

# Count results
PASS_COUNT=$(grep -c "\[PASS\]" <<< "$(cat /dev/stdin)" 2>/dev/null || echo "0")
WARN_COUNT=$(grep -c "\[WARN\]" <<< "$(cat /dev/stdin)" 2>/dev/null || echo "0")
FAIL_COUNT=$(grep -c "\[FAIL\]" <<< "$(cat /dev/stdin)" 2>/dev/null || echo "0")

echo "✅ Passed: $PASS_COUNT"
echo "⚠️  Warnings: $WARN_COUNT"
echo "❌ Failed: $FAIL_COUNT"

echo ""
if [ "$FAIL_COUNT" -eq 0 ]; then
    print_success "🎉 Configuration looks good! Ready for deployment."
    echo ""
    echo "Next steps:"
    echo "1. Set up MongoDB Atlas (see MONGODB_SETUP.md)"
    echo "2. Run: ./deploy.sh"
    echo "3. Follow the prompts to configure your deployment"
else
    print_error "❌ Some critical files are missing. Please fix the issues."
    echo ""
    echo "Common fixes:"
    echo "1. Run: npm install (in both frontend and backend directories)"
    echo "2. Create backend/.env file with your configuration"
    echo "3. Update frontend/package.json homepage field"
fi

echo ""
print_status "Quick test completed! ⚡"
