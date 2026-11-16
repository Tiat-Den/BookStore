import React, { useState, useEffect } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import { Package, Clock, CheckCircle2, XCircle, Truck, AlertCircle, X, AlertTriangle } from 'lucide-react';
import { orderService } from '../services/catalogAndOrderServices';
import { LoadingSpinner } from '../components/UIComponents';
import { useToast } from '../context/ToastContext';
import EmptyState from '../components/EmptyState';

const CANCEL_REASONS = [
  'Tôi muốn thay đổi địa chỉ hoặc số điện thoại nhận hàng',
  'Tôi muốn đổi phương thức thanh toán / áp dụng voucher khác',
  'Tôi đặt nhầm cuốn sách / muốn chọn tác phẩm khác',
  'Thời gian giao hàng dự kiến không phù hợp',
  'Tôi tìm được giá tốt hơn ở nơi khác',
  'Lý do khác'
];

export const Orders = () => {
  const [searchParams] = useSearchParams();
  const successCode = searchParams.get('success');
  const { toast } = useToast();

  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [cancellingOrder, setCancellingOrder] = useState(null); // Order to be cancelled
  const [selectedReason, setSelectedReason] = useState(CANCEL_REASONS[0]);
  const [customReason, setCustomReason] = useState('');
  const [submittingCancel, setSubmittingCancel] = useState(false);

  const fetchOrders = async () => {
    try {
      setLoading(true);
      const res = await orderService.getMyOrders();
      if (res.success && res.data) {
        setOrders(res.data.items || []);
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

  const handleOpenCancelModal = (order) => {
    setCancellingOrder(order);
    setSelectedReason(CANCEL_REASONS[0]);
    setCustomReason('');
  };

  const handleConfirmCancel = async () => {
    if (!cancellingOrder) return;
    const finalReason = selectedReason === 'Lý do khác' ? (customReason.trim() || 'Lý do cá nhân') : selectedReason;

    setSubmittingCancel(true);
    try {
      const res = await orderService.cancelOrder(cancellingOrder.id, finalReason);
      if (res.success) {
        toast.success(`Đã hủy đơn hàng #${cancellingOrder.orderCode} thành công và hoàn trả số lượng sách về kho.`);
        setCancellingOrder(null);
        fetchOrders();
      } else {
        toast.error(res.message || 'Không thể hủy đơn hàng lúc này.');
      }
    } catch (err) {
      toast.error(err.message || 'Lỗi khi hủy đơn hàng.');
    } finally {
      setSubmittingCancel(false);
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
        <EmptyState type="orders" />
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
                      onClick={() => handleOpenCancelModal(o)}
                      className="btn btn-danger btn-sm"
                    >
                      Hủy đơn hàng
                    </button>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Cancel Order Modal */}
      {cancellingOrder && (
        <div
          style={{
            position: 'fixed',
            inset: 0,
            backgroundColor: 'rgba(15, 23, 42, 0.65)',
            backdropFilter: 'blur(4px)',
            zIndex: 99999,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            padding: '20px'
          }}
          onClick={() => !submittingCancel && setCancellingOrder(null)}
        >
          <div
            className="card"
            style={{
              width: '100%',
              maxWidth: '520px',
              padding: '28px',
              borderRadius: '20px',
              boxShadow: '0 25px 50px -12px rgba(15, 23, 42, 0.35)',
              backgroundColor: '#ffffff'
            }}
            onClick={(e) => e.stopPropagation()}
          >
            {/* Modal Header */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <div style={{ width: '40px', height: '40px', borderRadius: '10px', backgroundColor: '#fef2f2', color: '#dc2626', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                  <AlertTriangle size={22} />
                </div>
                <div>
                  <h3 style={{ fontSize: '18px', fontWeight: '800', margin: 0, color: '#0f172a' }}>
                    Xác nhận hủy đơn hàng
                  </h3>
                  <span style={{ fontSize: '13px', color: '#64748b' }}>
                    Mã đơn: <strong style={{ color: '#2563eb' }}>{cancellingOrder.orderCode}</strong>
                  </span>
                </div>
              </div>
              <button
                onClick={() => setCancellingOrder(null)}
                disabled={submittingCancel}
                style={{ background: 'none', border: 'none', color: '#94a3b8', cursor: 'pointer', padding: '4px' }}
              >
                <X size={20} />
              </button>
            </div>

            {/* Warning Note */}
            <div style={{ padding: '12px 16px', backgroundColor: '#fffbeb', border: '1px solid #fef3c7', borderRadius: '10px', fontSize: '13px', color: '#92400e', marginBottom: '20px', lineHeight: 1.5 }}>
              Số lượng sách trong đơn sẽ được tự động hoàn lại vào kho. Bạn có thể đặt mua lại bất cứ lúc nào!
            </div>

            {/* Reasons Radio List */}
            <div style={{ marginBottom: '20px' }}>
              <label style={{ fontSize: '13.5px', fontWeight: '700', color: '#334155', display: 'block', marginBottom: '10px' }}>
                Vui lòng chọn lý do hủy đơn:
              </label>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                {CANCEL_REASONS.map((r, idx) => (
                  <label
                    key={idx}
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '10px',
                      padding: '10px 14px',
                      borderRadius: '10px',
                      border: selectedReason === r ? '1.5px solid #2563eb' : '1px solid #e2e8f0',
                      backgroundColor: selectedReason === r ? '#eff6ff' : '#f8fafc',
                      cursor: 'pointer',
                      fontSize: '13.5px',
                      color: selectedReason === r ? '#1e40af' : '#334155',
                      fontWeight: selectedReason === r ? '600' : '400',
                      transition: 'all 0.15s ease'
                    }}
                  >
                    <input
                      type="radio"
                      name="cancelReason"
                      value={r}
                      checked={selectedReason === r}
                      onChange={(e) => setSelectedReason(e.target.value)}
                      style={{ accentColor: '#2563eb' }}
                    />
                    <span>{r}</span>
                  </label>
                ))}
              </div>

              {selectedReason === 'Lý do khác' && (
                <div style={{ marginTop: '12px' }}>
                  <textarea
                    rows="3"
                    value={customReason}
                    onChange={(e) => setCustomReason(e.target.value)}
                    placeholder="Nhập chi tiết lý do của bạn..."
                    style={{
                      width: '100%',
                      padding: '10px 14px',
                      borderRadius: '10px',
                      border: '1px solid #cbd5e1',
                      fontSize: '13px',
                      outline: 'none',
                      fontFamily: 'inherit'
                    }}
                  />
                </div>
              )}
            </div>

            {/* Modal Actions */}
            <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '12px', borderTop: '1px solid #f1f5f9', paddingTop: '16px' }}>
              <button
                type="button"
                onClick={() => setCancellingOrder(null)}
                disabled={submittingCancel}
                className="btn btn-outline"
                style={{ padding: '9px 18px', fontSize: '13.5px' }}
              >
                Giữ lại đơn hàng
              </button>
              <button
                type="button"
                onClick={handleConfirmCancel}
                disabled={submittingCancel}
                className="btn btn-danger"
                style={{ padding: '9px 20px', fontSize: '13.5px', fontWeight: '700' }}
              >
                {submittingCancel ? 'Đang xử lý...' : 'Xác nhận hủy'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
