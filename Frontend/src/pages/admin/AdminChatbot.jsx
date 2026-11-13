import React, { useState, useEffect } from 'react';
import { 
  Bot, Power, MessageSquare, Users, Sparkles, CheckCircle2, 
  AlertTriangle, RefreshCw, Save, Eye, Trash2, X, Calendar, Clock, ChevronRight, User as UserIcon
} from 'lucide-react';
import { ManagementHeader } from './AdminPages';
import { LoadingSpinner } from '../../components/UIComponents';
import chatService from '../../services/chatService';

export const AdminChatbot = () => {
  const [stats, setStats] = useState({
    totalConversations: 0,
    totalMessages: 0,
    totalActiveUsers: 0,
    messagesToday: 0,
    isAiEnabled: true,
    activeModel: 'gemini-3.1-flash-lite'
  });

  const [settings, setSettings] = useState({
    isEnabled: true,
    welcomeMessage: '',
    systemNotice: ''
  });

  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [saveSuccess, setSaveSuccess] = useState(false);

  // Quản lý xem danh sách cuộc hội thoại
  const [showConversations, setShowConversations] = useState(false);
  const [conversations, setConversations] = useState([]);
  const [loadingConversations, setLoadingConversations] = useState(false);
  const [searchKeyword, setSearchKeyword] = useState('');

  // Quản lý xem chi tiết tin nhắn của một cuộc hội thoại
  const [selectedConversation, setSelectedConversation] = useState(null);
  const [conversationDetail, setConversationDetail] = useState(null);
  const [loadingDetail, setLoadingDetail] = useState(false);

  const fetchData = async () => {
    try {
      setLoading(true);
      const [statsRes, settingsRes] = await Promise.all([
        chatService.getAdminStats(),
        chatService.getAdminSettings()
      ]);

      if (statsRes.success && statsRes.data) {
        setStats(statsRes.data);
      }
      if (settingsRes.success && settingsRes.data) {
        setSettings(settingsRes.data);
      }
    } catch (err) {
      console.error('Lỗi tải dữ liệu quản trị AI Chatbot:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  const fetchConversations = async () => {
    try {
      setLoadingConversations(true);
      const res = await chatService.getAdminConversations();
      if (res.success && res.data) {
        setConversations(res.data);
      }
    } catch (err) {
      console.error('Lỗi tải danh sách cuộc hội thoại:', err);
    } finally {
      setLoadingConversations(false);
    }
  };

  const handleToggleConversations = () => {
    const nextState = !showConversations;
    setShowConversations(nextState);
    if (nextState && conversations.length === 0) {
      fetchConversations();
    }
  };

  const handleViewDetail = async (conv) => {
    setSelectedConversation(conv);
    try {
      setLoadingDetail(true);
      const res = await chatService.getAdminConversationDetail(conv.id);
      if (res.success && res.data) {
        setConversationDetail(res.data);
      }
    } catch (err) {
      alert('Lỗi tải chi tiết cuộc hội thoại: ' + (err.message || err));
    } finally {
      setLoadingDetail(false);
    }
  };

  const handleDeleteConversation = async (convId, e) => {
    if (e) e.stopPropagation();
    if (!window.confirm('Bạn có chắc chắn muốn xóa cuộc hội thoại này không?')) {
      return;
    }
    try {
      const res = await chatService.deleteAdminConversation(convId);
      if (res.success) {
        setConversations((prev) => prev.filter((c) => c.id !== convId));
        setStats((prev) => ({
          ...prev,
          totalConversations: Math.max(0, prev.totalConversations - 1)
        }));
        if (selectedConversation && selectedConversation.id === convId) {
          setSelectedConversation(null);
          setConversationDetail(null);
        }
      } else {
        alert(res.message || 'Xóa cuộc hội thoại thất bại.');
      }
    } catch (err) {
      alert('Lỗi khi xóa cuộc hội thoại: ' + (err.message || err));
    }
  };

  const handleToggleSwitch = async () => {
    const updatedStatus = !settings.isEnabled;
    setSettings((prev) => ({ ...prev, isEnabled: updatedStatus }));
    try {
      setSaving(true);
      const res = await chatService.updateAdminSettings({
        ...settings,
        isEnabled: updatedStatus
      });
      if (res.success) {
        setStats((prev) => ({ ...prev, isAiEnabled: updatedStatus }));
        setSaveSuccess(true);
        setTimeout(() => setSaveSuccess(false), 3000);
      }
    } catch (err) {
      alert('Lỗi cập nhật trạng thái Chatbot: ' + (err.message || err));
      setSettings((prev) => ({ ...prev, isEnabled: !updatedStatus }));
    } finally {
      setSaving(false);
    }
  };

  const handleSaveSettings = async (e) => {
    e.preventDefault();
    try {
      setSaving(true);
      const res = await chatService.updateAdminSettings(settings);
      if (res.success) {
        setSaveSuccess(true);
        setTimeout(() => setSaveSuccess(false), 3000);
      } else {
        alert(res.message || 'Cập nhật thất bại.');
      }
    } catch (err) {
      alert('Lỗi lưu cấu hình: ' + (err.message || err));
    } finally {
      setSaving(false);
    }
  };

  // Lọc cuộc hội thoại theo tìm kiếm
  const filteredConversations = conversations.filter((c) => {
    if (!searchKeyword.trim()) return true;
    const kw = searchKeyword.toLowerCase();
    return (
      (c.userName && c.userName.toLowerCase().includes(kw)) ||
      (c.userEmail && c.userEmail.toLowerCase().includes(kw)) ||
      (c.title && c.title.toLowerCase().includes(kw)) ||
      (c.lastMessage && c.lastMessage.toLowerCase().includes(kw))
    );
  });

  if (loading) return <LoadingSpinner text="Đang tải cấu hình AI Chatbot..." />;

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <ManagementHeader
        title="Quản Trị AI Chatbot (Gemini Flash)"
        subtitle="Giám sát hoạt động, lịch sử hội thoại và công tắc khẩn cấp (Kill-Switch)"
        activeTab="chatbot"
      />

      {/* KPI Stats Cards (Đã bỏ thẻ 'Tổng tin nhắn trao đổi', có 3 thẻ cân đối) */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '20px', marginBottom: '32px' }}>
        
        {/* Card 1: Trạng thái hoạt động */}
        <div className="card" style={{ padding: '24px' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '10px' }}>
            <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Trạng thái hoạt động</span>
            <span
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '5px',
                fontSize: '12px',
                fontWeight: '700',
                padding: '4px 10px',
                borderRadius: '12px',
                backgroundColor: settings.isEnabled ? '#dcfce7' : '#fee2e2',
                color: settings.isEnabled ? '#15803d' : '#b91c1c'
              }}
            >
              <span style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: settings.isEnabled ? '#22c55e' : '#ef4444' }}></span>
              {settings.isEnabled ? 'ĐANG BẬT' : 'ĐÃ TẮT'}
            </span>
          </div>
          <div style={{ fontSize: '24px', fontWeight: '800', color: settings.isEnabled ? '#16a34a' : '#dc2626' }}>
            {settings.isEnabled ? 'Hoạt động bình thường' : 'Tạm dừng phục vụ'}
          </div>
          <div style={{ fontSize: '12px', color: 'var(--text-muted)', marginTop: '6px' }}>
            Mô hình: <strong>{stats.activeModel}</strong>
          </div>
        </div>

        {/* Card 2: Tổng số cuộc hội thoại (Có thể bấm vào để xem danh sách chi tiết) */}
        <div 
          className="card" 
          onClick={handleToggleConversations}
          style={{ 
            padding: '24px',
            cursor: 'pointer',
            border: showConversations ? '2px solid #2563eb' : '1px solid var(--border)',
            backgroundColor: showConversations ? '#f8fafc' : '#ffffff',
            transition: 'all 0.2s ease',
            position: 'relative'
          }}
          title="Nhấn để xem danh sách toàn bộ cuộc hội thoại"
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', color: '#2563eb', marginBottom: '10px' }}>
            <MessageSquare size={24} />
            <span 
              style={{ 
                fontSize: '11.5px', 
                fontWeight: '700', 
                color: '#2563eb',
                backgroundColor: '#eff6ff',
                padding: '3px 8px',
                borderRadius: '6px',
                display: 'inline-flex',
                alignItems: 'center',
                gap: '3px'
              }}
            >
              {showConversations ? 'Đang mở danh sách' : 'Bấm để xem'} <ChevronRight size={13} />
            </span>
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Tổng số cuộc hội thoại</span>
          <h2 style={{ fontSize: '30px', fontWeight: '800', marginTop: '4px', color: '#0f172a' }}>
            {stats.totalConversations}
          </h2>
          <div style={{ fontSize: '12px', color: '#2563eb', fontWeight: '600', marginTop: '6px' }}>
            {showConversations ? '▼ Thu gọn danh sách' : '▶ Nhấn để xem chi tiết từng hội thoại'}
          </div>
        </div>

        {/* Card 3: Khách hàng đã tương tác */}
        <div className="card" style={{ padding: '24px' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', color: '#f59e0b', marginBottom: '10px' }}>
            <Users size={24} />
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Khách hàng đã tương tác</span>
          <h2 style={{ fontSize: '30px', fontWeight: '800', marginTop: '4px', color: '#0f172a' }}>{stats.totalActiveUsers}</h2>
          <div style={{ fontSize: '12px', color: 'var(--text-muted)', marginTop: '6px' }}>
            Người dùng có tài khoản đã gửi tin
          </div>
        </div>
      </div>

      {/* DANH SÁCH CUỘC HỘI THOẠI (Hiển thị khi Admin nhấn vào Card "Tổng số cuộc hội thoại") */}
      {showConversations && (
        <div className="card" style={{ padding: '24px', marginBottom: '32px', border: '1px solid #bfdbfe', backgroundColor: '#ffffff' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '18px', flexWrap: 'wrap', gap: '12px' }}>
            <div>
              <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#1e3a8a', display: 'flex', alignItems: 'center', gap: '8px' }}>
                <MessageSquare size={20} color="#2563eb" />
                Danh Sách Các Cuộc Hội Thoại Của Người Dùng ({filteredConversations.length})
              </h3>
              <p style={{ fontSize: '13px', color: 'var(--text-muted)', margin: '4px 0 0 0' }}>
                Bấm vào "Xem tin nhắn" để theo dõi nội dung tư vấn giữa khách hàng và AI Chatbot
              </p>
            </div>

            <div style={{ display: 'flex', gap: '10px', alignItems: 'center' }}>
              <input
                type="text"
                placeholder="Tìm theo khách hàng, email, tiêu đề..."
                value={searchKeyword}
                onChange={(e) => setSearchKeyword(e.target.value)}
                style={{
                  padding: '8px 14px',
                  borderRadius: '8px',
                  border: '1px solid var(--border)',
                  fontSize: '13px',
                  minWidth: '260px',
                  outline: 'none'
                }}
              />
              <button
                type="button"
                onClick={fetchConversations}
                disabled={loadingConversations}
                className="btn btn-outline btn-sm"
                title="Tải lại danh sách"
              >
                <RefreshCw size={14} className={loadingConversations ? 'animate-spin' : ''} />
                Làm mới
              </button>
            </div>
          </div>

          {loadingConversations ? (
            <div style={{ textAlign: 'center', padding: '40px', color: 'var(--text-muted)' }}>
              Đang tải danh sách cuộc hội thoại...
            </div>
          ) : filteredConversations.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '40px', color: 'var(--text-muted)' }}>
              Không tìm thấy cuộc hội thoại nào phù hợp.
            </div>
          ) : (
            <div style={{ overflowX: 'auto' }}>
              <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '13.5px' }}>
                <thead>
                  <tr style={{ borderBottom: '2px solid #e2e8f0', textAlign: 'left', color: 'var(--text-muted)', fontSize: '12.5px' }}>
                    <th style={{ padding: '12px 14px' }}>Khách hàng</th>
                    <th style={{ padding: '12px 14px' }}>Chủ đề / Tiêu đề hội thoại</th>
                    <th style={{ padding: '12px 14px' }}>Tin nhắn gần nhất</th>
                    <th style={{ padding: '12px 14px', textAlign: 'center' }}>Số tin nhắn</th>
                    <th style={{ padding: '12px 14px' }}>Thời gian cập nhật</th>
                    <th style={{ padding: '12px 14px', textAlign: 'right' }}>Thao tác</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredConversations.map((conv) => (
                    <tr 
                      key={conv.id} 
                      style={{ borderBottom: '1px solid #f1f5f9', transition: 'background-color 0.15s ease' }}
                      onMouseEnter={(e) => (e.currentTarget.style.backgroundColor = '#f8fafc')}
                      onMouseLeave={(e) => (e.currentTarget.style.backgroundColor = 'transparent')}
                    >
                      <td style={{ padding: '12px 14px' }}>
                        <div style={{ fontWeight: '600', color: '#0f172a' }}>{conv.userName || 'Khách hàng'}</div>
                        <div style={{ fontSize: '12px', color: 'var(--text-muted)' }}>{conv.userEmail}</div>
                      </td>
                      <td style={{ padding: '12px 14px', fontWeight: '500', color: '#1e40af', maxWidth: '200px' }}>
                        <div style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                          {conv.title}
                        </div>
                      </td>
                      <td style={{ padding: '12px 14px', color: '#475569', maxWidth: '260px' }}>
                        <div style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis', fontSize: '12.5px' }}>
                          {conv.lastMessage || 'Chưa có tin nhắn'}
                        </div>
                      </td>
                      <td style={{ padding: '12px 14px', textAlign: 'center' }}>
                        <span style={{ 
                          backgroundColor: '#eff6ff', 
                          color: '#2563eb', 
                          fontWeight: '700', 
                          padding: '3px 8px', 
                          borderRadius: '12px',
                          fontSize: '12px'
                        }}>
                          {conv.messageCount}
                        </span>
                      </td>
                      <td style={{ padding: '12px 14px', color: 'var(--text-muted)', fontSize: '12px' }}>
                        {new Date(conv.updatedAt).toLocaleString('vi-VN')}
                      </td>
                      <td style={{ padding: '12px 14px', textAlign: 'right' }}>
                        <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '8px' }}>
                          <button
                            type="button"
                            onClick={() => handleViewDetail(conv)}
                            style={{
                              background: '#2563eb',
                              color: '#ffffff',
                              border: 'none',
                              borderRadius: '8px',
                              padding: '6px 12px',
                              fontSize: '12px',
                              fontWeight: '600',
                              cursor: 'pointer',
                              display: 'inline-flex',
                              alignItems: 'center',
                              gap: '5px'
                            }}
                          >
                            <Eye size={14} /> Xem tin nhắn
                          </button>
                          <button
                            type="button"
                            onClick={(e) => handleDeleteConversation(conv.id, e)}
                            style={{
                              background: '#fee2e2',
                              color: '#dc2626',
                              border: '1px solid #fca5a5',
                              borderRadius: '8px',
                              padding: '6px 10px',
                              fontSize: '12px',
                              fontWeight: '600',
                              cursor: 'pointer',
                              display: 'inline-flex',
                              alignItems: 'center',
                              gap: '4px',
                              transition: 'all 0.15s ease'
                            }}
                            onMouseEnter={(e) => {
                              e.currentTarget.style.backgroundColor = '#dc2626';
                              e.currentTarget.style.color = '#ffffff';
                            }}
                            onMouseLeave={(e) => {
                              e.currentTarget.style.backgroundColor = '#fee2e2';
                              e.currentTarget.style.color = '#dc2626';
                            }}
                            title="Xóa cuộc hội thoại này"
                          >
                            <Trash2 size={13} /> Xóa
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}

      {/* Main Settings Card: Kill-Switch & Cấu hình thông điệp */}
      <div className="card" style={{ padding: '28px', marginBottom: '32px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px', flexWrap: 'wrap', gap: '12px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <Bot size={24} color="var(--primary)" />
            <h3 style={{ fontSize: '18px', fontWeight: '700' }}>Cấu Hình Công Tắc Khẩn Cấp (Kill-Switch)</h3>
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
            <button
              type="button"
              onClick={handleToggleSwitch}
              disabled={saving}
              className={`btn btn-sm ${settings.isEnabled ? 'btn-danger' : 'btn-primary'}`}
              style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', fontWeight: '600' }}
            >
              <Power size={15} />
              {settings.isEnabled ? 'Tắt Khẩn Cấp Chatbot' : 'Bật Lại Chatbot'}
            </button>
            <button
              type="button"
              onClick={fetchData}
              className="btn btn-outline btn-sm"
              title="Làm mới dữ liệu"
            >
              <RefreshCw size={14} />
            </button>
          </div>
        </div>

        {/* Form Cấu hình Lời chào và Thông báo */}
        <form onSubmit={handleSaveSettings}>
          <div style={{ marginBottom: '20px' }}>
            <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '8px' }}>
              Lời chào mở đầu (Welcome Message)
            </label>
            <input
              type="text"
              value={settings.welcomeMessage}
              onChange={(e) => setSettings({ ...settings, welcomeMessage: e.target.value })}
              placeholder="VD: Xin chào! Mình là trợ lý AI của BookStore..."
              style={{
                width: '100%',
                padding: '12px 14px',
                borderRadius: '8px',
                border: '1px solid var(--border)',
                fontSize: '14px',
                outline: 'none'
              }}
            />
            <span style={{ fontSize: '12px', color: 'var(--text-muted)', display: 'block', marginTop: '4px' }}>
              Lời chào mặc định hiển thị khi người dùng mở khung chat lần đầu.
            </span>
          </div>

          <div style={{ marginBottom: '24px' }}>
            <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '8px' }}>
              Thông báo khi bảo trì / tắt hệ thống (System Notice)
            </label>
            <textarea
              rows={3}
              value={settings.systemNotice}
              onChange={(e) => setSettings({ ...settings, systemNotice: e.target.value })}
              placeholder="VD: Hệ thống trợ lý AI hiện đang tạm bảo trì nâng cấp, bạn vui lòng quay lại sau nhé!"
              style={{
                width: '100%',
                padding: '12px 14px',
                borderRadius: '8px',
                border: '1px solid var(--border)',
                fontSize: '14px',
                outline: 'none',
                resize: 'vertical'
              }}
            />
            <span style={{ fontSize: '12px', color: 'var(--text-muted)', display: 'block', marginTop: '4px' }}>
              Để trống nếu muốn sử dụng thông báo mặc định của hệ thống khi công tắc bị tắt.
            </span>
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: '14px' }}>
            <button
              type="submit"
              disabled={saving}
              className="btn btn-primary"
              style={{ display: 'inline-flex', alignItems: 'center', gap: '8px' }}
            >
              <Save size={16} />
              {saving ? 'Đang lưu...' : 'Lưu cấu hình'}
            </button>

            {saveSuccess && (
              <span style={{ color: '#16a34a', fontSize: '13px', fontWeight: '600', display: 'inline-flex', alignItems: 'center', gap: '5px' }}>
                <CheckCircle2 size={16} /> Cập nhật cấu hình thành công!
              </span>
            )}
          </div>
        </form>
      </div>

      {/* MODAL XEM CHI TIẾT TIN NHẮN TRONG CUỘC HỘI THOẠI */}
      {selectedConversation && (
        <div
          style={{
            position: 'fixed',
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            backgroundColor: 'rgba(15, 23, 42, 0.65)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 99999,
            padding: '20px'
          }}
          onClick={() => setSelectedConversation(null)}
        >
          <div
            style={{
              backgroundColor: '#ffffff',
              borderRadius: '16px',
              width: '560px',
              maxWidth: '100%',
              maxHeight: '85vh',
              display: 'flex',
              flexDirection: 'column',
              boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
              overflow: 'hidden'
            }}
            onClick={(e) => e.stopPropagation()}
          >
            {/* Modal Header */}
            <div style={{ 
              padding: '16px 20px', 
              borderBottom: '1px solid #e2e8f0', 
              display: 'flex', 
              justifyContent: 'space-between', 
              alignItems: 'center',
              backgroundColor: '#f8fafc'
            }}>
              <div>
                <h4 style={{ fontSize: '16px', fontWeight: '700', color: '#0f172a', margin: 0 }}>
                  {selectedConversation.title}
                </h4>
                <div style={{ fontSize: '12px', color: 'var(--text-muted)', marginTop: '3px' }}>
                  Khách: <strong>{selectedConversation.userName}</strong> ({selectedConversation.userEmail})
                </div>
              </div>

              <button
                type="button"
                onClick={() => setSelectedConversation(null)}
                style={{
                  background: 'none',
                  border: 'none',
                  color: '#64748b',
                  cursor: 'pointer',
                  padding: '6px'
                }}
              >
                <X size={20} />
              </button>
            </div>

            {/* Modal Messages Body */}
            <div style={{ flex: 1, overflowY: 'auto', padding: '20px', backgroundColor: '#f1f5f9', display: 'flex', flexDirection: 'column', gap: '12px' }}>
              {loadingDetail ? (
                <div style={{ textAlign: 'center', padding: '40px', color: '#64748b' }}>
                  Đang tải nội dung trao đổi...
                </div>
              ) : !conversationDetail || conversationDetail.messages.length === 0 ? (
                <div style={{ textAlign: 'center', padding: '40px', color: '#94a3b8' }}>
                  Cuộc trò chuyện này chưa có tin nhắn nào.
                </div>
              ) : (
                conversationDetail.messages.map((m, idx) => {
                  const isUser = m.role === 'user';
                  return (
                    <div 
                      key={m.id || idx} 
                      style={{ 
                        display: 'flex', 
                        flexDirection: 'column', 
                        alignItems: isUser ? 'flex-end' : 'flex-start' 
                      }}
                    >
                      <div style={{ fontSize: '11px', color: '#64748b', marginBottom: '3px', padding: '0 4px' }}>
                        {isUser ? selectedConversation.userName : 'Trợ lý AI'} • {new Date(m.createdAt).toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' })}
                      </div>
                      <div
                        style={{
                          maxWidth: '85%',
                          padding: '10px 14px',
                          borderRadius: isUser ? '16px 16px 4px 16px' : '16px 16px 16px 4px',
                          backgroundColor: isUser ? '#2563eb' : '#ffffff',
                          color: isUser ? '#ffffff' : '#1e293b',
                          border: isUser ? 'none' : '1px solid #e2e8f0',
                          fontSize: '13.5px',
                          lineHeight: 1.5,
                          whiteSpace: 'pre-wrap',
                          boxShadow: '0 1px 2px rgba(0,0,0,0.05)'
                        }}
                      >
                        {m.content}
                      </div>
                    </div>
                  );
                })
              )}
            </div>

            {/* Modal Footer */}
            <div style={{ padding: '12px 20px', borderTop: '1px solid #e2e8f0', display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#f8fafc' }}>
              <button
                type="button"
                onClick={() => handleDeleteConversation(selectedConversation.id)}
                style={{
                  background: '#fee2e2',
                  color: '#dc2626',
                  border: '1px solid #fca5a5',
                  borderRadius: '8px',
                  padding: '6px 14px',
                  fontSize: '12.5px',
                  fontWeight: '600',
                  cursor: 'pointer',
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: '5px',
                  transition: 'all 0.15s ease'
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.backgroundColor = '#dc2626';
                  e.currentTarget.style.color = '#ffffff';
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.backgroundColor = '#fee2e2';
                  e.currentTarget.style.color = '#dc2626';
                }}
              >
                <Trash2 size={14} /> Xóa cuộc hội thoại
              </button>
              <button
                type="button"
                onClick={() => setSelectedConversation(null)}
                className="btn btn-outline btn-sm"
              >
                Đóng
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
