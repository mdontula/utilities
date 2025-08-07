#!/bin/bash

echo "🚀 Setting up Full-Stack Authentication App"
echo "=========================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ Node.js and npm are installed"

# Install root dependencies
echo "📦 Installing root dependencies..."
npm install

# Install backend dependencies
echo "📦 Installing backend dependencies..."
cd backend
npm install
cd ..

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd frontend
npm install
cd ..

# Create backend .env file if it doesn't exist
if [ ! -f "backend/.env" ]; then
    echo "🔧 Creating backend environment file..."
    cp backend/env.example backend/.env
    echo "✅ Backend .env file created. Please edit it with your configuration."
else
    echo "✅ Backend .env file already exists."
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit backend/.env with your MongoDB URI and JWT secret"
echo "2. Start MongoDB (local or use MongoDB Atlas)"
echo "3. Run 'npm run dev' to start both frontend and backend"
echo ""
echo "The application will be available at:"
echo "- Frontend: http://localhost:3000"
echo "- Backend API: http://localhost:5000"
echo ""
echo "Happy coding! 🚀"
