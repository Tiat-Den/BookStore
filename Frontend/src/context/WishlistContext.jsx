import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { wishlistService } from '../services/marketingServices';
import { useAuth } from './AuthContext';

const WishlistContext = createContext(null);

export const WishlistProvider = ({ children }) => {
  const { isAuthenticated } = useAuth();
  const [wishlist, setWishlist] = useState({ items: [] });
  const [loading, setLoading] = useState(false);

  const fetchWishlist = useCallback(async () => {
    if (!isAuthenticated) {
      setWishlist({ items: [] });
      return;
    }
    try {
      setLoading(true);
      const res = await wishlistService.getWishlist();
      if (res.success && res.data) {
        setWishlist(res.data);
      }
    } catch (err) {
      console.error('Lỗi khi tải wishlist:', err);
    } finally {
      setLoading(false);
    }
  }, [isAuthenticated]);

  useEffect(() => {
    fetchWishlist();
  }, [fetchWishlist]);

  const isInWishlist = useCallback((bookId) => {
    if (!bookId || !wishlist?.items) return false;
    return wishlist.items.some(item => item.bookId === bookId || item.id === bookId);
  }, [wishlist]);

  const toggleWishlist = async (bookId) => {
    if (!isAuthenticated) {
      return { success: false, requireAuth: true, message: 'Vui lòng đăng nhập để lưu sách vào danh sách yêu thích.' };
    }

    try {
      const currentlyIn = isInWishlist(bookId);
      let res;
      if (currentlyIn) {
        res = await wishlistService.removeFromWishlist(bookId);
      } else {
        res = await wishlistService.addToWishlist(bookId);
      }

      if (res.success && res.data) {
        setWishlist(res.data);
        return { success: true, added: !currentlyIn };
      }
      return { success: false, message: res.message || 'Thao tác không thành công.' };
    } catch (err) {
      return { success: false, message: err.message || 'Lỗi khi cập nhật danh sách yêu thích.' };
    }
  };

  const removeFromWishlist = async (bookId) => {
    try {
      const res = await wishlistService.removeFromWishlist(bookId);
      if (res.success && res.data) {
        setWishlist(res.data);
        return { success: true };
      }
      return { success: false, message: res.message };
    } catch (err) {
      return { success: false, message: err.message };
    }
  };

  return (
    <WishlistContext.Provider
      value={{
        wishlist,
        items: wishlist.items || [],
        totalItems: (wishlist.items || []).length,
        loading,
        fetchWishlist,
        isInWishlist,
        toggleWishlist,
        removeFromWishlist
      }}
    >
      {children}
    </WishlistContext.Provider>
  );
};

export const useWishlist = () => {
  const context = useContext(WishlistContext);
  if (!context) {
    throw new Error('useWishlist phải được sử dụng bên trong WishlistProvider');
  }
  return context;
};
