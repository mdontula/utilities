# Full-Stack Authentication App

A modern full-stack web application built with React.js, Node.js, TypeScript, Tailwind CSS, Redux, and React Router. Features complete user authentication with JWT tokens, protected routes, and a beautiful responsive UI.

## 🚀 Features

### Frontend (React + TypeScript)
- **Modern React 18** with TypeScript for type safety
- **Tailwind CSS** for beautiful, responsive styling
- **Redux Toolkit** for state management
- **React Router** for client-side routing
- **Protected Routes** with authentication guards
- **Form Validation** with real-time feedback
- **Responsive Design** that works on all devices

### Backend (Node.js + TypeScript)
- **Express.js** with TypeScript
- **JWT Authentication** with secure token handling
- **MongoDB** with Mongoose ODM
- **Password Hashing** with bcrypt
- **Input Validation** with express-validator
- **Error Handling** middleware
- **Rate Limiting** for API protection
- **CORS** configuration
- **Security Headers** with helmet

### Authentication Features
- User registration with email validation
- Secure login with JWT tokens
- Protected routes and middleware
- Role-based access control (User/Admin)
- Password hashing and validation
- Token-based session management

## 📁 Project Structure

```
├── backend/                 # Node.js + Express API
│   ├── src/
│   │   ├── models/         # Mongoose models
│   │   ├── routes/         # API routes
│   │   ├── middleware/     # Custom middleware
│   │   ├── utils/          # Utility functions
│   │   └── index.ts        # Server entry point
│   ├── package.json
│   └── tsconfig.json
├── frontend/               # React + TypeScript app
│   ├── src/
│   │   ├── components/     # Reusable components
│   │   ├── pages/          # Page components
│   │   ├── store/          # Redux store & slices
│   │   ├── hooks/          # Custom hooks
│   │   └── App.tsx         # Main app component
│   ├── package.json
│   └── tailwind.config.js
├── package.json            # Root package.json
└── README.md
```

## 🛠️ Installation & Setup

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn
- MongoDB (local or Atlas)
- GitHub account (for GitHub Pages deployment)

### 1. Clone the repository
```bash
git clone <repository-url>
cd fullstack-auth-app
```

### 2. Install dependencies
```bash
# Install root dependencies
npm install

# Install backend dependencies
cd backend
npm install

# Install frontend dependencies
cd ../frontend
npm install
```

### 3. Environment Setup

#### Backend Environment
Create a `.env` file in the `backend` directory:
```bash
cd backend
cp env.example .env
```

Edit the `.env` file with your configuration:
```env
# Server Configuration
PORT=5000
NODE_ENV=development

# Database Configuration
MONGODB_URI=mongodb://localhost:27017/auth-app

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRE=7d

# CORS Configuration
CORS_ORIGIN=http://localhost:3000
```

### 4. Start the application

#### Development (both frontend and backend)
```bash
# From the root directory
npm run dev
```

#### Or start them separately:

**Backend:**
```bash
cd backend
npm run dev
```

**Frontend:**
```bash
cd frontend
npm start
```

The application will be available at:
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000

### 5. GitHub Pages Setup (Optional)

If you want to deploy to GitHub Pages:

```bash
# Run the GitHub Pages setup script
./setup-github-pages.sh
```

This will help you configure the project for GitHub Pages deployment.

## 🔧 Available Scripts

### Root Directory
- `npm run dev` - Start both frontend and backend in development mode
- `npm run server` - Start only the backend server
- `npm run client` - Start only the frontend client
- `npm run install-all` - Install dependencies for all packages

### Backend
- `npm run dev` - Start development server with nodemon
- `npm run build` - Build TypeScript to JavaScript
- `npm start` - Start production server

### Frontend
- `npm start` - Start development server
- `npm run build` - Build for production
- `npm test` - Run tests

## 🗄️ API Endpoints

### Authentication
- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/me` - Get current user (protected)
- `PUT /api/auth/profile` - Update user profile (protected)

### Users (Admin only)
- `GET /api/users` - Get all users
- `GET /api/users/:id` - Get single user
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

## 🔐 Authentication Flow

1. **Registration**: User creates account with name, email, and password
2. **Login**: User authenticates with email and password
3. **JWT Token**: Server returns JWT token for authenticated requests
4. **Protected Routes**: Frontend checks token for route access
5. **Token Storage**: Token stored in localStorage for persistence

## 🎨 UI Components

The application includes:
- **Navigation Bar** with authentication-aware links
- **Login/Register Forms** with validation
- **Dashboard** with user information and quick actions
- **Profile Page** for user management
- **Protected Route Component** for authentication guards
- **Loading States** and error handling
- **Responsive Design** for mobile and desktop

## 🚀 Deployment

### Quick Deployment (Recommended)

Run the automated deployment script:
```bash
./deploy.sh
```

This script will:
- Configure your GitHub Pages URL
- Set up MongoDB Atlas connection
- Deploy backend to Heroku/Vercel
- Deploy frontend to GitHub Pages
- Generate secure JWT secrets

### Manual Deployment

#### Backend Deployment

**Option 1: Heroku**
1. Install Heroku CLI: `npm install -g heroku`
2. Login: `heroku login`
3. Create app: `cd backend && heroku create your-app-name`
4. Set environment variables:
   ```bash
   heroku config:set NODE_ENV=production
   heroku config:set JWT_SECRET=your-secret-key
   heroku config:set MONGODB_URI=your-mongodb-atlas-uri
   heroku config:set CORS_ORIGIN=https://yourusername.github.io
   ```
5. Deploy: `git push heroku main`

**Option 2: Vercel**
1. Install Vercel CLI: `npm install -g vercel`
2. Deploy: `cd backend && vercel --prod`
3. Set environment variables in Vercel dashboard

#### Frontend Deployment (GitHub Pages)

**Option 1: Manual Deployment**
1. Update `frontend/package.json` homepage field
2. Update `frontend/env.production` with your backend URL
3. Deploy: `cd frontend && npm run deploy`

**Option 2: Automatic Deployment (GitHub Actions)**
1. Push to `main` branch
2. Set up GitHub Secrets: `REACT_APP_API_URL`
3. Enable GitHub Pages in repository settings

### Database Setup

See [MONGODB_SETUP.md](MONGODB_SETUP.md) for detailed MongoDB Atlas setup instructions.

### Testing Deployment

Run the test script to verify your configuration:
```bash
./test-deployment.sh
```

### Detailed Guides

- [DEPLOYMENT.md](DEPLOYMENT.md) - Comprehensive deployment guide
- [MONGODB_SETUP.md](MONGODB_SETUP.md) - MongoDB Atlas setup guide

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License.

## 🆘 Support

If you encounter any issues or have questions, please open an issue in the repository.
