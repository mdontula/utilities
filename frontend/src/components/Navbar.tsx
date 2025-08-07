import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAppDispatch, useAppSelector } from '../hooks/redux';
import { logout } from '../store/slices/authSlice';

const Navbar: React.FC = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  const { isAuthenticated, user } = useAppSelector((state) => state.auth);

  const handleLogout = () => {
    dispatch(logout());
    navigate('/login');
  };

  return (
    <nav className="bg-white shadow-lg">
      <div className="container mx-auto px-4">
        <div className="flex justify-between items-center h-16">
          <Link to="/" className="text-xl font-bold text-primary-600">
            Auth App
          </Link>

          <div className="flex items-center space-x-4">
            {isAuthenticated ? (
              <>
                <Link
                  to="/dashboard"
                  className="text-gray-700 hover:text-primary-600 transition-colors"
                >
                  Dashboard
                </Link>
                <Link
                  to="/profile"
                  className="text-gray-700 hover:text-primary-600 transition-colors"
                >
                  Profile
                </Link>
                <div className="flex items-center space-x-2">
                  <span className="text-gray-700">Welcome, {user?.name}</span>
                  <button
                    onClick={handleLogout}
                    className="btn btn-secondary"
                  >
                    Logout
                  </button>
                </div>
              </>
            ) : (
              <>
                <Link
                  to="/login"
                  className="text-gray-700 hover:text-primary-600 transition-colors"
                >
                  Login
                </Link>
                <Link
                  to="/register"
                  className="btn btn-primary"
                >
                  Register
                </Link>
              </>
            )}
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
