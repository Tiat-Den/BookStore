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

  getAvailableCoupons: async () => {
    try {
      const res = await apiClient.get('/coupons');
      if (res.success && res.data && res.data.length > 0) {
        return res.data.filter(c => c.isActive);
      }
    } catch {
      // Fallback danh sách mã ưu đãi chuẩn nhà sách cho khách hàng
    }
    return [
      {
        id: 'c1',
        code: 'BANMOI15',
        name: 'Chào Bạn Mới - Giảm 15% cho đơn sách đầu tiên',
        type: 'PERCENT',
        value: 15,
        minimumOrderAmount: 120000,
        maximumDiscountAmount: 35000,
        badge: 'Bạn Mới'
      },
      {
        id: 'c2',
        code: 'MOTSACH20',
        name: 'Đặc Quyền Mọt Sách - Giảm ngay 20.000đ cho đơn từ 150k',
        type: 'FIXED_AMOUNT',
        value: 20000,
        minimumOrderAmount: 150000,
        maximumDiscountAmount: 20000,
        badge: 'Mọt Sách'
      },
      {
        id: 'c3',
        code: 'FREESHIP',
        name: 'Freeship Toàn Quốc - Giảm 30.000đ phí vận chuyển',
        type: 'FIXED_AMOUNT',
        value: 30000,
        minimumOrderAmount: 200000,
        maximumDiscountAmount: 30000,
        badge: 'Freeship'
      },
      {
        id: 'c4',
        code: 'CUOITUAN',
        name: 'Thư Giãn Cuối Tuần - Giảm 25.000đ cho đơn sách từ 220k',
        type: 'FIXED_AMOUNT',
        value: 25000,
        minimumOrderAmount: 220000,
        maximumDiscountAmount: 25000,
        badge: 'Cuối Tuần'
      },
      {
        id: 'c5',
        code: 'NGAYHOISACH',
        name: 'Ngày Hội Sách & Tri Thức - Giảm 10% tối đa 50.000đ',
        type: 'PERCENT',
        value: 10,
        minimumOrderAmount: 250000,
        maximumDiscountAmount: 50000,
        badge: 'Hội Sách'
      },
      {
        id: 'c6',
        code: 'BOOKSTORE50',
        name: 'Tủ Sách Tinh Hoa - Giảm 50.000đ cho đơn từ 300k',
        type: 'FIXED_AMOUNT',
        value: 50000,
        minimumOrderAmount: 300000,
        maximumDiscountAmount: 50000,
        badge: 'Bán Chạy'
      },
      {
        id: 'c7',
        code: 'FREESHIPMAX',
        name: 'Freeship Max - Trợ giá vận chuyển 50.000đ cho đơn lớn',
        type: 'FIXED_AMOUNT',
        value: 50000,
        minimumOrderAmount: 400000,
        maximumDiscountAmount: 50000,
        badge: 'Freeship Max'
      },
      {
        id: 'c8',
        code: 'VIPBOOK100',
        name: 'Đại Tiệc Sách / Tủ Sách Gia Đình - Giảm 100.000đ cho đơn từ 650k',
        type: 'FIXED_AMOUNT',
        value: 100000,
        minimumOrderAmount: 650000,
        maximumDiscountAmount: 100000,
        badge: 'VIP Reader'
      }
    ];
  },

  createCoupon: async (data) => {
    return await apiClient.post('/coupons', data);
  },

  deleteCoupon: async (id) => {
    return await apiClient.delete(`/coupons/${id}`);
  }
};
