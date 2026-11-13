import apiClient from './apiClient';

export const authService = {
  login: async (email, password) => {
    return await apiClient.post('/auth/login', { email, password });
  },

  register: async (fullName, email, phone, password) => {
    return await apiClient.post('/auth/register', { fullName, email, phone, password });
  },

  getMe: async () => {
    return await apiClient.get('/auth/me');
  },

  updateProfile: async (data) => {
    return await apiClient.put('/auth/profile', data);
  },

  changePassword: async (currentPassword, newPassword) => {
    return await apiClient.post('/auth/change-password', { currentPassword, newPassword });
  },

  forgotPassword: async (identifier) => {
    return await apiClient.post('/auth/forgot-password', { identifier });
  },

  verifyOtp: async (identifier, otp) => {
    return await apiClient.post('/auth/verify-otp', { identifier, otp });
  },

  resetPassword: async (identifier, otp, newPassword) => {
    return await apiClient.post('/auth/reset-password', { identifier, otp, newPassword });
  }
};

