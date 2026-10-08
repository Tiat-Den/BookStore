import apiClient from './apiClient';

export const bookService = {
  getBooks: async (params = {}) => {
    return await apiClient.get('/books', { params });
  },

  getBookById: async (id) => {
    return await apiClient.get(`/books/${id}`);
  },

  getBookBySlug: async (slug) => {
    return await apiClient.get(`/books/slug/${slug}`);
  },

  createBook: async (data) => {
    return await apiClient.post('/books', data);
  },

  updateBook: async (id, data) => {
    return await apiClient.put(`/books/${id}`, data);
  },

  deleteBook: async (id) => {
    return await apiClient.delete(`/books/${id}`);
  },

  updateStatus: async (id, status) => {
    return await apiClient.patch(`/books/${id}/status`, status, {
      headers: { 'Content-Type': 'application/json' }
    });
  }
};

export const categoryService = {
  getCategories: async (activeOnly = true) => {
    return await apiClient.get('/categories', { params: { activeOnly } });
  },

  createCategory: async (data) => {
    return await apiClient.post('/categories', data);
  },

  updateCategory: async (id, data) => {
    return await apiClient.put(`/categories/${id}`, data);
  },

  deleteCategory: async (id) => {
    return await apiClient.delete(`/categories/${id}`);
  }
};

export const cartService = {
  getCart: async () => {
    return await apiClient.get('/cart');
  },

  addToCart: async (bookId, quantity = 1) => {
    return await apiClient.post('/cart/items', { bookId, quantity });
  },

  updateQuantity: async (cartItemId, quantity) => {
    return await apiClient.put(`/cart/items/${cartItemId}`, { quantity });
  },

  removeItem: async (cartItemId) => {
    return await apiClient.delete(`/cart/items/${cartItemId}`);
  },

  clearCart: async () => {
    return await apiClient.delete('/cart');
  }
};

export const orderService = {
  createOrder: async (data) => {
    return await apiClient.post('/orders', data);
  },

  getOrders: async (params = {}) => {
    return await apiClient.get('/orders', { params });
  },

  getOrderById: async (id) => {
    return await apiClient.get(`/orders/${id}`);
  },

  updateStatus: async (id, newStatus, note = '') => {
    return await apiClient.patch(`/orders/${id}/status`, { newStatus, note });
  },

  cancelOrder: async (id, reason) => {
    return await apiClient.post(`/orders/${id}/cancel`, { reason });
  }
};

export const reportService = {
  getDashboardStats: async () => {
    return await apiClient.get('/reports/dashboard');
  },
  getMonthlyRevenue: async (months = 6) => {
    return await apiClient.get('/reports/revenue', { params: { months } });
  },
  getTopSellingBooks: async (limit = 5) => {
    return await apiClient.get('/reports/top-books', { params: { limit } });
  }
};

export const paymentService = {
  createVNPayUrl: async (orderId) => {
    return await apiClient.post('/payment/vnpay/create-url', orderId, {
      headers: { 'Content-Type': 'application/json' }
    });
  },
  processMockPayment: async (data) => {
    return await apiClient.post('/payment/vnpay/process-mock', data);
  }
};
