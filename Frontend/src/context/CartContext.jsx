import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { cartService } from '../services/catalogAndOrderServices';
import { useAuth } from './AuthContext';

const CartContext = createContext(null);

export const CartProvider = ({ children }) => {
  const { isAuthenticated } = useAuth();
  const [cart, setCart] = useState({ items: [], subTotal: 0, totalItems: 0 });
  const [loading, setLoading] = useState(false);

  const fetchCart = useCallback(async () => {
    if (!isAuthenticated) {
      setCart({ items: [], subTotal: 0, totalItems: 0 });
      return;
    }
    try {
      setLoading(true);
      const res = await cartService.getCart();
      if (res.success && res.data) {
        setCart(res.data);
      }
    } catch (error) {
      console.error('Lỗi khi tải giỏ hàng:', error);
    } finally {
      setLoading(false);
    }
  }, [isAuthenticated]);

  useEffect(() => {
    fetchCart();
  }, [fetchCart]);

  const addToCart = async (bookId, quantity = 1) => {
    if (!isAuthenticated) {
      return { success: false, requireAuth: true, message: 'Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng.' };
    }
    try {
      const res = await cartService.addToCart(bookId, quantity);
      if (res.success && res.data) {
        setCart(res.data);
        return { success: true };
      }
      return { success: false, message: res.message };
    } catch (error) {
      return { success: false, message: error.message || 'Không thể thêm vào giỏ hàng.' };
    }
  };

  const updateQuantity = async (cartItemId, quantity) => {
    try {
      const res = await cartService.updateQuantity(cartItemId, quantity);
      if (res.success && res.data) {
        setCart(res.data);
        return { success: true };
      }
      return { success: false, message: res.message };
    } catch (error) {
      return { success: false, message: error.message };
    }
  };

  const removeItem = async (cartItemId) => {
    try {
      const res = await cartService.removeItem(cartItemId);
      if (res.success && res.data) {
        setCart(res.data);
        return { success: true };
      }
      return { success: false, message: res.message };
    } catch (error) {
      return { success: false, message: error.message };
    }
  };

  const clearCart = async () => {
    try {
      await cartService.clearCart();
      setCart({ items: [], subTotal: 0, totalItems: 0 });
    } catch (error) {
      console.error('Lỗi khi xóa giỏ hàng:', error);
    }
  };

  return (
    <CartContext.Provider value={{
      cart,
      totalItems: cart.items?.reduce((sum, i) => sum + i.quantity, 0) || 0,
      loading,
      addToCart,
      updateQuantity,
      removeItem,
      clearCart,
      refreshCart: fetchCart
    }}>
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => useContext(CartContext);
