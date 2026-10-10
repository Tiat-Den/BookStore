import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { BookOpen, FolderTree, ShoppingBag, Plus, Trash2, Edit, Check, X, Shield, ArrowUpRight, Users, TrendingUp, Award, BarChart3 } from 'lucide-react';
import { bookService, categoryService, orderService, reportService } from '../../services/catalogAndOrderServices';
import { LoadingSpinner } from '../../components/UIComponents';
import { useAuth } from '../../context/AuthContext';

export const renderOrderStatusBadge = (status) => {
  switch (status) {
    case 'PENDING':
    case 'CONFIRMED':
      return (
        <span 
          className="badge" 
          style={{ 
            backgroundColor: '#fef3c7', 
            color: '#b45309', 
            border: '1px solid #fde68a',
            fontWeight: '700',
            letterSpacing: '0.3px'
          }}
        >
          {status}
        </span>
      );
    case 'PROCESSING':
    case 'SHIPPING':
      return (
        <span 
          className="badge" 
          style={{ 
            backgroundColor: '#e0f2fe', 
            color: '#0284c7', 
            border: '1px solid #bae6fd',
            fontWeight: '600'
          }}
        >
          {status}
        </span>
      );
    case 'DELIVERED':
      return (
        <span 
          className="badge badge-success"
          style={{ fontWeight: '600' }}
        >
          {status}
        </span>
      );
    case 'CANCELLED':
      return (
        <span 
          className="badge badge-danger"
          style={{ fontWeight: '600' }}
        >
          {status}
        </span>
      );
    default:
      return <span className="badge badge-neutral">{status}</span>;
  }
};

export const ManagementHeader = ({ title, subtitle, activeTab, actionButton }) => {
  const { isAdmin } = useAuth();
  const dashboardLink = isAdmin ? '/admin' : '/employee';
  const portalBadge = isAdmin ? 'ADMIN PORTAL' : 'EMPLOYEE WORKSPACE';
  const portalBg = isAdmin ? '#dbeafe' : '#dcfce7';
  const portalColor = isAdmin ? '#1d4ed8' : '#166534';

  return (
    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '28px', flexWrap: 'wrap', gap: '16px' }}>
      <div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          <span style={{ fontSize: '11px', background: portalBg, color: portalColor, padding: '3px 8px', borderRadius: '4px', fontWeight: '800' }}>
            {portalBadge}
          </span>
        </div>
        <h1 style={{ fontSize: '26px', fontWeight: '800', marginTop: '4px' }}>{title}</h1>
        {subtitle && <p style={{ fontSize: '13px', color: 'var(--text-muted)' }}>{subtitle}</p>}
      </div>

      <div style={{ display: 'flex', gap: '8px', flexWrap: 'wrap', alignItems: 'center' }}>
        <Link to={dashboardLink} className={`btn btn-sm ${activeTab === 'dashboard' ? 'btn-primary' : 'btn-outline'}`}>
          Dashboard
        </Link>
        <Link to="/admin/books" className={`btn btn-sm ${activeTab === 'books' ? 'btn-primary' : 'btn-outline'}`}>
          Quản lý Sách
        </Link>
        <Link to="/admin/orders" className={`btn btn-sm ${activeTab === 'orders' ? 'btn-primary' : 'btn-outline'}`}>
          Quản lý Đơn Hàng
        </Link>
        <Link to="/admin/coupons" className={`btn btn-sm ${activeTab === 'coupons' ? 'btn-primary' : 'btn-outline'}`}>
          Mã Khuyến Mãi
        </Link>
        {isAdmin && (
          <Link to="/admin/users" className={`btn btn-sm ${activeTab === 'users' ? 'btn-primary' : 'btn-outline'}`}>
            Quản lý Tài Khoản
          </Link>
        )}
        {actionButton}
      </div>
    </div>
  );
};

export const AdminDashboard = () => {
  const [stats, setStats] = useState({
    totalRevenue: 0,
    totalOrders: 0,
    totalBooks: 0,
    totalCustomers: 0,
    orderStatusCounts: [],
    revenueByMonth: [],
    topSellingBooks: [],
    recentOrders: []
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchDashboard = async () => {
      try {
        setLoading(true);
        const res = await reportService.getDashboardStats();
        if (res.success && res.data) {
          setStats(res.data);
        } else {
          // Fallback if reports not available yet
          const [booksRes, ordersRes] = await Promise.all([
            bookService.getBooks({ page: 1, pageSize: 1 }),
            orderService.getOrders({ page: 1, pageSize: 5 })
          ]);
          setStats(prev => ({
            ...prev,
            totalBooks: booksRes.success ? booksRes.data.totalCount : 0,
            totalOrders: ordersRes.success ? ordersRes.data.totalCount : 0,
            recentOrders: ordersRes.success ? ordersRes.data.items : []
          }));
        }
      } catch (err) {
        console.error('Lỗi khi tải dashboard:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchDashboard();
  }, []);

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val || 0);

  const revenueByMonth = stats?.revenueByMonth || [];
  const orderStatusCounts = stats?.orderStatusCounts || [];
  const topSellingBooks = stats?.topSellingBooks || [];
  const recentOrders = stats?.recentOrders || [];
  const maxRevenue = Math.max(...(revenueByMonth.map(m => m.revenue) || [1]), 1);

  if (loading) return <LoadingSpinner text="Đang tải dữ liệu báo cáo kinh doanh..." />;

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <ManagementHeader
        title="Hệ Thống Quản Trị BookStore"
        subtitle="Báo cáo doanh thu & giám sát vận hành thương mại điện tử"
        activeTab="dashboard"
      />

      {/* KPI Stats Cards */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(230px, 1fr))', gap: '20px', marginBottom: '36px' }}>
        <Link
          to="/admin/orders"
          className="card"
          style={{
            padding: '24px',
            textDecoration: 'none',
            color: 'inherit',
            display: 'block',
            transition: 'transform 0.2s, box-shadow 0.2s',
            cursor: 'pointer'
          }}
          onMouseEnter={(e) => { e.currentTarget.style.transform = 'translateY(-3px)'; e.currentTarget.style.boxShadow = '0 8px 20px rgba(0,0,0,0.08)'; }}
          onMouseLeave={(e) => { e.currentTarget.style.transform = 'translateY(0)'; e.currentTarget.style.boxShadow = 'none'; }}
          title="Xem danh sách đơn hàng & doanh thu"
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', color: '#16a34a', marginBottom: '12px' }}>
            <TrendingUp size={28} />
            <span style={{ fontSize: '12px', background: '#dcfce7', color: '#16a34a', padding: '3px 8px', borderRadius: '12px', fontWeight: '600' }}>Thực thu</span>
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Tổng doanh thu (PAID)</span>
          <h2 style={{ fontSize: '28px', fontWeight: '800', marginTop: '4px', color: '#16a34a' }}>
            {formatPrice(stats.totalRevenue)}
          </h2>
        </Link>

        <Link
          to="/admin/orders"
          className="card"
          style={{
            padding: '24px',
            textDecoration: 'none',
            color: 'inherit',
            display: 'block',
            transition: 'transform 0.2s, box-shadow 0.2s',
            cursor: 'pointer'
          }}
          onMouseEnter={(e) => { e.currentTarget.style.transform = 'translateY(-3px)'; e.currentTarget.style.boxShadow = '0 8px 20px rgba(0,0,0,0.08)'; }}
          onMouseLeave={(e) => { e.currentTarget.style.transform = 'translateY(0)'; e.currentTarget.style.boxShadow = 'none'; }}
          title="Tới trang Quản lý Đơn Hàng"
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', color: 'var(--primary)', marginBottom: '12px' }}>
            <ShoppingBag size={28} />
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Tổng đơn hàng</span>
          <h2 style={{ fontSize: '28px', fontWeight: '800', marginTop: '4px' }}>{stats.totalOrders}</h2>
        </Link>

        <Link
          to="/admin/books"
          className="card"
          style={{
            padding: '24px',
            textDecoration: 'none',
            color: 'inherit',
            display: 'block',
            transition: 'transform 0.2s, box-shadow 0.2s',
            cursor: 'pointer'
          }}
          onMouseEnter={(e) => { e.currentTarget.style.transform = 'translateY(-3px)'; e.currentTarget.style.boxShadow = '0 8px 20px rgba(0,0,0,0.08)'; }}
          onMouseLeave={(e) => { e.currentTarget.style.transform = 'translateY(0)'; e.currentTarget.style.boxShadow = 'none'; }}
          title="Tới trang Quản lý Kho Sách"
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', color: 'var(--secondary)', marginBottom: '12px' }}>
            <BookOpen size={28} />
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Đầu sách đang bán</span>
          <h2 style={{ fontSize: '28px', fontWeight: '800', marginTop: '4px' }}>{stats.totalBooks}</h2>
        </Link>

        <Link
          to="/admin/users"
          className="card"
          style={{
            padding: '24px',
            textDecoration: 'none',
            color: 'inherit',
            display: 'block',
            transition: 'transform 0.2s, box-shadow 0.2s',
            cursor: 'pointer'
          }}
          onMouseEnter={(e) => { e.currentTarget.style.transform = 'translateY(-3px)'; e.currentTarget.style.boxShadow = '0 8px 20px rgba(0,0,0,0.08)'; }}
          onMouseLeave={(e) => { e.currentTarget.style.transform = 'translateY(0)'; e.currentTarget.style.boxShadow = 'none'; }}
          title="Tới trang Quản lý Tài Khoản"
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', color: '#8b5cf6', marginBottom: '12px' }}>
            <Users size={28} />
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Thành viên hệ thống</span>
          <h2 style={{ fontSize: '28px', fontWeight: '800', marginTop: '4px' }}>{stats.totalCustomers}</h2>
        </Link>
      </div>

      {/* Row: Biểu đồ doanh thu & Trạng thái đơn hàng */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '24px', marginBottom: '36px' }}>
        {/* Doanh thu các tháng gần đây */}
        <div className="card" style={{ padding: '24px' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
              <BarChart3 size={20} color="var(--primary)" />
              <h3 style={{ fontSize: '16px', fontWeight: '700' }}>Doanh Thu 6 Tháng Gần Nhất</h3>
            </div>
            <span style={{ fontSize: '12px', color: 'var(--text-muted)' }}>VND</span>
          </div>

          <div style={{ display: 'flex', alignItems: 'flex-end', gap: '16px', height: '180px', paddingTop: '20px' }}>
            {revenueByMonth && revenueByMonth.length > 0 ? (
              revenueByMonth.map((m, idx) => {
                const heightPercent = maxRevenue > 0 ? Math.max((m.revenue / maxRevenue) * 100, 8) : 8;
                const monthLabel = m.month || m.Month || `T${idx + 1}`;
                return (
                  <div key={idx} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', height: '100%', justifyContent: 'flex-end' }}>
                    <div style={{ fontSize: '11px', fontWeight: '600', color: 'var(--text-muted)', marginBottom: '4px' }}>
                      {m.revenue > 0 ? `${(m.revenue / 1000).toFixed(0)}k` : '0'}
                    </div>
                    <div
                      style={{
                        width: '100%',
                        maxWidth: '44px',
                        height: `${heightPercent}%`,
                        backgroundColor: 'var(--primary)',
                        borderRadius: '6px 6px 0 0',
                        transition: 'height 0.4s ease',
                        opacity: m.revenue > 0 ? 0.9 : 0.3
                      }}
                      title={`${monthLabel}: ${formatPrice(m.revenue)} (${m.orderCount} đơn)`}
                    />
                    <div style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '8px' }}>{monthLabel}</div>
                  </div>
                );
              })
            ) : (
              <p style={{ color: 'var(--text-muted)', fontSize: '14px', margin: 'auto' }}>Chưa có dữ liệu doanh thu</p>
            )}
          </div>
        </div>

        {/* Trạng thái đơn hàng */}
        <div className="card" style={{ padding: '24px' }}>
          <h3 style={{ fontSize: '16px', fontWeight: '700', marginBottom: '20px' }}>Trạng Thái Đơn Hàng</h3>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
            {orderStatusCounts && orderStatusCounts.length > 0 ? (
              orderStatusCounts.map((sc) => (
                <div key={sc.status} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '10px 14px', background: '#f8fafc', borderRadius: '8px' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                    {renderOrderStatusBadge(sc.status)}
                  </div>
                  <span style={{ fontWeight: '700', fontSize: '15px' }}>{sc.count} đơn</span>
                </div>
              ))
            ) : (
              <p style={{ color: 'var(--text-muted)', fontSize: '14px' }}>Chưa có dữ liệu đơn hàng</p>
            )}
          </div>
        </div>
      </div>

      {/* Row: Top sách bán chạy nhất */}
      <div className="card" style={{ padding: '24px', marginBottom: '36px' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '20px' }}>
          <Award size={20} color="#eab308" />
          <h3 style={{ fontSize: '16px', fontWeight: '700' }}>Top Sách Bán Chạy Nhất</h3>
        </div>

        {topSellingBooks && topSellingBooks.length > 0 ? (
          <div className="table-responsive">
            <table className="table">
              <thead>
                <tr>
                  <th>Sách</th>
                  <th>Số Lượng Bán</th>
                  <th>Doanh Số Đạt Được</th>
                </tr>
              </thead>
              <tbody>
                {topSellingBooks.map((book) => (
                  <tr key={book.bookId}>
                    <td>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                        {book.imageUrl && (
                          <img
                            src={book.imageUrl}
                            alt={book.title}
                            style={{ width: '40px', height: '54px', objectFit: 'cover', borderRadius: '4px' }}
                            onError={(e) => {
                              e.currentTarget.onerror = null;
                              e.currentTarget.src = 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=100&q=80';
                            }}
                          />
                        )}
                        <strong>{book.title}</strong>
                      </div>
                    </td>
                    <td><span className="badge badge-success">{book.quantitySold} quyển</span></td>
                    <td><strong>{formatPrice(book.totalRevenue)}</strong></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : (
          <p style={{ color: 'var(--text-muted)', fontSize: '14px' }}>Chưa có thống kê sách bán chạy.</p>
        )}
      </div>

      {/* Recent Orders table */}
      <div className="card" style={{ padding: '0', overflow: 'hidden' }}>
        <div style={{ padding: '20px 24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid var(--border)' }}>
          <h3 style={{ fontSize: '17px', fontWeight: '700' }}>Đơn Hàng Gần Đây</h3>
          <Link to="/admin/orders" style={{ fontSize: '13px', fontWeight: '600', color: 'var(--primary)' }}>Xem tất cả</Link>
        </div>

        <div className="table-responsive">
          <table className="table">
            <thead>
              <tr>
                <th>Mã Đơn</th>
                <th>Khách Hàng</th>
                <th>Tổng Tiền</th>
                <th>Thanh Toán</th>
                <th>Trạng Thái</th>
                <th>Ngày Đặt</th>
              </tr>
            </thead>
            <tbody>
              {recentOrders.length > 0 ? (
                recentOrders.map((o) => (
                  <tr key={o.id}>
                    <td><strong>{o.orderCode}</strong></td>
                    <td>{o.customerName || 'Khách hàng'}</td>
                    <td><strong>{formatPrice(o.totalAmount)}</strong></td>
                    <td>
                      <span className={`badge ${o.paymentStatus === 'PAID' ? 'badge-success' : 'badge-neutral'}`}>
                        {o.paymentStatus}
                      </span>
                    </td>
                    <td>
                      {renderOrderStatusBadge(o.orderStatus)}
                    </td>
                    <td>{new Date(o.createdAt).toLocaleDateString('vi-VN')}</td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan="6" style={{ textAlign: 'center', padding: '24px', color: 'var(--text-muted)' }}>
                    Chưa có đơn hàng nào gần đây
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export const AdminBooks = () => {
  const [books, setBooks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editingBookId, setEditingBookId] = useState(null);
  const [formData, setFormData] = useState({
    isbn: '',
    title: '',
    authorName: '',
    salePrice: 100000,
    importPrice: 60000,
    discountPrice: 90000,
    stockQuantity: 50,
    description: '',
    coverImageUrl: ''
  });

  const fetchBooks = async () => {
    setLoading(true);
    try {
      const res = await bookService.getBooks({ page: 1, pageSize: 50 });
      if (res.success && res.data) setBooks(res.data.items);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchBooks();
  }, []);

  const handleOpenCreate = () => {
    setEditingBookId(null);
    setFormData({
      isbn: '',
      title: '',
      authorName: '',
      salePrice: 100000,
      importPrice: 60000,
      discountPrice: '',
      stockQuantity: 50,
      description: '',
      coverImageUrl: ''
    });
    setShowModal(true);
  };

  const handleOpenEdit = (b) => {
    setEditingBookId(b.id);
    const currentAuthor = b.authors && b.authors.length > 0 ? b.authors.map(a => a.name).join(', ') : '';
    setFormData({
      isbn: b.isbn || '',
      title: b.title || '',
      authorName: currentAuthor,
      salePrice: b.salePrice ?? 0,
      importPrice: b.importPrice ?? 0,
      discountPrice: b.discountPrice ?? '',
      stockQuantity: b.stockQuantity ?? 0,
      description: b.description || '',
      coverImageUrl: b.coverImageUrl || '',
      status: b.status ?? 1
    });
    setShowModal(true);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const payload = {
      ...formData,
      salePrice: Number(formData.salePrice),
      importPrice: Number(formData.importPrice) || 0,
      discountPrice: formData.discountPrice !== '' && formData.discountPrice !== null ? Number(formData.discountPrice) : null,
      stockQuantity: Number(formData.stockQuantity) || 0,
      status: formData.status ?? 1
    };

    let res;
    if (editingBookId) {
      res = await bookService.updateBook(editingBookId, payload);
    } else {
      res = await bookService.createBook(payload);
    }

    if (res.success) {
      alert(editingBookId ? 'Cập nhật thông tin sách thành công!' : 'Tạo sách mới thành công!');
      setShowModal(false);
      fetchBooks();
    } else {
      alert(res.message || 'Thao tác không thành công.');
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Bạn có chắc chắn muốn xóa cuốn sách này không?')) return;
    const res = await bookService.deleteBook(id);
    if (res.success) {
      alert('Đã xóa mềm sách thành công.');
      fetchBooks();
    } else {
      alert(res.message);
    }
  };

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <ManagementHeader
        title="Quản Lý Kho Sách"
        activeTab="books"
      />

      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px', flexWrap: 'wrap', gap: '12px' }}>
        <div style={{ fontSize: '14px', color: 'var(--text-muted)', fontWeight: '500' }}>
          Tổng số đầu sách: <strong>{books.length}</strong>
        </div>
        <button 
          onClick={handleOpenCreate} 
          className="btn btn-primary" 
          style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', padding: '8px 18px', fontWeight: '600' }}
        >
          <Plus size={16} /> Thêm Sách Mới
        </button>
      </div>

      {loading ? (
        <LoadingSpinner />
      ) : (
        <div className="card" style={{ padding: '0', overflow: 'hidden' }}>
          <div className="table-responsive">
            <table className="table">
              <thead>
                <tr>
                  <th>Sách</th>
                  <th>Tác Giả</th>
                  <th>ISBN</th>
                  <th>Giá Bán</th>
                  <th>Giá Khuyến Mãi</th>
                  <th>Tồn Kho</th>
                  <th>Đã Bán</th>
                  <th>Thao tác</th>
                </tr>
              </thead>
              <tbody>
                {books.map((b) => (
                  <tr key={b.id}>
                    <td>
                      <div style={{ display: 'flex', gap: '12px', alignItems: 'center' }}>
                        <img
                          src={b.coverImageUrl || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=100&q=80'}
                          alt={b.title}
                          style={{ width: '40px', height: '54px', objectFit: 'cover', borderRadius: '4px' }}
                          onError={(e) => {
                            e.currentTarget.onerror = null;
                            e.currentTarget.src = 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=100&q=80';
                          }}
                        />
                        <strong style={{ fontSize: '14px' }}>{b.title}</strong>
                      </div>
                    </td>
                    <td>
                      <span style={{ fontSize: '13px', color: 'var(--text-main)', fontWeight: '600' }}>
                        {b.authors && b.authors.length > 0 ? b.authors.map(a => a.name).join(', ') : 'Chưa có'}
                      </span>
                    </td>
                    <td>{b.isbn}</td>
                    <td>{formatPrice(b.salePrice)}</td>
                    <td>{b.discountPrice ? formatPrice(b.discountPrice) : '-'}</td>
                    <td><strong>{b.stockQuantity}</strong></td>
                    <td>{b.soldQuantity}</td>
                    <td>
                      <div style={{ display: 'flex', gap: '8px' }}>
                        <button onClick={() => handleOpenEdit(b)} className="btn btn-outline btn-sm" title="Chỉnh sửa sách">
                          <Edit size={15} />
                        </button>
                        <button onClick={() => handleDelete(b.id)} className="btn btn-danger btn-sm" title="Xóa sách">
                          <Trash2 size={15} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Add / Edit Modal */}
      {showModal && (
        <div className="modal-overlay">
          <div className="modal-content">
            <div className="modal-header">
              <h3 style={{ fontSize: '18px', fontWeight: '700' }}>
                {editingBookId ? 'Chỉnh Sửa Thông Tin Sách' : 'Thêm Cuốn Sách Mới'}
              </h3>
              <button onClick={() => setShowModal(false)} style={{ border: 'none', background: 'none', cursor: 'pointer' }}>
                <X size={20} />
              </button>
            </div>
            <form onSubmit={handleSubmit}>
              <div className="modal-body">
                <div className="form-group">
                  <label className="form-label">Tên sách *</label>
                  <input
                    type="text"
                    className="input"
                    required
                    value={formData.title}
                    onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                  />
                </div>

                <div className="form-group">
                  <label className="form-label">Tác giả *</label>
                  <input
                    type="text"
                    className="input"
                    required
                    placeholder="Nhập tên tác giả (VD: Dale Carnegie, Robert C. Martin, Nguyễn Nhật Ánh...)"
                    value={formData.authorName}
                    onChange={(e) => setFormData({ ...formData, authorName: e.target.value })}
                  />
                </div>

                <div className="form-group">
                  <label className="form-label">Mã ISBN *</label>
                  <input
                    type="text"
                    className="input"
                    required
                    disabled={!!editingBookId}
                    title={editingBookId ? "Mã ISBN không thể thay đổi sau khi tạo" : ""}
                    value={formData.isbn}
                    onChange={(e) => setFormData({ ...formData, isbn: e.target.value })}
                  />
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' }}>
                  <div className="form-group">
                    <label className="form-label">Giá bán (VNĐ) *</label>
                    <input
                      type="number"
                      className="input"
                      required
                      value={formData.salePrice}
                      onChange={(e) => setFormData({ ...formData, salePrice: parseFloat(e.target.value) || 0 })}
                    />
                  </div>

                  <div className="form-group">
                    <label className="form-label">Giá khuyến mãi (VNĐ)</label>
                    <input
                      type="number"
                      className="input"
                      value={formData.discountPrice}
                      onChange={(e) => setFormData({ ...formData, discountPrice: e.target.value === '' ? '' : parseFloat(e.target.value) || 0 })}
                    />
                  </div>
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' }}>
                  <div className="form-group">
                    <label className="form-label">Giá nhập kho (VNĐ)</label>
                    <input
                      type="number"
                      className="input"
                      value={formData.importPrice}
                      onChange={(e) => setFormData({ ...formData, importPrice: parseFloat(e.target.value) || 0 })}
                    />
                  </div>

                  <div className="form-group">
                    <label className="form-label">Số lượng tồn kho</label>
                    <input
                      type="number"
                      className="input"
                      value={formData.stockQuantity}
                      onChange={(e) => setFormData({ ...formData, stockQuantity: parseInt(e.target.value) || 0 })}
                    />
                  </div>
                </div>

                <div className="form-group">
                  <label className="form-label">URL Ảnh Bìa</label>
                  <input
                    type="url"
                    className="input"
                    placeholder="https://..."
                    value={formData.coverImageUrl}
                    onChange={(e) => setFormData({ ...formData, coverImageUrl: e.target.value })}
                  />
                </div>

                <div className="form-group" style={{ marginBottom: 0 }}>
                  <label className="form-label">Mô tả tác phẩm</label>
                  <textarea
                    className="textarea"
                    rows="3"
                    value={formData.description}
                    onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                  />
                </div>
              </div>

              <div className="modal-footer">
                <button type="button" onClick={() => setShowModal(false)} className="btn btn-outline">Hủy</button>
                <button type="submit" className="btn btn-primary">
                  {editingBookId ? 'Cập Nhật' : 'Lưu Sách'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export const AdminOrders = () => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchOrders = async () => {
    setLoading(true);
    try {
      const res = await orderService.getOrders({ page: 1, pageSize: 50 });
      if (res.success && res.data) setOrders(res.data.items);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchOrders();
  }, []);

  const handleStatusChange = async (orderId, newStatus) => {
    if (!window.confirm(`Xác nhận chuyển trạng thái sang "${newStatus}"?`)) return;
    const res = await orderService.updateStatus(orderId, newStatus);
    if (res.success) {
      alert('Cập nhật trạng thái đơn thành công!');
      fetchOrders();
    } else {
      alert(res.message);
    }
  };

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <ManagementHeader
        title="Quản Lý Đơn Hàng"
        activeTab="orders"
      />

      {loading ? (
        <LoadingSpinner />
      ) : (
        <div className="card" style={{ padding: '0', overflow: 'hidden' }}>
          <div className="table-responsive">
            <table className="table">
              <thead>
                <tr>
                  <th>Mã Đơn</th>
                  <th>Khách Hàng</th>
                  <th>Tổng Tiền</th>
                  <th>Phương Thức</th>
                  <th>Trạng Thái</th>
                  <th>Cập Nhật Trạng Thái</th>
                </tr>
              </thead>
              <tbody>
                {orders.map((o) => (
                  <tr key={o.id}>
                    <td><strong>{o.orderCode}</strong></td>
                    <td>
                      <div>{o.customerName}</div>
                      <small style={{ color: 'var(--text-muted)' }}>{o.shipment?.phone}</small>
                    </td>
                    <td><strong style={{ color: 'var(--primary)' }}>{formatPrice(o.totalAmount)}</strong></td>
                    <td>{o.paymentMethod}</td>
                    <td>
                      {renderOrderStatusBadge(o.orderStatus)}
                    </td>
                    <td>
                      <select
                        className="select"
                        value={o.orderStatus}
                        onChange={(e) => handleStatusChange(o.id, e.target.value)}
                        style={{ padding: '6px 10px', fontSize: '13px', width: '160px' }}
                      >
                        <option value="PENDING">PENDING</option>
                        <option value="CONFIRMED">CONFIRMED</option>
                        <option value="PROCESSING">PROCESSING</option>
                        <option value="SHIPPING">SHIPPING</option>
                        <option value="DELIVERED">DELIVERED</option>
                        <option value="CANCELLED">CANCELLED</option>
                      </select>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
};

export const AdminCoupons = () => {
  const [coupons, setCoupons] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [formData, setFormData] = useState({
    code: '',
    name: '',
    type: 'PERCENT',
    value: 10,
    minimumOrderAmount: 100000,
    maximumDiscountAmount: 50000,
    usageLimit: 100
  });

  const fetchCoupons = async () => {
    setLoading(true);
    try {
      const res = await (await import('../../services/marketingServices')).couponService.getCoupons();
      if (res.success && res.data) setCoupons(res.data);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchCoupons();
  }, []);

  const handleCreate = async (e) => {
    e.preventDefault();
    const res = await (await import('../../services/marketingServices')).couponService.createCoupon(formData);
    if (res.success) {
      alert('Tạo mã giảm giá thành công!');
      setShowModal(false);
      fetchCoupons();
    } else {
      alert(res.message);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Xác nhận xóa mã giảm giá này?')) return;
    const res = await (await import('../../services/marketingServices')).couponService.deleteCoupon(id);
    if (res.success) {
      alert('Đã xóa mã giảm giá.');
      fetchCoupons();
    } else {
      alert(res.message);
    }
  };

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <ManagementHeader
        title="Quản Lý Mã Giảm Giá"
        activeTab="coupons"
      />

      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px', flexWrap: 'wrap', gap: '12px' }}>
        <div style={{ fontSize: '14px', color: 'var(--text-muted)', fontWeight: '500' }}>
          Tổng số mã khuyến mãi: <strong>{coupons.length}</strong>
        </div>
        <button 
          onClick={() => setShowModal(true)} 
          className="btn btn-primary" 
          style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', padding: '8px 18px', fontWeight: '600' }}
        >
          <Plus size={16} /> Thêm Mã Mới
        </button>
      </div>

      {loading ? (
        <LoadingSpinner />
      ) : (
        <div className="card" style={{ padding: '0', overflow: 'hidden' }}>
          <div className="table-responsive">
            <table className="table">
              <thead>
                <tr>
                  <th>Mã Voucher</th>
                  <th>Tên Chương Trình</th>
                  <th>Loại Giảm</th>
                  <th>Giá Trị</th>
                  <th>Đơn Tối Thiểu</th>
                  <th>Lượt Dùng</th>
                  <th>Trạng Thái</th>
                  <th>Thao Tác</th>
                </tr>
              </thead>
              <tbody>
                {coupons.map((c) => (
                  <tr key={c.id}>
                    <td><strong className="badge badge-primary">{c.code}</strong></td>
                    <td>{c.name}</td>
                    <td>{c.type === 'PERCENT' ? 'Phần trăm (%)' : 'Cố định (VNĐ)'}</td>
                    <td><strong>{c.type === 'PERCENT' ? `${c.value}%` : formatPrice(c.value)}</strong></td>
                    <td>{formatPrice(c.minimumOrderAmount)}</td>
                    <td>{c.usedCount} / {c.usageLimit}</td>
                    <td>
                      <span className={`badge ${c.isActive ? 'badge-success' : 'badge-danger'}`}>
                        {c.isActive ? 'Hoạt động' : 'Hết hạn'}
                      </span>
                    </td>
                    <td>
                      <button onClick={() => handleDelete(c.id)} className="btn btn-danger btn-sm" title="Xóa mã">
                        <Trash2 size={15} />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Modal Add Coupon */}
      {showModal && (
        <div className="modal-overlay">
          <div className="modal-content">
            <div className="modal-header">
              <h3 style={{ fontSize: '18px', fontWeight: '700' }}>Tạo Mã Giảm Giá Mới</h3>
              <button onClick={() => setShowModal(false)} style={{ border: 'none', background: 'none', cursor: 'pointer' }}>
                <X size={20} />
              </button>
            </div>
            <form onSubmit={handleCreate}>
              <div className="modal-body">
                <div className="form-group">
                  <label className="form-label">Mã code (Viết hoa không dấu) *</label>
                  <input
                    type="text"
                    className="input"
                    required
                    placeholder="VD: HELLO2026"
                    value={formData.code}
                    onChange={(e) => setFormData({ ...formData, code: e.target.value.toUpperCase() })}
                  />
                </div>

                <div className="form-group">
                  <label className="form-label">Tên chương trình *</label>
                  <input
                    type="text"
                    className="input"
                    required
                    placeholder="VD: Giảm 20% mừng năm mới"
                    value={formData.name}
                    onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                  />
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' }}>
                  <div className="form-group">
                    <label className="form-label">Loại giảm giá</label>
                    <select
                      className="select"
                      value={formData.type}
                      onChange={(e) => setFormData({ ...formData, type: e.target.value })}
                    >
                      <option value="PERCENT">Phần trăm (%)</option>
                      <option value="FIXED_AMOUNT">Số tiền cố định (VNĐ)</option>
                    </select>
                  </div>

                  <div className="form-group">
                    <label className="form-label">Giá trị giảm *</label>
                    <input
                      type="number"
                      className="input"
                      required
                      value={formData.value}
                      onChange={(e) => setFormData({ ...formData, value: parseFloat(e.target.value) || 0 })}
                    />
                  </div>
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' }}>
                  <div className="form-group">
                    <label className="form-label">Đơn tối thiểu (VNĐ)</label>
                    <input
                      type="number"
                      className="input"
                      value={formData.minimumOrderAmount}
                      onChange={(e) => setFormData({ ...formData, minimumOrderAmount: parseFloat(e.target.value) || 0 })}
                    />
                  </div>

                  <div className="form-group">
                    <label className="form-label">Giới hạn số lượt dùng</label>
                    <input
                      type="number"
                      className="input"
                      value={formData.usageLimit}
                      onChange={(e) => setFormData({ ...formData, usageLimit: parseInt(e.target.value) || 100 })}
                    />
                  </div>
                </div>
              </div>

              <div className="modal-footer">
                <button type="button" onClick={() => setShowModal(false)} className="btn btn-outline">Hủy</button>
                <button type="submit" className="btn btn-primary">Lưu Voucher</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};
