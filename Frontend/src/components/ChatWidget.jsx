import React, { useState, useEffect, useRef } from 'react';
import { 
  MessageSquare, X, Send, Trash2, Plus, Sparkles, BookOpen, 
  AlertCircle, Loader2, ShoppingCart, Check, RefreshCw 
} from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { useCart } from '../context/CartContext';
import { useNavigate } from 'react-router-dom';
import chatService from '../services/chatService';
import chatIcon from '../assets/chat-icon.png';

export default function ChatWidget() {
  const { user } = useAuth();
  const { refreshCart } = useCart();
  const navigate = useNavigate();

  const [isOpen, setIsOpen] = useState(false);
  const [conversations, setConversations] = useState([]);
  const [currentConversationId, setCurrentConversationId] = useState(null);
  const [messages, setMessages] = useState([]);
  const [inputText, setInputText] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [showHistory, setShowHistory] = useState(false);
  const [confirmingActionToken, setConfirmingActionToken] = useState(null);
  const [completedActions, setCompletedActions] = useState({});
  const [botStatus, setBotStatus] = useState({ isEnabled: true, welcomeMessage: '', systemNotice: '' });
  const [suggestions, setSuggestions] = useState([
    'Gợi ý sách bán chạy nhất',
    'Xem giỏ hàng của tôi',
    'Chính sách đổi trả sách'
  ]);

  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  useEffect(() => {
    if (isOpen) {
      scrollToBottom();
    }
  }, [messages, isOpen]);

  // Nạp trạng thái bot ngay khi trang load
  useEffect(() => {
    chatService.getPublicStatus().then((res) => {
      if (res.success && res.data) {
        setBotStatus(res.data);
      }
    }).catch((e) => console.error('Lỗi kiểm tra trạng thái bot:', e));
  }, []);

  // Nạp lịch sử khi mở widget
  useEffect(() => {
    if (isOpen) {
      if (user) {
        loadConversations();
      }
      if (messages.length === 0) {
        startNewConversation();
      }
    }
  }, [isOpen, user]);

  const loadConversations = async () => {
    try {
      const res = await chatService.getConversations();
      if (res.success && res.data) {
        setConversations(res.data);
      }
    } catch (err) {
      console.error('Lỗi nạp danh sách hội thoại:', err);
    }
  };

  const loadConversationHistory = async (convId) => {
    try {
      setIsLoading(true);
      setCurrentConversationId(convId);
      setShowHistory(false);
      const res = await chatService.getConversationDetail(convId);
      if (res.success && res.data) {
        setMessages(res.data.messages || []);
      }
    } catch (err) {
      console.error('Lỗi nạp tin nhắn:', err);
    } finally {
      setIsLoading(false);
    }
  };

  const startNewConversation = () => {
    setCurrentConversationId(null);
    const greeting = botStatus.welcomeMessage 
      ? botStatus.welcomeMessage 
      : `Xin chào ${user?.fullName || 'bạn'}! 👋 Mình là trợ lý AI của BookStore. Bạn cần tìm cuốn sách nào hay muốn giải đáp thắc mắc về chính sách không ạ?`;

    setMessages([
      {
        id: 'welcome',
        role: 'assistant',
        content: greeting
      }
    ]);
    setShowHistory(false);
  };

  const handleSendMessage = async (textToSend = null) => {
    const text = (textToSend || inputText).trim();
    if (!text || isLoading) return;

    const tempUserMsg = {
      id: 'temp-' + Date.now(),
      role: 'user',
      content: text
    };

    setMessages((prev) => [...prev, tempUserMsg]);
    if (!textToSend) setInputText('');
    setIsLoading(true);

    try {
      const res = await chatService.sendMessage(text, currentConversationId);
      if (res.success && res.data) {
        const assistantMsg = {
          id: res.data.messageId,
          role: 'assistant',
          content: res.data.text,
          books: res.data.books || [],
          proposedActions: res.data.proposedActions || []
        };

        if (res.data.conversationId && res.data.conversationId !== currentConversationId) {
          setCurrentConversationId(res.data.conversationId);
          if (user) {
            loadConversations();
          }
        }

        if (res.data.suggestions && res.data.suggestions.length > 0) {
          setSuggestions(res.data.suggestions);
        }

        setMessages((prev) => [...prev, assistantMsg]);
      } else {
        setMessages((prev) => [
          ...prev,
          {
            id: 'err-' + Date.now(),
            role: 'assistant',
            content: res.message || 'Xin lỗi, đã xảy ra lỗi trong khi xử lý yêu cầu.',
            isError: true
          }
        ]);
      }
    } catch (err) {
      setMessages((prev) => [
        ...prev,
        {
          id: 'err-' + Date.now(),
          role: 'assistant',
          content: 'Không thể kết nối đến máy chủ trợ lý AI. Vui lòng thử lại sau.',
          isError: true
        }
      ]);
    } finally {
      setIsLoading(false);
    }
  };

  const handleDeleteConversation = async (e, convId) => {
    e.stopPropagation();
    if (!window.confirm('Bạn có chắc muốn xóa cuộc hội thoại này?')) return;

    try {
      const res = await chatService.deleteConversation(convId);
      if (res.success) {
        setConversations((prev) => prev.filter((c) => c.id !== convId));
        if (currentConversationId === convId) {
          startNewConversation();
        }
      }
    } catch (err) {
      alert('Lỗi khi xóa hội thoại: ' + (err.message || err));
    }
  };

  const handleConfirmAction = async (action) => {
    if (!user) {
      if (window.confirm('Tính năng thêm sách vào giỏ hàng yêu cầu bạn phải đăng nhập tài khoản. Bạn có muốn chuyển đến trang Đăng nhập ngay bây giờ không?')) {
        navigate('/login');
      }
      return;
    }
    setConfirmingActionToken(action.confirmationToken);
    try {
      const idempotencyKey = action.confirmationToken || `cart-${Date.now()}-${Math.random()}`;
      const res = await chatService.confirmAddToCart(action.bookId, action.quantity, idempotencyKey);
      
      if (res.success) {
        setCompletedActions((prev) => ({
          ...prev,
          [action.confirmationToken]: 'confirmed'
        }));
        if (refreshCart) refreshCart();

        setMessages((prev) => [
          ...prev,
          {
            id: 'sys-' + Date.now(),
            role: 'assistant',
            content: `✅ Đã thêm thành công cuốn "${action.bookTitle}" (SL: ${action.quantity}) vào giỏ hàng của bạn!`
          }
        ]);
      } else {
        alert(res.message || 'Không thể thêm sách vào giỏ hàng.');
        setCompletedActions((prev) => ({
          ...prev,
          [action.confirmationToken]: 'failed'
        }));
      }
    } catch (err) {
      alert(err.message || 'Lỗi khi xác nhận hành động.');
      setCompletedActions((prev) => ({
        ...prev,
        [action.confirmationToken]: 'failed'
      }));
    } finally {
      setConfirmingActionToken(null);
    }
  };

  const handleCancelAction = (token) => {
    setCompletedActions((prev) => ({
      ...prev,
      [token]: 'cancelled'
    }));
  };

  const formatPrice = (val) => {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);
  };

  return (
    <>
      {/* 1. Nút tròn mở Chatbot (Luôn ghim cố định ở góc dưới cùng bên phải màn hình) */}
      {!isOpen && (
        <button
          onClick={() => {
            setIsOpen(true);
            if (messages.length === 0) {
              startNewConversation();
            }
          }}
          style={{
            position: 'fixed',
            bottom: '24px',
            right: '24px',
            width: '45px',
            height: '45px',
            borderRadius: '50%',
            background: 'linear-gradient(135deg, #7899e2 0%, #6785da 100%)',
            color: '#ffffff',
            border: 'none',
            boxShadow: '0 8px 24px rgba(37, 99, 235, 0.45)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            cursor: 'pointer',
            zIndex: 99999,
            transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
            transform: 'scale(1)',
          }}
          onMouseEnter={(e) => (e.currentTarget.style.transform = 'scale(1.08)')}
          onMouseLeave={(e) => (e.currentTarget.style.transform = 'scale(1)')}
          title="Trò chuyện với Trợ lý AI BookStore"
        >
          <img src={chatIcon} alt="Chat" style={{ width: '32px', height: '32px', objectFit: 'contain' }} />
          {/* Chấm tròn xanh báo trạng thái hoạt động */}
          <span
            style={{
              position: 'absolute',
              top: '2px',
              right: '2px',
              width: '14px',
              height: '14px',
              borderRadius: '50%',
              backgroundColor: botStatus.isEnabled ? '#22c55e' : '#ef4444',
              border: '2px solid #ffffff'
            }}
          />
        </button>
      )}

      {/* 2. Cửa sổ Hội thoại Chatbot */}
      {isOpen && (
        <div
          style={{
            position: 'fixed',
            bottom: '24px',
            right: '24px',
            width: '400px',
            maxWidth: 'calc(100vw - 32px)',
            height: '620px',
            maxHeight: 'calc(100vh - 48px)',
            backgroundColor: '#ffffff',
            borderRadius: '20px',
            boxShadow: '0 20px 48px rgba(15, 23, 42, 0.22)',
            border: '1px solid #e2e8f0',
            display: 'flex',
            flexDirection: 'column',
            overflow: 'hidden',
            zIndex: 99999,
            fontFamily: "'Plus Jakarta Sans', sans-serif"
          }}
        >
          {/* Header */}
          <div
            style={{
              background: 'linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%)',
              color: '#ffffff',
              padding: '16px 20px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              boxShadow: '0 2px 8px rgba(0,0,0,0.1)'
            }}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
              <div
                style={{
                  width: '38px',
                  height: '38px',
                  borderRadius: '10px',
                  backgroundColor: 'rgba(255, 255, 255, 0.2)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: '#fef08a'
                }}
              >
                <Sparkles size={20} />
              </div>
              <div>
                <h3 style={{ fontSize: '15px', fontWeight: '700', margin: 0, lineHeight: 1.2 }}>
                  BookStore Support
                </h3>
                <span
                  style={{
                    fontSize: '11px',
                    color: '#bfdbfe',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '5px',
                    marginTop: '3px'
                  }}
                >
                </span>
              </div>
            </div>

            {/* Header Action Buttons */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
              {user && (
                <button
                  onClick={() => setShowHistory(!showHistory)}
                  style={{
                    background: showHistory ? '#ffffff' : 'rgba(255, 255, 255, 0.15)',
                    color: showHistory ? '#2563eb' : '#ffffff',
                    border: 'none',
                    borderRadius: '8px',
                    padding: '6px 10px',
                    fontSize: '12px',
                    fontWeight: '600',
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '4px'
                  }}
                  title="Lịch sử hội thoại"
                >
                  <MessageSquare size={14} />
                  <span>{showHistory ? 'Trò chuyện' : 'Lịch sử'}</span>
                </button>
              )}

              <button
                onClick={startNewConversation}
                style={{
                  background: 'rgba(255, 255, 255, 0.15)',
                  color: '#ffffff',
                  border: 'none',
                  borderRadius: '8px',
                  padding: '6px',
                  cursor: 'pointer'
                }}
                title="Tạo hội thoại mới"
              >
                <Plus size={18} />
              </button>

              <button
                onClick={() => setIsOpen(false)}
                style={{
                  background: 'rgba(255, 255, 255, 0.15)',
                  color: '#ffffff',
                  border: 'none',
                  borderRadius: '8px',
                  padding: '6px',
                  cursor: 'pointer'
                }}
                title="Đóng chatbox"
              >
                <X size={18} />
              </button>
            </div>
          </div>

          {/* Banner thông báo bảo trì nếu bot bị tắt */}
          {!botStatus.isEnabled && (
            <div
              style={{
                backgroundColor: '#fef2f2',
                borderBottom: '1px solid #fecaca',
                padding: '10px 16px',
                color: '#b91c1c',
                fontSize: '12px',
                display: 'flex',
                alignItems: 'center',
                gap: '8px'
              }}
            >
              <AlertCircle size={16} />
              <span>{botStatus.systemNotice || 'Trợ lý AI hiện đang tạm bảo trì để nâng cấp.'}</span>
            </div>
          )}

          {/* Khung nội dung: Danh sách Lịch sử hoặc Danh sách Tin nhắn */}
          {showHistory ? (
            /* Danh sách các cuộc hội thoại đã lưu */
            <div style={{ flex: 1, overflowY: 'auto', padding: '16px', backgroundColor: '#f8fafc' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '14px' }}>
                <span style={{ fontSize: '13px', fontWeight: '700', color: '#334155' }}>Lịch sử trò chuyện</span>
                <button
                  onClick={startNewConversation}
                  style={{
                    background: '#2563eb',
                    color: '#ffffff',
                    border: 'none',
                    borderRadius: '6px',
                    padding: '5px 10px',
                    fontSize: '11px',
                    fontWeight: '600',
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '4px'
                  }}
                >
                  <Plus size={13} /> Tạo mới
                </button>
              </div>

              {conversations.length === 0 ? (
                <div style={{ textAlign: 'center', padding: '40px 20px', color: '#94a3b8', fontSize: '13px' }}>
                  Chưa có cuộc trò chuyện nào trước đây.
                </div>
              ) : (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                  {conversations.map((conv) => (
                    <div
                      key={conv.id}
                      onClick={() => loadConversationHistory(conv.id)}
                      style={{
                        padding: '12px 14px',
                        backgroundColor: currentConversationId === conv.id ? '#eff6ff' : '#ffffff',
                        border: currentConversationId === conv.id ? '1px solid #bfdbfe' : '1px solid #e2e8f0',
                        borderRadius: '12px',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        gap: '8px'
                      }}
                    >
                      <div style={{ display: 'flex', alignItems: 'center', gap: '10px', overflow: 'hidden' }}>
                        <MessageSquare size={16} color="#2563eb" style={{ flexShrink: 0 }} />
                        <span style={{ fontSize: '13px', color: '#1e293b', fontWeight: currentConversationId === conv.id ? '700' : '500', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                          {conv.title}
                        </span>
                      </div>
                      <button
                        onClick={(e) => handleDeleteConversation(e, conv.id)}
                        style={{
                          background: 'none',
                          border: 'none',
                          color: '#94a3b8',
                          cursor: 'pointer',
                          padding: '4px'
                        }}
                        title="Xóa hội thoại"
                      >
                        <Trash2 size={15} />
                      </button>
                    </div>
                  ))}
                </div>
              )}
            </div>
          ) : (
            /* Danh sách tin nhắn trò chuyện */
            <div style={{ flex: 1, overflowY: 'auto', padding: '16px', backgroundColor: '#f8fafc', display: 'flex', flexDirection: 'column', gap: '14px' }}>
              {messages.map((msg, index) => {
                const isUser = msg.role === 'user';
                return (
                  <div key={msg.id || index} style={{ display: 'flex', flexDirection: 'column', alignItems: isUser ? 'flex-end' : 'flex-start' }}>
                    {/* Bong bóng tin nhắn */}
                    <div
                      style={{
                        maxWidth: '85%',
                        padding: '10px 14px',
                        borderRadius: isUser ? '16px 16px 4px 16px' : '16px 16px 16px 4px',
                        backgroundColor: isUser ? '#2563eb' : msg.isError ? '#fef2f2' : '#ffffff',
                        color: isUser ? '#ffffff' : msg.isError ? '#b91c1c' : '#1e293b',
                        border: isUser ? 'none' : msg.isError ? '1px solid #fecaca' : '1px solid #e2e8f0',
                        boxShadow: '0 1px 3px rgba(0,0,0,0.06)',
                        fontSize: '13.5px',
                        lineHeight: 1.5,
                        whiteSpace: 'pre-wrap'
                      }}
                    >
                      {msg.content}
                    </div>

                    {/* Danh sách thẻ sách đề xuất (nếu có) */}
                    {!isUser && msg.books && msg.books.length > 0 && (
                      <div style={{ marginTop: '10px', width: '100%' }}>
                        <div style={{ fontSize: '11px', fontWeight: '700', color: '#64748b', textTransform: 'uppercase', marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '4px' }}>
                          <BookOpen size={13} color="#2563eb" /> Sách gợi ý từ cửa hàng:
                        </div>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                          {msg.books.map((b) => (
                            <div
                              key={b.id}
                              onClick={() => {
                                setIsOpen(false);
                                navigate(`/books/${b.id}`);
                              }}
                              style={{
                                display: 'flex',
                                alignItems: 'center',
                                padding: '10px',
                                backgroundColor: '#ffffff',
                                border: '1px solid #e2e8f0',
                                borderRadius: '12px',
                                cursor: 'pointer',
                                transition: 'all 0.2s ease',
                                gap: '12px'
                              }}
                              onMouseEnter={(e) => {
                                e.currentTarget.style.borderColor = '#93c5fd';
                                e.currentTarget.style.transform = 'translateY(-2px)';
                                e.currentTarget.style.boxShadow = '0 4px 12px rgba(0,0,0,0.08)';
                              }}
                              onMouseLeave={(e) => {
                                e.currentTarget.style.borderColor = '#e2e8f0';
                                e.currentTarget.style.transform = 'translateY(0)';
                                e.currentTarget.style.boxShadow = 'none';
                              }}
                            >
                              <img
                                src={b.imageUrl || 'https://via.placeholder.com/60x80?text=Book'}
                                alt={b.title}
                                style={{ width: '48px', height: '64px', objectFit: 'cover', borderRadius: '6px', flexShrink: 0 }}
                              />
                              <div style={{ flex: 1, minWidth: 0 }}>
                                <h5 style={{ fontSize: '13px', fontWeight: '700', color: '#0f172a', margin: '0 0 3px 0', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                                  {b.title}
                                </h5>
                                <p style={{ fontSize: '11px', color: '#64748b', margin: '0 0 4px 0', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                                  {b.author || 'Tác giả'}
                                </p>
                                <span style={{ fontSize: '13px', fontWeight: '800', color: '#dc2626' }}>
                                  {formatPrice(b.price)}
                                </span>
                              </div>
                            </div>
                          ))}
                        </div>
                      </div>
                    )}

                    {/* Thẻ xác nhận thêm vào giỏ hàng (Propose - Confirm - Execute) */}
                    {!isUser && msg.proposedActions && msg.proposedActions.length > 0 && (
                      <div style={{ marginTop: '10px', width: '100%' }}>
                        {msg.proposedActions.map((action) => {
                          const status = completedActions[action.confirmationToken];
                          const isProcessing = confirmingActionToken === action.confirmationToken;

                          return (
                            <div
                              key={action.confirmationToken}
                              style={{
                                padding: '12px',
                                background: 'linear-gradient(135deg, #eff6ff 0%, #f0fdf4 100%)',
                                border: '1px solid #bfdbfe',
                                borderRadius: '12px',
                                display: 'flex',
                                flexDirection: 'column',
                                gap: '8px'
                              }}
                            >
                              <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '12px', fontWeight: '700', color: '#1e40af' }}>
                                <ShoppingCart size={15} color="#2563eb" />
                                <span>Xác nhận thêm vào giỏ hàng</span>
                              </div>

                              <div style={{ fontSize: '12.5px', color: '#334155' }}>
                                <strong>{action.bookTitle}</strong> (SL: {action.quantity} quyển)
                                {action.price && (
                                  <span style={{ color: '#dc2626', fontWeight: '700', marginLeft: '6px' }}>
                                    - {formatPrice(action.price * action.quantity)}
                                  </span>
                                )}
                              </div>

                              {status === 'confirmed' ? (
                                <div style={{ display: 'flex', alignItems: 'center', gap: '5px', color: '#16a34a', fontSize: '12px', fontWeight: '700' }}>
                                  <Check size={16} /> Đã thêm vào giỏ hàng!
                                </div>
                              ) : status === 'cancelled' ? (
                                <span style={{ color: '#94a3b8', fontSize: '12px', fontStyle: 'italic' }}>Đã hủy đề xuất.</span>
                              ) : (
                                <div style={{ display: 'flex', gap: '8px', marginTop: '4px' }}>
                                  <button
                                    onClick={() => handleConfirmAction(action)}
                                    disabled={isProcessing}
                                    style={{
                                      background: '#16a34a',
                                      color: '#ffffff',
                                      border: 'none',
                                      padding: '6px 14px',
                                      borderRadius: '8px',
                                      fontSize: '12px',
                                      fontWeight: '700',
                                      cursor: 'pointer',
                                      display: 'flex',
                                      alignItems: 'center',
                                      gap: '4px'
                                    }}
                                  >
                                    {isProcessing ? <Loader2 size={13} className="animate-spin" /> : <Check size={13} />}
                                    Xác nhận thêm giỏ
                                  </button>
                                  <button
                                    onClick={() => handleCancelAction(action.confirmationToken)}
                                    disabled={isProcessing}
                                    style={{
                                      background: '#ffffff',
                                      border: '1px solid #cbd5e1',
                                      color: '#64748b',
                                      padding: '6px 12px',
                                      borderRadius: '8px',
                                      fontSize: '12px',
                                      fontWeight: '600',
                                      cursor: 'pointer'
                                    }}
                                  >
                                    Hủy
                                  </button>
                                </div>
                              )}
                            </div>
                          );
                        })}
                      </div>
                    )}
                  </div>
                );
              })}

              {/* Trạng thái AI đang gõ */}
              {isLoading && (
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#64748b', fontSize: '12px', padding: '6px 0' }}>
                  <Loader2 size={16} className="animate-spin" color="#2563eb" />
                  <span>Trợ lý AI đang tra cứu và trả lời...</span>
                </div>
              )}

              <div ref={messagesEndRef} />
            </div>
          )}

          {/* Gợi ý câu hỏi nhanh (Suggestions) */}
          {!showHistory && suggestions.length > 0 && !isLoading && (
            <div
              style={{
                padding: '8px 14px',
                backgroundColor: '#f1f5f9',
                borderTop: '1px solid #e2e8f0',
                display: 'flex',
                gap: '6px',
                overflowX: 'auto',
                whiteSpace: 'nowrap'
              }}
            >
              {suggestions.map((sug, i) => (
                <button
                  key={i}
                  onClick={() => handleSendMessage(sug)}
                  style={{
                    backgroundColor: '#ffffff',
                    border: '1px solid #cbd5e1',
                    borderRadius: '20px',
                    padding: '4px 12px',
                    fontSize: '11.5px',
                    color: '#475569',
                    fontWeight: '600',
                    cursor: 'pointer',
                    whiteSpace: 'nowrap'
                  }}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.backgroundColor = '#eff6ff';
                    e.currentTarget.style.color = '#2563eb';
                    e.currentTarget.style.borderColor = '#93c5fd';
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.backgroundColor = '#ffffff';
                    e.currentTarget.style.color = '#475569';
                    e.currentTarget.style.borderColor = '#cbd5e1';
                  }}
                >
                  {sug}
                </button>
              ))}
            </div>
          )}

          {/* Khung nhập tin nhắn */}
          {!showHistory && (
            <div style={{ padding: '12px 14px', backgroundColor: '#ffffff', borderTop: '1px solid #e2e8f0' }}>
              <form
                onSubmit={(e) => {
                  e.preventDefault();
                  handleSendMessage();
                }}
                style={{ display: 'flex', alignItems: 'center', gap: '8px' }}
              >
                <input
                  type="text"
                  value={inputText}
                  onChange={(e) => setInputText(e.target.value)}
                  placeholder={!botStatus.isEnabled ? "Chatbot đang tạm bảo trì..." : "Hỏi AI tìm sách, giá sách, chính sách..."}
                  disabled={isLoading || !botStatus.isEnabled}
                  maxLength={1000}
                  style={{
                    flex: 1,
                    padding: '10px 14px',
                    fontSize: '13px',
                    borderRadius: '12px',
                    border: '1px solid #cbd5e1',
                    outline: 'none',
                    backgroundColor: botStatus.isEnabled ? '#f8fafc' : '#f1f5f9',
                    fontFamily: 'inherit'
                  }}
                  onFocus={(e) => (e.target.style.borderColor = '#2563eb')}
                  onBlur={(e) => (e.target.style.borderColor = '#cbd5e1')}
                />
                <button
                  type="submit"
                  disabled={!inputText.trim() || isLoading || !botStatus.isEnabled}
                  style={{
                    width: '42px',
                    height: '42px',
                    borderRadius: '12px',
                    backgroundColor: inputText.trim() && !isLoading && botStatus.isEnabled ? '#2563eb' : '#cbd5e1',
                    color: '#ffffff',
                    border: 'none',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    cursor: inputText.trim() && !isLoading && botStatus.isEnabled ? 'pointer' : 'not-allowed',
                    transition: 'all 0.2s ease'
                  }}
                  title="Gửi tin nhắn"
                >
                  <Send size={18} />
                </button>
              </form>
            </div>
          )}
        </div>
      )}
    </>
  );
}
