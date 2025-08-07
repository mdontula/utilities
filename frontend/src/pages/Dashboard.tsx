import React from 'react';
import { useAppSelector } from '../hooks/redux';

const Dashboard: React.FC = () => {
  const { user } = useAppSelector((state) => state.auth);

  return (
    <div className="max-w-4xl mx-auto">
      <div className="card">
        <h1 className="text-3xl font-bold text-gray-900 mb-6">
          Welcome to your Dashboard
        </h1>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="bg-gradient-to-br from-primary-50 to-primary-100 p-6 rounded-lg">
            <h2 className="text-xl font-semibold text-primary-900 mb-4">
              User Information
            </h2>
            <div className="space-y-3">
              <div>
                <span className="text-sm font-medium text-gray-600">Name:</span>
                <p className="text-gray-900">{user?.name}</p>
              </div>
              <div>
                <span className="text-sm font-medium text-gray-600">Email:</span>
                <p className="text-gray-900">{user?.email}</p>
              </div>
              <div>
                <span className="text-sm font-medium text-gray-600">Role:</span>
                <p className="text-gray-900 capitalize">{user?.role}</p>
              </div>
            </div>
          </div>

          <div className="bg-gradient-to-br from-green-50 to-green-100 p-6 rounded-lg">
            <h2 className="text-xl font-semibold text-green-900 mb-4">
              Account Status
            </h2>
            <div className="space-y-3">
              <div className="flex items-center">
                <div className="w-3 h-3 bg-green-500 rounded-full mr-3"></div>
                <span className="text-green-900">Account Active</span>
              </div>
              <div className="flex items-center">
                <div className="w-3 h-3 bg-blue-500 rounded-full mr-3"></div>
                <span className="text-blue-900">Email Verified</span>
              </div>
              <div className="flex items-center">
                <div className="w-3 h-3 bg-purple-500 rounded-full mr-3"></div>
                <span className="text-purple-900">Premium Access</span>
              </div>
            </div>
          </div>
        </div>

        <div className="mt-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-4">
            Quick Actions
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <button className="p-4 bg-white border border-gray-200 rounded-lg hover:border-primary-300 hover:shadow-md transition-all">
              <div className="text-primary-600 text-2xl mb-2">📝</div>
              <h3 className="font-semibold text-gray-900">Edit Profile</h3>
              <p className="text-sm text-gray-600">Update your information</p>
            </button>
            
            <button className="p-4 bg-white border border-gray-200 rounded-lg hover:border-primary-300 hover:shadow-md transition-all">
              <div className="text-primary-600 text-2xl mb-2">🔒</div>
              <h3 className="font-semibold text-gray-900">Security</h3>
              <p className="text-sm text-gray-600">Manage your security</p>
            </button>
            
            <button className="p-4 bg-white border border-gray-200 rounded-lg hover:border-primary-300 hover:shadow-md transition-all">
              <div className="text-primary-600 text-2xl mb-2">📊</div>
              <h3 className="font-semibold text-gray-900">Analytics</h3>
              <p className="text-sm text-gray-600">View your statistics</p>
            </button>
          </div>
        </div>

        {user?.role === 'admin' && (
          <div className="mt-8 p-6 bg-yellow-50 border border-yellow-200 rounded-lg">
            <h2 className="text-xl font-semibold text-yellow-900 mb-4">
              Admin Panel
            </h2>
            <p className="text-yellow-800 mb-4">
              You have administrative privileges. You can manage users and access advanced features.
            </p>
            <button className="btn btn-primary">
              Access Admin Panel
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default Dashboard;
