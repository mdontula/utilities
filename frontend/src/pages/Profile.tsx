import React, { useState } from 'react';
import { useAppSelector } from '../hooks/redux';

const Profile: React.FC = () => {
  const { user } = useAppSelector((state) => state.auth);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    name: user?.name || '',
    email: user?.email || '',
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // TODO: Implement profile update functionality
    setIsEditing(false);
  };

  const handleCancel = () => {
    setFormData({
      name: user?.name || '',
      email: user?.email || '',
    });
    setIsEditing(false);
  };

  return (
    <div className="max-w-2xl mx-auto">
      <div className="card">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-3xl font-bold text-gray-900">Profile</h1>
          <button
            onClick={() => setIsEditing(!isEditing)}
            className="btn btn-secondary"
          >
            {isEditing ? 'Cancel' : 'Edit Profile'}
          </button>
        </div>

        <form onSubmit={handleSubmit}>
          <div className="space-y-6">
            <div>
              <label htmlFor="name" className="block text-sm font-medium text-gray-700">
                Full Name
              </label>
              {isEditing ? (
                <input
                  type="text"
                  id="name"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                  className="input mt-1"
                  required
                />
              ) : (
                <p className="mt-1 text-gray-900">{user?.name}</p>
              )}
            </div>

            <div>
              <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                Email Address
              </label>
              {isEditing ? (
                <input
                  type="email"
                  id="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  className="input mt-1"
                  required
                />
              ) : (
                <p className="mt-1 text-gray-900">{user?.email}</p>
              )}
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700">
                Role
              </label>
              <p className="mt-1 text-gray-900 capitalize">{user?.role}</p>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700">
                Member Since
              </label>
              <p className="mt-1 text-gray-900">
                {user?.createdAt ? new Date(user.createdAt).toLocaleDateString() : 'N/A'}
              </p>
            </div>

            {isEditing && (
              <div className="flex space-x-4">
                <button type="submit" className="btn btn-primary">
                  Save Changes
                </button>
                <button
                  type="button"
                  onClick={handleCancel}
                  className="btn btn-secondary"
                >
                  Cancel
                </button>
              </div>
            )}
          </div>
        </form>

        <div className="mt-8 pt-8 border-t border-gray-200">
          <h2 className="text-xl font-semibold text-gray-900 mb-4">Account Settings</h2>
          <div className="space-y-4">
            <button className="w-full text-left p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors">
              <div className="flex justify-between items-center">
                <div>
                  <h3 className="font-medium text-gray-900">Change Password</h3>
                  <p className="text-sm text-gray-600">Update your password</p>
                </div>
                <span className="text-gray-400">→</span>
              </div>
            </button>

            <button className="w-full text-left p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors">
              <div className="flex justify-between items-center">
                <div>
                  <h3 className="font-medium text-gray-900">Two-Factor Authentication</h3>
                  <p className="text-sm text-gray-600">Add an extra layer of security</p>
                </div>
                <span className="text-gray-400">→</span>
              </div>
            </button>

            <button className="w-full text-left p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors">
              <div className="flex justify-between items-center">
                <div>
                  <h3 className="font-medium text-gray-900">Privacy Settings</h3>
                  <p className="text-sm text-gray-600">Manage your privacy preferences</p>
                </div>
                <span className="text-gray-400">→</span>
              </div>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Profile;
