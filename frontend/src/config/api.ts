// API Configuration for different environments
const API_CONFIG = {
  // Development environment (localhost)
  development: {
    baseURL: 'http://localhost:5000',
  },
  // Production environment (deployed backend)
  production: {
    baseURL: process.env.REACT_APP_API_URL || 'https://your-backend-url.herokuapp.com',
  },
};

// Get current environment
const environment = process.env.NODE_ENV || 'development';

// Export the appropriate configuration
export const API_BASE_URL = API_CONFIG[environment as keyof typeof API_CONFIG].baseURL;

// Axios configuration
export const axiosConfig = {
  baseURL: API_BASE_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
};
