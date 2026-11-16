import React, { useEffect, Suspense, lazy } from 'react';
import { BrowserRouter, Routes, Route, useLocation } from 'react-router-dom';
import { GoogleOAuthProvider } from '@react-oauth/google';
import { AuthProvider } from './context/AuthContext';
import { CartProvider } from './context/CartContext';
import { WishlistProvider } from './context/WishlistContext';
import { ToastProvider } from './context/ToastContext';
import { Navbar, Footer } from './components/NavbarAndFooter';
import { ProtectedRoute, ErrorBoundary } from './components/UIComponents';
import ChatWidget from './components/ChatWidget';
import BackToTop from './components/BackToTop';

// Critical Customer Routes (Eagerly Loaded)
import { Home } from './pages/Home';
import { Books } from './pages/Books';

// Lazy Loaded Customer & Support Routes
const BookDetail = lazy(() => import('./pages/BookDetail').then(m => ({ default: m.BookDetail })));
const Cart = lazy(() => import('./pages/Cart').then(m => ({ default: m.Cart })));
const Checkout = lazy(() => import('./pages/Checkout').then(m => ({ default: m.Checkout })));
const Orders = lazy(() => import('./pages/Orders').then(m => ({ default: m.Orders })));
const Wishlist = lazy(() => import('./pages/Wishlist').then(m => ({ default: m.Wishlist })));
const Profile = lazy(() => import('./pages/Profile').then(m => ({ default: m.Profile })));
const TermsOfService = lazy(() => import('./pages/Policies').then(m => ({ default: m.TermsOfService })));
const PrivacyPolicy = lazy(() => import('./pages/Policies').then(m => ({ default: m.PrivacyPolicy })));
const ShippingPolicy = lazy(() => import('./pages/Policies').then(m => ({ default: m.ShippingPolicy })));
const PaymentGuide = lazy(() => import('./pages/Policies').then(m => ({ default: m.PaymentGuide })));
const Login = lazy(() => import('./pages/AuthPages').then(m => ({ default: m.Login })));
const Register = lazy(() => import('./pages/AuthPages').then(m => ({ default: m.Register })));
const ForgotPassword = lazy(() => import('./pages/ForgotPassword').then(m => ({ default: m.ForgotPassword })));
const NotFound = lazy(() => import('./pages/NotFound').then(m => ({ default: m.NotFound })));

// Lazy Loaded Admin & Employee Routes (Heavy Bundles)
const AdminDashboard = lazy(() => import('./pages/admin/AdminPages').then(m => ({ default: m.AdminDashboard })));
const AdminBooks = lazy(() => import('./pages/admin/AdminPages').then(m => ({ default: m.AdminBooks })));
const AdminCategories = lazy(() => import('./pages/admin/AdminPages').then(m => ({ default: m.AdminCategories })));
const AdminOrders = lazy(() => import('./pages/admin/AdminPages').then(m => ({ default: m.AdminOrders })));
const AdminCoupons = lazy(() => import('./pages/admin/AdminPages').then(m => ({ default: m.AdminCoupons })));
const AdminUsers = lazy(() => import('./pages/admin/AdminUsers').then(m => ({ default: m.AdminUsers })));
const AdminChatbot = lazy(() => import('./pages/admin/AdminChatbot').then(m => ({ default: m.AdminChatbot })));
const EmployeeDashboard = lazy(() => import('./pages/employee/EmployeePages').then(m => ({ default: m.EmployeeDashboard })));

// Lightweight Loading Fallback for Route Transitions
const PageLoader = () => (
  <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '60vh' }}>
    <div style={{
      width: '38px',
      height: '38px',
      border: '3px solid #e2e8f0',
      borderTopColor: 'var(--primary)',
      borderRadius: '50%',
      animation: 'spin 0.8s linear infinite'
    }} />
  </div>
);

// Tự động cuộn trang lên đầu mỗi khi chuyển route hoặc đổi danh mục / bộ lọc URL
const ScrollToTop = () => {
  const { pathname, search } = useLocation();

  useEffect(() => {
    window.scrollTo(0, 0);
    if (document.documentElement) {
      document.documentElement.scrollTop = 0;
    }
    if (document.body) {
      document.body.scrollTop = 0;
    }
  }, [pathname, search]);

  return null;
};

export function App() {
  const googleClientId = import.meta.env.VITE_GOOGLE_CLIENT_ID || '1031444664527-dusjts82h83rnhutsc44iu6537pdk0r9.apps.googleusercontent.com';

  return (
    <GoogleOAuthProvider clientId={googleClientId}>
      <AuthProvider>
        <CartProvider>
          <WishlistProvider>
            <BrowserRouter>
              <ToastProvider>
                <ScrollToTop />
                <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
                  <Navbar />
                
                <main style={{ flex: 1 }}>
                  <ErrorBoundary>
                    <Suspense fallback={<PageLoader />}>
                      <Routes>
                        {/* Customer Routes */}
                  <Route path="/" element={<Home />} />
                  <Route path="/books" element={<Books />} />
                  <Route path="/books/:id" element={<BookDetail />} />
                  <Route path="/cart" element={<Cart />} />
                  <Route path="/wishlist" element={
                    <ProtectedRoute>
                      <Wishlist />
                    </ProtectedRoute>
                  } />
                  <Route path="/checkout" element={
                    <ProtectedRoute>
                      <Checkout />
                    </ProtectedRoute>
                  } />
                  <Route path="/orders" element={
                    <ProtectedRoute>
                      <Orders />
                    </ProtectedRoute>
                  } />
                  <Route path="/profile" element={
                    <ProtectedRoute>
                      <Profile />
                    </ProtectedRoute>
                  } />

                  {/* Policy & Support Routes */}
                  <Route path="/terms" element={<TermsOfService />} />
                  <Route path="/privacy" element={<PrivacyPolicy />} />
                  <Route path="/shipping-policy" element={<ShippingPolicy />} />
                  <Route path="/payment-guide" element={<PaymentGuide />} />

                  {/* Auth Routes */}
                  <Route path="/login" element={<Login />} />
                  <Route path="/register" element={<Register />} />
                  <Route path="/forgot-password" element={<ForgotPassword />} />

                  {/* Admin Only Routes */}
                  <Route path="/admin" element={
                    <ProtectedRoute requireAdmin={true}>
                      <AdminDashboard />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/books" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminBooks />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/categories" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminCategories />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/orders" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminOrders />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/coupons" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminCoupons />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/users" element={
                    <ProtectedRoute requireAdmin={true}>
                      <AdminUsers />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/chatbot" element={
                    <ProtectedRoute requireAdmin={true}>
                      <AdminChatbot />
                    </ProtectedRoute>
                  } />

                  {/* Employee Workspace Routes (requireManager={true}) */}
                  <Route path="/employee" element={
                    <ProtectedRoute requireManager={true}>
                      <EmployeeDashboard />
                    </ProtectedRoute>
                  } />
                  <Route path="/employee/books" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminBooks />
                    </ProtectedRoute>
                  } />
                  <Route path="/employee/categories" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminCategories />
                    </ProtectedRoute>
                  } />
                  <Route path="/employee/orders" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminOrders />
                    </ProtectedRoute>
                  } />

                  {/* 404 Fallback Route */}
                  <Route path="*" element={<NotFound />} />
                </Routes>
              </Suspense>
            </ErrorBoundary>
            </main>

            <Footer />
            <ChatWidget />
            <BackToTop />
          </div>
          </ToastProvider>
        </BrowserRouter>
        </WishlistProvider>
      </CartProvider>
    </AuthProvider>
    </GoogleOAuthProvider>
  );
}

export default App;
