import React, { useEffect } from 'react';
import { BrowserRouter, Routes, Route, useLocation } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import { CartProvider } from './context/CartContext';
import { WishlistProvider } from './context/WishlistContext';
import { Navbar, Footer } from './components/NavbarAndFooter';
import { ProtectedRoute, ErrorBoundary } from './components/UIComponents';

import { Home } from './pages/Home';
import { Books } from './pages/Books';
import { BookDetail } from './pages/BookDetail';
import { Cart } from './pages/Cart';
import { Checkout } from './pages/Checkout';
import { Orders } from './pages/Orders';
import { Wishlist } from './pages/Wishlist';
import { Profile } from './pages/Profile';
import { TermsOfService, PrivacyPolicy, ShippingPolicy, PaymentGuide } from './pages/Policies';
import { Login, Register } from './pages/AuthPages';
import { AdminDashboard, AdminBooks, AdminOrders, AdminCoupons } from './pages/admin/AdminPages';
import { AdminUsers } from './pages/admin/AdminUsers';
import { EmployeeDashboard } from './pages/employee/EmployeePages';

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
  return (
    <AuthProvider>
      <CartProvider>
        <WishlistProvider>
          <BrowserRouter>
            <ScrollToTop />
            <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
              <Navbar />
            
            <main style={{ flex: 1 }}>
              <ErrorBoundary>
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
                  <Route path="/employee/orders" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminOrders />
                    </ProtectedRoute>
                  } />
                </Routes>
              </ErrorBoundary>
            </main>

            <Footer />
          </div>
        </BrowserRouter>
        </WishlistProvider>
      </CartProvider>
    </AuthProvider>
  );
}

export default App;
