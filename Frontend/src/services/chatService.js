import apiClient from './apiClient';

export const chatService = {
  // Gửi tin nhắn mới hoặc tiếp tục hội thoại
  sendMessage: async (message, conversationId = null) => {
    return await apiClient.post('/chat/messages', {
      message,
      conversationId
    });
  },

  // Lấy danh sách hội thoại của người dùng
  getConversations: async () => {
    return await apiClient.get('/chat/conversations');
  },

  // Lấy chi tiết lịch sử tin nhắn của một hội thoại
  getConversationDetail: async (conversationId) => {
    return await apiClient.get(`/chat/conversations/${conversationId}`);
  },

  // Xóa hội thoại
  deleteConversation: async (conversationId) => {
    return await apiClient.delete(`/chat/conversations/${conversationId}`);
  },

  // Xác nhận thêm sách vào giỏ hàng từ đề xuất của AI
  confirmAddToCart: async (bookId, quantity = 1, idempotencyKey = null) => {
    return await apiClient.post('/chat/cart/items', {
      bookId,
      quantity,
      idempotencyKey
    });
  },

  // [Admin] Lấy cấu hình Bật/Tắt Chatbot
  getAdminSettings: async () => {
    return await apiClient.get('/chat/admin/settings');
  },

  // [Admin] Cập nhật cấu hình Bật/Tắt Chatbot (Kill-switch)
  updateAdminSettings: async (data) => {
    return await apiClient.put('/chat/admin/settings', data);
  },

  // [Admin] Thống kê sử dụng AI Chatbot
  getAdminStats: async () => {
    return await apiClient.get('/chat/admin/stats');
  },

  // [Admin] Lấy toàn bộ danh sách hội thoại của người dùng
  getAdminConversations: async () => {
    return await apiClient.get('/chat/admin/conversations');
  },

  // [Admin] Xem chi tiết tin nhắn của một cuộc hội thoại
  getAdminConversationDetail: async (conversationId) => {
    return await apiClient.get(`/chat/admin/conversations/${conversationId}`);
  },

  // [Admin] Xóa một cuộc hội thoại
  deleteAdminConversation: async (conversationId) => {
    return await apiClient.delete(`/chat/admin/conversations/${conversationId}`);
  },

  // Lấy trạng thái công khai của Chatbot
  getPublicStatus: async () => {
    return await apiClient.get('/chat/status');
  }
};

export default chatService;
