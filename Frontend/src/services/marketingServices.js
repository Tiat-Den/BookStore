import apiClient from './apiClient';

export const reviewService = {
  getBookReviews: async (bookId) => {
    return await apiClient.get(`/reviews/book/${bookId}`);
  },

  createReview: async (bookId, rating, content) => {
    return await apiClient.post('/reviews', { bookId, rating, content });
  },

  deleteReview: async (id) => {
    return await apiClient.delete(`/reviews/${id}`);
  }
};

export const wishlistService = {
  getWishlist: async () => {
    return await apiClient.get('/wishlist');
  },

  addToWishlist: async (bookId) => {
    return await apiClient.post(`/wishlist/items/${bookId}`);
  },

  removeFromWishlist: async (bookId) => {
    return await apiClient.delete(`/wishlist/items/${bookId}`);
  }
};

export const couponService = {
  validateCoupon: async (code, orderAmount) => {
    return await apiClient.post('/coupons/validate', { code, orderAmount });
  },

  getCoupons: async () => {
    return await apiClient.get('/coupons');
  },

  createCoupon: async (data) => {
    return await apiClient.post('/coupons', data);
  },

  deleteCoupon: async (id) => {
    return await apiClient.delete(`/coupons/${id}`);
  }
};
