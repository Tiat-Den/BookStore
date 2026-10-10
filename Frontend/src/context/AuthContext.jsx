import React, { createContext, useContext, useState, useEffect } from 'react';
import { authService } from '../services/authService';

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(() => {
    const saved = localStorage.getItem('bookstore_user');
    return saved ? JSON.parse(saved) : null;
  });
  const [token, setToken] = useState(() => localStorage.getItem('bookstore_token'));
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const verifyUser = async () => {
      if (token) {
        try {
          const res = await authService.getMe();
          if (res.success && res.data) {
            setUser(res.data);
            localStorage.setItem('bookstore_user', JSON.stringify(res.data));
          }
        } catch (error) {
          logout();
        }
      }
      setLoading(false);
    };

    verifyUser();
  }, [token]);

  const login = async (email, password) => {
    const res = await authService.login(email, password);
    if (res.success && res.data) {
      setToken(res.data.token);
      setUser(res.data.user);
      localStorage.setItem('bookstore_token', res.data.token);
      localStorage.setItem('bookstore_user', JSON.stringify(res.data.user));
      return { success: true };
    }
    return { success: false, message: res.message || 'Đăng nhập thất bại' };
  };

  const register = async (fullName, email, phone, password) => {
    const res = await authService.register(fullName, email, phone, password);
    if (res.success && res.data) {
      setToken(res.data.token);
      setUser(res.data.user);
      localStorage.setItem('bookstore_token', res.data.token);
      localStorage.setItem('bookstore_user', JSON.stringify(res.data.user));
      return { success: true };
    }
    return { success: false, message: res.message || 'Đăng ký thất bại' };
  };

  const logout = () => {
    setToken(null);
    setUser(null);
    localStorage.removeItem('bookstore_token');
    localStorage.removeItem('bookstore_user');
  };

  const updateProfile = async (data) => {
    const res = await authService.updateProfile(data);
    if (res.success && res.data) {
      setUser(res.data);
      localStorage.setItem('bookstore_user', JSON.stringify(res.data));
      return { success: true, data: res.data };
    }
    return { success: false, message: res.message || 'Cập nhật thất bại' };
  };

  const isManager = user?.roles?.some(r => r === 'ADMIN' || r === 'EMPLOYEE') ?? false;
  const isAdmin = user?.roles?.some(r => r === 'ADMIN') ?? false;

  return (
    <AuthContext.Provider value={{
      user,
      token,
      isAuthenticated: !!token,
      isManager,
      isAdmin,
      loading,
      login,
      register,
      logout,
      updateProfile,
      setUser
    }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
