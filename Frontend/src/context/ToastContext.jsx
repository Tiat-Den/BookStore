import React, { createContext, useContext, useState, useCallback, useRef } from 'react';
import { Link } from 'react-router-dom';
import { CheckCircle2, AlertCircle, Info, AlertTriangle, X, ArrowRight } from 'lucide-react';

const ToastContext = createContext(null);

export const useToast = () => {
  const context = useContext(ToastContext);
  if (!context) {
    throw new Error('useToast must be used within a ToastProvider');
  }
  return context;
};

export const ToastProvider = ({ children }) => {
  const [toasts, setToasts] = useState([]);
  const toastIdRef = useRef(0);

  const removeToast = useCallback((id) => {
    setToasts((prev) => prev.filter((t) => t.id !== id));
  }, []);

  const showToast = useCallback((message, type = 'success', options = {}) => {
    const id = ++toastIdRef.current;
    const {
      title,
      duration = 3500,
      actionText,
      actionLink,
      onAction
    } = options;

    const newToast = {
      id,
      message,
      type,
      title: title || (
        type === 'success' ? 'Thành công' :
        type === 'error' ? 'Có lỗi xảy ra' :
        type === 'warning' ? 'Lưu ý' : 'Thông báo'
      ),
      actionText,
      actionLink,
      onAction,
      duration
    };

    setToasts((prev) => [...prev, newToast]);

    if (duration > 0) {
      setTimeout(() => {
        removeToast(id);
      }, duration);
    }

    return id;
  }, [removeToast]);

  // Convenience helper object
  const toast = {
    success: (message, options) => showToast(message, 'success', options),
    error: (message, options) => showToast(message, 'error', options),
    info: (message, options) => showToast(message, 'info', options),
    warning: (message, options) => showToast(message, 'warning', options)
  };

  const getToastConfig = (type) => {
    switch (type) {
      case 'error':
        return {
          icon: <AlertCircle size={20} color="#dc2626" />,
          bgColor: '#fef2f2',
          borderColor: '#fca5a5',
          accentColor: '#dc2626',
          titleColor: '#991b1b'
        };
      case 'warning':
        return {
          icon: <AlertTriangle size={20} color="#d97706" />,
          bgColor: '#fffbeb',
          borderColor: '#fcd34d',
          accentColor: '#d97706',
          titleColor: '#92400e'
        };
      case 'info':
        return {
          icon: <Info size={20} color="#2563eb" />,
          bgColor: '#eff6ff',
          borderColor: '#93c5fd',
          accentColor: '#2563eb',
          titleColor: '#1e40af'
        };
      case 'success':
      default:
        return {
          icon: <CheckCircle2 size={20} color="#059669" />,
          bgColor: '#ecfdf5',
          borderColor: '#6ee7b7',
          accentColor: '#059669',
          titleColor: '#065f46'
        };
    }
  };

  return (
    <ToastContext.Provider value={{ showToast, toast, removeToast }}>
      {children}

      {/* Toast Notification Container - Top Right */}
      <aside
        aria-label="Thông báo hệ thống"
        style={{
          position: 'fixed',
          top: '24px',
          right: '24px',
          zIndex: 999999,
          display: 'flex',
          flexDirection: 'column',
          gap: '12px',
          pointerEvents: 'none',
          maxWidth: 'min(420px, calc(100vw - 32px))'
        }}
      >
        {toasts.map((t) => {
          const cfg = getToastConfig(t.type);
          return (
            <div
              key={t.id}
              role="alert"
              style={{
                pointerEvents: 'auto',
                backgroundColor: '#ffffff',
                borderRadius: '14px',
                border: '1px solid #e2e8f0',
                borderLeft: `4px solid ${cfg.accentColor}`,
                boxShadow: '0 12px 32px -4px rgba(15, 23, 42, 0.16), 0 4px 12px -2px rgba(15, 23, 42, 0.08)',
                padding: '14px 16px',
                display: 'flex',
                alignItems: 'flex-start',
                gap: '12px',
                animation: 'toastSlideIn 0.32s cubic-bezier(0.16, 1, 0.3, 1)',
                transition: 'all 0.2s ease',
                position: 'relative',
                overflow: 'hidden'
              }}
            >
              {/* Icon badge */}
              <div
                style={{
                  width: '36px',
                  height: '36px',
                  borderRadius: '10px',
                  backgroundColor: cfg.bgColor,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  flexShrink: 0,
                  marginTop: '1px'
                }}
              >
                {cfg.icon}
              </div>

              {/* Message content */}
              <div style={{ flex: 1, minWidth: 0 }}>
                {t.title && (
                  <div
                    style={{
                      fontSize: '13px',
                      fontWeight: '700',
                      color: cfg.titleColor,
                      marginBottom: '3px'
                    }}
                  >
                    {t.title}
                  </div>
                )}
                <div
                  style={{
                    fontSize: '13px',
                    fontWeight: '500',
                    color: '#334155',
                    lineHeight: '1.45',
                    wordBreak: 'break-word'
                  }}
                >
                  {t.message}
                </div>

                {/* Optional Action Button / Link */}
                {t.actionText && (
                  <div style={{ marginTop: '8px' }}>
                    {t.actionLink ? (
                      <Link
                        to={t.actionLink}
                        onClick={() => removeToast(t.id)}
                        style={{
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: '4px',
                          fontSize: '12px',
                          fontWeight: '700',
                          color: '#2563eb',
                          textDecoration: 'none',
                          padding: '4px 8px',
                          borderRadius: '6px',
                          backgroundColor: '#eff6ff',
                          transition: 'all 0.15s ease'
                        }}
                      >
                        {t.actionText} <ArrowRight size={13} />
                      </Link>
                    ) : t.onAction ? (
                      <button
                        onClick={() => {
                          t.onAction();
                          removeToast(t.id);
                        }}
                        style={{
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: '4px',
                          fontSize: '12px',
                          fontWeight: '700',
                          color: '#2563eb',
                          background: '#eff6ff',
                          border: 'none',
                          padding: '4px 8px',
                          borderRadius: '6px',
                          cursor: 'pointer'
                        }}
                      >
                        {t.actionText} <ArrowRight size={13} />
                      </button>
                    ) : null}
                  </div>
                )}
              </div>

              {/* Close button */}
              <button
                onClick={() => removeToast(t.id)}
                aria-label="Đóng thông báo"
                style={{
                  background: 'transparent',
                  border: 'none',
                  color: '#94a3b8',
                  cursor: 'pointer',
                  padding: '4px',
                  borderRadius: '6px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  flexShrink: 0,
                  transition: 'color 0.15s ease'
                }}
                onMouseEnter={(e) => (e.currentTarget.style.color = '#334155')}
                onMouseLeave={(e) => (e.currentTarget.style.color = '#94a3b8')}
              >
                <X size={16} />
              </button>
            </div>
          );
        })}
      </aside>
    </ToastContext.Provider>
  );
};
