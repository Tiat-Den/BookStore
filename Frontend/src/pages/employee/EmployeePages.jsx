import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { BookOpen, ShoppingBag, FolderTree, CheckCircle, Clock, Truck, Shield } from 'lucide-react';
import { bookService, orderService } from '../../services/catalogAndOrderServices';
import { LoadingSpinner } from '../../components/UIComponents';
import { ManagementHeader, renderOrderStatusBadge } from '../admin/AdminPages';

export const EmployeeDashboard = () => {
  const [stats, setStats] = useState({
    booksCount: 0,
    ordersCount: 0,
    pendingOrdersCount: 0,
    shippingOrdersCount: 0
  });
  const [recentOrders, setRecentOrders] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchEmployeeData = async () => {
      try {
        setLoading(true);
        const [booksRes, ordersRes] = await Promise.all([
          bookService.getBooks({ page: 1, pageSize: 1 }),
          orderService.getOrders({ page: 1, pageSize: 10 })
        ]);

        const booksTotal = booksRes.success ? booksRes.data.totalCount : 0;
        const ordersTotal = ordersRes.success ? ordersRes.data.totalCount : 0;
        const ordersList = ordersRes.success ? ordersRes.data.items : [];

        const pending = ordersList.filter(o => o.orderStatus === 'PENDING' || o.orderStatus === 'CONFIRMED').length;
        const shipping = ordersList.filter(o => o.orderStatus === 'SHIPPING' || o.orderStatus === 'PROCESSING').length;

        setStats({
          booksCount: booksTotal,
          ordersCount: ordersTotal,
          pendingOrdersCount: pending,
          shippingOrdersCount: shipping
        });
        setRecentOrders(ordersList.slice(0, 5));
      } catch (err) {
        console.error('Lỗi khi tải dữ liệu nhân viên:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchEmployeeData();
  }, []);

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val || 0);

  if (loading) return <LoadingSpinner text="Đang tải dữ liệu vận hành nhân viên..." />;

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <ManagementHeader
        title="Kênh Vận Hành & Bán Hàng"
        subtitle="Xử lý đơn hàng, điều phối vận chuyển và quản lý danh mục sách"
        activeTab="dashboard"
      />

      {/* KPI Cards */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '20px', marginBottom: '36px' }}>
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
          title="Tới trang Quản lý & Xử lý Đơn Hàng"
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', color: '#eab308', marginBottom: '12px' }}>
            <Clock size={28} />
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Đơn cần xử lý</span>
          <h2 style={{ fontSize: '30px', fontWeight: '800', marginTop: '4px', color: '#ca8a04' }}>{stats.pendingOrdersCount}</h2>
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
          title="Tới trang Quản lý & Xử lý Đơn Hàng"
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', color: '#0284c7', marginBottom: '12px' }}>
            <Truck size={28} />
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Đơn đang đóng gói / giao</span>
          <h2 style={{ fontSize: '30px', fontWeight: '800', marginTop: '4px', color: '#0284c7' }}>{stats.shippingOrdersCount}</h2>
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
          <div style={{ display: 'flex', justifyContent: 'space-between', color: 'var(--primary)', marginBottom: '12px' }}>
            <BookOpen size={28} />
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Tổng đầu sách</span>
          <h2 style={{ fontSize: '30px', fontWeight: '800', marginTop: '4px' }}>{stats.booksCount}</h2>
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
          title="Tới trang Quản lý & Xử lý Đơn Hàng"
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', color: '#16a34a', marginBottom: '12px' }}>
            <ShoppingBag size={28} />
          </div>
          <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Tổng đơn trong hệ thống</span>
          <h2 style={{ fontSize: '30px', fontWeight: '800', marginTop: '4px' }}>{stats.ordersCount}</h2>
        </Link>
      </div>

      {/* Recent Orders table */}
      <div className="card" style={{ padding: '0', overflow: 'hidden' }}>
        <div style={{ padding: '20px 24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid var(--border)' }}>
          <h3 style={{ fontSize: '17px', fontWeight: '700' }}>Đơn Hàng Gần Đây Cần Theo Dõi</h3>
          <Link to="/admin/orders" style={{ fontSize: '13px', fontWeight: '600', color: 'var(--primary)' }}>Tới trang Xử lý Đơn Hàng →</Link>
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
              {recentOrders.map((o) => (
                <tr key={o.id}>
                  <td><strong>{o.orderCode}</strong></td>
                  <td>{o.customerName}</td>
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
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};
