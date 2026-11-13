import React, { useState, useEffect } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import { Package, Clock, CheckCircle2, XCircle, Truck, AlertCircle } from 'lucide-react';
import { orderService } from '../services/catalogAndOrderServices';
import { LoadingSpinner } from '../components/UIComponents';

export const Orders = () => {
  const [searchParams] = useSearchParams();
  const successCode = searchParams.get('success');

  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [cancellingId, setCancellingId] = useState(null);

  const fetchOrders = async () => {
    try {
      setLoading(true);
      const res = await orderService.getMyOrders();
      if (res.success && res.data) {
        setOrders(res.data.items);
      }
    } catch (err) {
      console.error('Lỗi khi tải đơn hàng:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchOrders();
  }, []);

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  const handleCancelOrder = async (orderId) => {
    const reason = prompt('Vui lòng nhập lý do hủy đơn hàng:');
    if (!reason || !reason.trim()) return;

    setCancellingId(orderId);
    try {
      const res = await orderService.cancelOrder(orderId, reason.trim());
      if (res.success) {
        alert('Hủy đơn hàng thành công và đã hoàn trả lại số lượng tồn kho.');
        fetchOrders();
      } else {
        alert(res.message);
      }
    } catch (err) {
      alert(err.message || 'Lỗi khi hủy đơn hàng.');
    } finally {
      setCancellingId(null);
    }
  };

  const getStatusBadge = (status) => {
    switch (status) {
      case 'PENDING':
        return <span className="badge badge-warning"><Clock size={14} style={{ marginRight: 4 }} /> Chờ xác nhận</span>;
      case 'CONFIRMED':
        return <span className="badge badge-primary"><CheckCircle2 size={14} style={{ marginRight: 4 }} /> Đã xác nhận</span>;
      case 'PROCESSING':
        return <span className="badge badge-primary">Đang chuẩn bị hàng</span>;
      case 'SHIPPING':
        return <span className="badge badge-primary"><Truck size={14} style={{ marginRight: 4 }} /> Đang giao hàng</span>;
      case 'DELIVERED':
        return <span className="badge badge-success"><CheckCircle2 size={14} style={{ marginRight: 4 }} /> Giao thành công</span>;
      case 'CANCELLED':
        return <span className="badge badge-danger"><XCircle size={14} style={{ marginRight: 4 }} /> Đã hủy</span>;
      default:
        return <span className="badge badge-neutral">{status}</span>;
    }
  };

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      {successCode && (
        <div style={{ backgroundColor: '#dcfce7', color: '#166534', padding: '16px 20px', borderRadius: 'var(--radius)', marginBottom: '32px', display: 'flex', alignItems: 'center', gap: '12px' }}>
          <CheckCircle2 size={24} />
          <div>
            <strong style={{ display: 'block', fontSize: '15px' }}>Đặt hàng thành công! Mã đơn: {successCode}</strong>
            <span style={{ fontSize: '13px' }}>Chúng tôi sẽ liên hệ sớm nhất để xác nhận và giao sách đến bạn.</span>
          </div>
        </div>
      )}

      <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '24px' }}>
        Lịch Sử Đơn Hàng Của Tôi
      </h1>

      {loading ? (
        <LoadingSpinner text="Đang tải danh sách đơn hàng..." />
      ) : orders.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '60px 20px' }}>
          <Package size={56} color="var(--text-light)" style={{ margin: '0 auto 16px' }} />
          <h3 style={{ fontSize: '18px', fontWeight: '700', marginBottom: '8px' }}>Chưa có đơn hàng nào</h3>
          <p style={{ fontSize: '14px', color: 'var(--text-muted)', marginBottom: '20px' }}>
            Bạn chưa thực hiện đơn đặt hàng nào trên hệ thống.
          </p>
          <Link to="/books" className="btn btn-primary">Khám phá sách ngay</Link>
        </div>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
          {orders.map((o) => (
            <div key={o.id} className="card" style={{ padding: '24px' }}>
              {/* Order Header */}
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '12px', borderBottom: '1px solid var(--border)', paddingBottom: '16px', marginBottom: '16px' }}>
                <div>
                  <span style={{ fontSize: '16px', fontWeight: '800', color: 'var(--primary)' }}>
                    Mã đơn: {o.orderCode}
                  </span>
                  <div style={{ fontSize: '12px', color: 'var(--text-muted)', marginTop: '4px' }}>
                    Đặt lúc: {new Date(o.createdAt).toLocaleString('vi-VN')}
                  </div>
                </div>

                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                  {getStatusBadge(o.orderStatus)}
                  <span className={`badge ${o.paymentStatus === 'PAID' ? 'badge-success' : 'badge-neutral'}`}>
                    {o.paymentStatus === 'PAID' ? 'Đã thanh toán' : 'Chưa thanh toán'}
                  </span>
                </div>
              </div>

              {/* Items List */}
              <div style={{ display: 'flex', flexDirection: 'column', gap: '10px', marginBottom: '16px' }}>
                {o.items?.map((item) => (
                  <div key={item.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: '14px' }}>
                    <div>
                      <strong>{item.productNameSnapshot}</strong>
                      <span style={{ color: 'var(--text-muted)', marginLeft: '8px' }}>x {item.quantity}</span>
                    </div>
                    <span style={{ fontWeight: '600' }}>{formatPrice(item.totalPrice)}</span>
                  </div>
                ))}
              </div>

              {/* Order Footer */}
              <div style={{ borderTop: '1px solid var(--border)', paddingTop: '16px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '16px' }}>
                <div style={{ fontSize: '13px', color: 'var(--text-muted)' }}>
                  Giao đến: <strong>{o.shipment?.receiverName}</strong> - {o.shipment?.address}
                </div>

                <div style={{ display: 'flex', alignItems: 'center', gap: '20px' }}>
                  <div style={{ textAlign: 'right' }}>
                    <span style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Tổng thanh toán: </span>
                    <strong style={{ fontSize: '18px', color: 'var(--primary)' }}>{formatPrice(o.totalAmount)}</strong>
                  </div>

                  {(o.orderStatus === 'PENDING' || o.orderStatus === 'CONFIRMED') && (
                    <button
                      onClick={() => handleCancelOrder(o.id)}
                      disabled={cancellingId === o.id}
                      className="btn btn-danger btn-sm"
                    >
                      {cancellingId === o.id ? 'Đang hủy...' : 'Hủy đơn hàng'}
                    </button>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};
