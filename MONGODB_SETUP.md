# MongoDB Atlas Setup Guide

This guide will help you set up MongoDB Atlas for your authentication app.

## 🗄️ Step 1: Create MongoDB Atlas Account

1. Go to [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Click "Try Free" or "Sign Up"
3. Fill in your details and create an account

## 🌐 Step 2: Create a Cluster

1. **Choose a Plan**
   - Select "FREE" tier (M0)
   - Click "Create"

2. **Choose Cloud Provider & Region**
   - Select your preferred cloud provider (AWS, Google Cloud, or Azure)
   - Choose a region close to your users
   - Click "Next"

3. **Cluster Name**
   - Name your cluster (e.g., "auth-app-cluster")
   - Click "Create Cluster"

## 🔐 Step 3: Set Up Database Access

1. **Create Database User**
   - Go to "Database Access" in the left sidebar
   - Click "Add New Database User"
   - Choose "Password" authentication
   - Create a username and password (save these!)
   - Select "Read and write to any database"
   - Click "Add User"

## 🌍 Step 4: Set Up Network Access

1. **Allow Network Access**
   - Go to "Network Access" in the left sidebar
   - Click "Add IP Address"
   - Click "Allow Access from Anywhere" (0.0.0.0/0)
   - Click "Confirm"

## 🔗 Step 5: Get Connection String

1. **Get Connection String**
   - Go back to "Database" in the left sidebar
   - Click "Connect" on your cluster
   - Choose "Connect your application"
   - Select "Node.js" as your driver
   - Copy the connection string

2. **Format the Connection String**
   ```
   mongodb+srv://<username>:<password>@cluster0.xxxxx.mongodb.net/auth-app?retryWrites=true&w=majority
   ```
   
   Replace:
   - `<username>` with your database username
   - `<password>` with your database password
   - `auth-app` with your desired database name

## 🔧 Step 6: Test Connection

1. **Update your backend .env file**
   ```env
   MONGODB_URI=mongodb+srv://yourusername:yourpassword@cluster0.xxxxx.mongodb.net/auth-app?retryWrites=true&w=majority
   ```

2. **Test locally**
   ```bash
   cd backend
   npm run dev
   ```

3. **Check the console** for successful connection message

## 🚀 Step 7: Deploy with Database

When deploying your backend:

### For Heroku:
```bash
heroku config:set MONGODB_URI="your-mongodb-atlas-connection-string"
```

### For Vercel:
- Add `MONGODB_URI` in your Vercel project environment variables

## 🔍 Troubleshooting

### Common Issues:

1. **Connection Timeout**
   - Check if your IP is whitelisted in Network Access
   - Verify the connection string format

2. **Authentication Failed**
   - Double-check username and password
   - Ensure the database user has proper permissions

3. **Cluster Not Found**
   - Verify the cluster name in the connection string
   - Check if the cluster is active

### Connection String Examples:

**Local Development:**
```
mongodb://localhost:27017/auth-app
```

**MongoDB Atlas:**
```
mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/auth-app?retryWrites=true&w=majority
```

## 📊 Monitoring

1. **View Database Activity**
   - Go to your cluster dashboard
   - Check "Metrics" tab for performance data

2. **View Collections**
   - Click "Browse Collections" to see your data
   - Collections will be created automatically when you register users

## 🔒 Security Best Practices

1. **Use Strong Passwords** for database users
2. **Limit Network Access** to specific IPs in production
3. **Regular Backups** (available in paid plans)
4. **Monitor Access** through Atlas dashboard

## 📞 Support

- MongoDB Atlas Documentation: https://docs.atlas.mongodb.com/
- Community Support: https://community.mongodb.com/
- Atlas Status: https://status.mongodb.com/
