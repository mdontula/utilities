# Deployment Guide

This guide will help you deploy your full-stack authentication app to GitHub Pages (frontend) and a backend hosting service.

## 🎯 Overview

- **Frontend**: GitHub Pages (static hosting)
- **Backend**: Heroku, Vercel, or similar (server hosting)
- **Database**: MongoDB Atlas (cloud database)

## 🚀 Backend Deployment

### Option 1: Heroku

1. **Create Heroku Account**
   - Sign up at [heroku.com](https://heroku.com)

2. **Install Heroku CLI**
   ```bash
   npm install -g heroku
   ```

3. **Login to Heroku**
   ```bash
   heroku login
   ```

4. **Create Heroku App**
   ```bash
   cd backend
   heroku create your-app-name
   ```

5. **Set Environment Variables**
   ```bash
   heroku config:set NODE_ENV=production
   heroku config:set JWT_SECRET=your-super-secret-jwt-key
   heroku config:set JWT_EXPIRE=7d
   heroku config:set CORS_ORIGIN=https://yourusername.github.io
   ```

6. **Set MongoDB URI**
   ```bash
   heroku config:set MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/auth-app
   ```

7. **Deploy**
   ```bash
   git add .
   git commit -m "Deploy to Heroku"
   git push heroku main
   ```

### Option 2: Vercel

1. **Create Vercel Account**
   - Sign up at [vercel.com](https://vercel.com)

2. **Install Vercel CLI**
   ```bash
   npm install -g vercel
   ```

3. **Deploy**
   ```bash
   cd backend
   vercel
   ```

4. **Set Environment Variables**
   - Go to your Vercel dashboard
   - Add environment variables in the project settings

## 🌐 Frontend Deployment (GitHub Pages)

### Step 1: Update Configuration

1. **Update homepage in package.json**
   ```json
   {
     "homepage": "https://yourusername.github.io/your-repo-name"
   }
   ```

2. **Update production environment**
   ```bash
   # Edit frontend/env.production
   REACT_APP_API_URL=https://your-backend-url.herokuapp.com
   ```

### Step 2: Manual Deployment

1. **Install gh-pages**
   ```bash
   cd frontend
   npm install
   ```

2. **Deploy**
   ```bash
   npm run deploy
   ```

### Step 3: Automatic Deployment (Recommended)

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Setup for GitHub Pages"
   git push origin main
   ```

2. **Configure GitHub Secrets**
   - Go to your repository Settings → Secrets and variables → Actions
   - Add new secret: `REACT_APP_API_URL`
   - Value: `https://your-backend-url.herokuapp.com`

3. **Enable GitHub Pages**
   - Go to repository Settings → Pages
   - Source: "Deploy from a branch"
   - Branch: `gh-pages`
   - Save

## 🗄️ Database Setup (MongoDB Atlas)

1. **Create MongoDB Atlas Account**
   - Sign up at [mongodb.com/atlas](https://mongodb.com/atlas)

2. **Create Cluster**
   - Choose free tier
   - Select cloud provider and region

3. **Set Up Database Access**
   - Create database user with password
   - Note down username and password

4. **Set Up Network Access**
   - Add IP address: `0.0.0.0/0` (allow all IPs)

5. **Get Connection String**
   - Click "Connect" on your cluster
   - Choose "Connect your application"
   - Copy the connection string

6. **Update Environment Variables**
   - Replace `<password>` with your database password
   - Use this URI in your backend deployment

## 🔧 Environment Variables Reference

### Backend (.env)
```env
PORT=5000
NODE_ENV=production
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/auth-app
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRE=7d
CORS_ORIGIN=https://yourusername.github.io
```

### Frontend (env.production)
```env
REACT_APP_API_URL=https://your-backend-url.herokuapp.com
REACT_APP_ENV=production
```

## 🚨 Important Notes

1. **CORS Configuration**: Make sure your backend CORS_ORIGIN includes your GitHub Pages URL
2. **HTTPS**: GitHub Pages uses HTTPS, so your backend should also use HTTPS
3. **Environment Variables**: Never commit sensitive information like JWT secrets
4. **Database**: Use MongoDB Atlas for production database
5. **Domain**: Update the homepage URL in package.json to match your repository

## 🔍 Troubleshooting

### Common Issues

1. **CORS Errors**
   - Check that CORS_ORIGIN includes your GitHub Pages URL
   - Ensure backend is using HTTPS

2. **404 Errors on Refresh**
   - The 404.html file handles client-side routing
   - Make sure it's in the public folder

3. **API Connection Issues**
   - Verify REACT_APP_API_URL is correct
   - Check that backend is deployed and running

4. **Build Failures**
   - Check that all environment variables are set
   - Verify TypeScript compilation

## 📞 Support

If you encounter issues:
1. Check the browser console for errors
2. Verify all environment variables are set correctly
3. Ensure both frontend and backend are deployed
4. Check the GitHub Actions logs for deployment issues
