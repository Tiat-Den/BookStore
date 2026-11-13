import React from 'react';
import { Link } from 'react-router-dom';
import { FileText, ShieldCheck, Truck, CreditCard, ChevronRight, HelpCircle, CheckCircle2, Clock, Phone, Mail, MapPin } from 'lucide-react';

const POLICY_NAV_ITEMS = [
  { path: '/terms', label: 'Điều khoản dịch vụ', icon: FileText },
  { path: '/privacy', label: 'Chính sách bảo mật', icon: ShieldCheck },
  { path: '/shipping-policy', label: 'Chính sách giao hàng', icon: Truck },
  { path: '/payment-guide', label: 'Hướng dẫn thanh toán', icon: CreditCard }
];

const PolicyLayout = ({ activePath, title, subtitle, children }) => {
  React.useEffect(() => {
    window.scrollTo(0, 0);
  }, [activePath]);

  return (
    <div className="container" style={{ padding: '40px 20px', maxWidth: '1180px' }}>
      {/* Breadcrumb */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '13px', color: 'var(--text-muted)', marginBottom: '24px' }}>
        <Link to="/" style={{ color: 'var(--text-muted)' }}>Trang chủ</Link>
        <ChevronRight size={14} />
        <span style={{ color: 'var(--primary)', fontWeight: '600' }}>{title}</span>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '280px 1fr', gap: '36px', alignItems: 'start' }}>
        {/* Policy Sidebar */}
        <div style={{ position: 'sticky', top: '90px' }}>
          <div className="card" style={{ padding: '16px', marginBottom: '20px' }}>
            <h3 style={{ fontSize: '15px', fontWeight: '800', marginBottom: '14px', paddingBottom: '10px', borderBottom: '1px solid var(--border)' }}>
              Chính Sách & Hỗ Trợ
            </h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
              {POLICY_NAV_ITEMS.map((item) => {
                const Icon = item.icon;
                const isActive = activePath === item.path;
                return (
                  <Link
                    key={item.path}
                    to={item.path}
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '10px',
                      padding: '10px 14px',
                      borderRadius: 'var(--radius)',
                      fontSize: '14px',
                      fontWeight: isActive ? '700' : '500',
                      color: isActive ? 'var(--primary)' : 'var(--text-main)',
                      backgroundColor: isActive ? 'var(--primary-light)' : 'transparent',
                      transition: 'all 0.15s ease'
                    }}
                    onMouseEnter={(e) => {
                      if (!isActive) e.currentTarget.style.backgroundColor = '#f8fafc';
                    }}
                    onMouseLeave={(e) => {
                      if (!isActive) e.currentTarget.style.backgroundColor = 'transparent';
                    }}
                  >
                    <Icon size={18} color={isActive ? 'var(--primary)' : 'var(--text-muted)'} />
                    <span>{item.label}</span>
                  </Link>
                );
              })}
            </div>
          </div>

          {/* Support Widget */}
          <div className="card" style={{ padding: '20px', backgroundColor: '#f8fafc' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '12px', color: 'var(--primary)' }}>
              <HelpCircle size={20} />
              <h4 style={{ fontSize: '14px', fontWeight: '700' }}>Cần Hỗ Trợ Thêm?</h4>
            </div>
            <p style={{ fontSize: '12px', color: 'var(--text-muted)', lineHeight: '1.6', marginBottom: '12px' }}>
              Đội ngũ chăm sóc khách hàng của BookStore luôn sẵn sàng giải đáp mọi thắc mắc của bạn 24/7.
            </p>
            <div style={{ fontSize: '13px', fontWeight: '600', display: 'flex', flexDirection: 'column', gap: '6px' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Phone size={14} color="var(--primary)" /> Hotline: 1900 123 456
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Mail size={14} color="var(--primary)" /> support@bookstore.com
              </div>
            </div>
          </div>
        </div>

        {/* Content Area */}
        <div className="card" style={{ padding: '36px 40px', backgroundColor: '#ffffff' }}>
          <div style={{ borderBottom: '1px solid var(--border)', paddingBottom: '20px', marginBottom: '28px' }}>
            <h1 style={{ fontSize: '28px', fontWeight: '800', lineHeight: '1.3', marginBottom: '8px' }}>{title}</h1>
            {subtitle && <p style={{ fontSize: '14px', color: 'var(--text-muted)' }}>{subtitle}</p>}
          </div>

          <div className="policy-content" style={{ fontSize: '15px', color: '#334155', lineHeight: '1.8' }}>
            {children}
          </div>
        </div>
      </div>
    </div>
  );
};

export const TermsOfService = () => {
  return (
    <PolicyLayout
      activePath="/terms"
      title="Điều Khoản Dịch Vụ"
      subtitle="Cập nhật lần cuối: Tháng 10/2026. Áp dụng cho tất cả khách hàng mua sắm tại BookStore"
    >
      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          1. Giới thiệu & Phạm vi áp dụng
        </h2>
        <p style={{ marginBottom: '12px' }}>
          Chào mừng quý khách đến với sàn thương mại điện tử <strong>BookStore</strong>. Khi truy cập, duyệt danh mục hoặc thực hiện đặt mua ấn phẩm tại website của chúng tôi, quý khách đồng ý tuân thủ và chịu sự ràng buộc bởi các Điều khoản dịch vụ này.
        </p>
        <p>
          BookStore có quyền thay đổi, chỉnh sửa, thêm hoặc lược bỏ bất kỳ phần nào trong Quy định và Điều kiện sử dụng này vào bất kỳ lúc nào để phù hợp với quy định pháp luật và hoạt động thực tế. Các thay đổi có hiệu lực ngay khi được đăng tải trên website.
        </p>
      </section>

      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          2. Tài khoản người dùng & Bảo mật
        </h2>
        <p style={{ marginBottom: '12px' }}>
          Khi đăng ký tài khoản tại BookStore, quý khách có trách nhiệm cung cấp thông tin chính xác, đầy đủ và cập nhật về họ tên, số điện thoại và địa chỉ nhận hàng để đảm bảo quyền lợi khi giao dịch.
        </p>
        <p>
          Quý khách chịu trách nhiệm tự bảo mật mật khẩu tài khoản của mình. Nếu phát hiện bất kỳ hành vi truy cập trái phép nào vào tài khoản cá nhân, vui lòng liên hệ ngay với bộ phận hỗ trợ khách hàng của BookStore để được xử lý kịp thời.
        </p>
      </section>

      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          3. Đặt hàng, Giá cả & Xác nhận đơn hàng
        </h2>
        <p style={{ marginBottom: '12px' }}>
          Giá sản phẩm niêm yết trên website là giá bán chính thức bằng Việt Nam Đồng (VNĐ), đã bao gồm thuế Giá trị gia tăng (VAT) theo luật định hiện hành. Giá chưa bao gồm cước phí vận chuyển (sẽ được tính rõ ràng tại bước thanh toán).
        </p>
        <p>
          BookStore cam kết cung cấp thông tin giá cả và tình trạng tồn kho chính xác nhất. Trong trường hợp xảy ra sai sót hệ thống về giá hoặc tồn kho thực tế, chúng tôi sẽ chủ động liên hệ quý khách để thông báo và xác nhận xử lý đơn hàng.
        </p>
      </section>

      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          4. Bản quyền & Sở hữu trí tuệ
        </h2>
        <p>
          Tất cả sách và ấn phẩm được phân phối trên BookStore là <strong>100% sách chính hãng</strong>, có bản quyền từ các nhà xuất bản uy tín (NXB Trẻ, NXB Kim Đồng, NXB Tổng Hợp...). Mọi hình ảnh bìa, tóm tắt tác phẩm, nội dung và biểu tượng thương hiệu trên website đều thuộc quyền sở hữu của BookStore và các đối tác liên quan. Nghiêm cấm mọi hành vi sao chép nhằm mục đích thương mại trái phép.
        </p>
      </section>

      <section>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          5. Giải quyết tranh chấp
        </h2>
        <p>
          Bất kỳ tranh chấp phát sinh trong quá trình giao dịch tại BookStore sẽ được ưu tiên giải quyết thông qua thương lượng, hòa giải nhằm đảm bảo tối đa quyền lợi chính đáng của người tiêu dùng.
        </p>
      </section>
    </PolicyLayout>
  );
};

export const PrivacyPolicy = () => {
  return (
    <PolicyLayout
      activePath="/privacy"
      title="Chính Sách Bảo Mật"
      subtitle="Cam kết bảo vệ tuyệt đối thông tin và dữ liệu cá nhân của người tiêu dùng"
    >
      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          1. Thu thập thông tin cá nhân
        </h2>
        <p style={{ marginBottom: '12px' }}>
          Để phục vụ quá trình đặt hàng và giao nhận sách, BookStore thu thập các thông tin sau khi khách hàng tạo tài khoản hoặc đặt đơn:
        </p>
        <ul style={{ paddingLeft: '24px', marginBottom: '12px' }}>
          <li>Họ và tên người nhận hàng.</li>
          <li>Địa chỉ email (dùng để đăng nhập, nhận thông báo xác nhận và hóa đơn điện tử).</li>
          <li>Số điện thoại liên lạc của khách hàng.</li>
          <li>Địa chỉ nhận hàng (để bàn giao cho đối tác vận chuyển).</li>
        </ul>
      </section>

      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          2. Mục đích sử dụng thông tin
        </h2>
        <p style={{ marginBottom: '12px' }}>Thông tin của quý khách chỉ được sử dụng cho các mục đích hợp pháp sau:</p>
        <ul style={{ paddingLeft: '24px' }}>
          <li>Xử lý, đóng gói và vận chuyển đơn đặt hàng sách.</li>
          <li>Thông báo tiến độ giao hàng và hỗ trợ hậu mãi (đổi trả, bảo hành).</li>
          <li>Cung cấp thông tin về mã giảm giá, chương trình tri ân dành riêng cho thành viên.</li>
          <li>Ngăn ngừa các hành vi gian lận tài khoản hoặc phá hoại bảo mật hệ thống.</li>
        </ul>
      </section>

      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          3. Chia sẻ thông tin với bên thứ ba
        </h2>
        <p style={{ marginBottom: '12px' }}>
          BookStore <strong>cam kết không bán, chia sẻ hoặc trao đổi thông tin cá nhân</strong> của khách hàng cho bất kỳ bên thứ ba nào vì mục đích thương mại.
        </p>
        <p>
          Chúng tôi chỉ chia sẻ thông tin cần thiết với:
        </p>
        <ul style={{ paddingLeft: '24px' }}>
          <li><strong>Đơn vị vận chuyển:</strong> Chia sẻ Tên, SĐT, Địa chỉ để giao kiện hàng.</li>
          <li><strong>Cổng thanh toán điện tử (VNPay):</strong> Chuyển tiếp mã đơn hàng và số tiền để xử lý thanh toán trực tuyến qua kết nối mã hóa SSL 256-bit an toàn.</li>
          <li><strong>Cơ quan pháp luật:</strong> Chỉ khi có yêu cầu bằng văn bản đúng thẩm quyền theo quy định của pháp luật Việt Nam.</li>
        </ul>
      </section>

      <section>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          4. Quyền của khách hàng đối với dữ liệu
        </h2>
        <p>
          Quý khách có toàn quyền kiểm tra, cập nhật hoặc điều chỉnh thông tin cá nhân của mình bất kỳ lúc nào bằng cách truy cập vào trang <strong>Thông tin tài khoản</strong> trên website, hoặc yêu cầu ban quản trị BookStore xóa dữ liệu cá nhân khi ngừng sử dụng dịch vụ.
        </p>
      </section>
    </PolicyLayout>
  );
};

export const ShippingPolicy = () => {
  return (
    <PolicyLayout
      activePath="/shipping-policy"
      title="Chính Sách Giao Hàng & Đổi Trả"
      subtitle="Đóng gói kỹ lưỡng - Giao hàng toàn quốc - Đổi trả linh hoạt"
    >
      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          1. Phạm vi & Thời gian giao hàng
        </h2>
        <p style={{ marginBottom: '14px' }}>
          BookStore hợp tác cùng các đối tác vận chuyển hàng đầu để phân phối sách đến tận tay khách hàng trên toàn bộ 63 tỉnh thành:
        </p>

        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '16px', marginBottom: '16px' }}>
          <div style={{ padding: '16px', borderRadius: 'var(--radius)', backgroundColor: '#f8fafc', border: '1px solid var(--border)' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: 'var(--primary)', fontWeight: '700', marginBottom: '6px' }}>
              <Clock size={16} /> Khu vực Nội thành (TP.HCM, Hà Nội)
            </div>
            <p style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Thời gian nhận hàng: Từ <strong>1 - 2 ngày</strong> làm việc kể từ lúc xác nhận đơn.</p>
          </div>

          <div style={{ padding: '16px', borderRadius: 'var(--radius)', backgroundColor: '#f8fafc', border: '1px solid var(--border)' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#0d9488', fontWeight: '700', marginBottom: '6px' }}>
              <Truck size={16} /> Các Tỉnh / Thành phố khác
            </div>
            <p style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Thời gian nhận hàng: Từ <strong>3 - 5 ngày</strong> làm việc tùy khoảng cách địa lý.</p>
          </div>
        </div>
      </section>

      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          2. Biểu phí vận chuyển & Ưu đãi Freeship
        </h2>
        <ul style={{ paddingLeft: '24px', marginBottom: '12px' }}>
          <li><strong>Đơn hàng từ 300.000đ trở lên:</strong> <span style={{ color: 'var(--success)', fontWeight: '700' }}>MIỄN PHÍ VẬN CHUYỂN TOÀN QUỐC (Freeship)</span>.</li>
          <li><strong>Đơn hàng dưới 300.000đ:</strong> Phí giao hàng tiêu chuẩn đồng giá <strong>25.000đ</strong> cho nội thành và <strong>35.000đ</strong> cho các tỉnh thành khác.</li>
          <li>Khách hàng có thể sử dụng thêm các <em>Mã voucher giảm giá phí ship</em> tại trang thanh toán để tiết kiệm chi phí.</li>
        </ul>
      </section>

      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          3. Quy định đóng gói bảo vệ sách
        </h2>
        <p>
          Mọi cuốn sách tại BookStore đều được bọc màng co nilon bảo vệ, chèn xốp bóng khí (bubble wrap) chống sốc và đóng hộp carton chắc chắn trước khi xuất kho, nhằm bảo đảm sách không bị gập mép gáy hay rách góc trong quá trình lưu chuyển.
        </p>
      </section>

      <section>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          4. Chính sách đồng kiểm & Đổi trả trong 7 ngày
        </h2>
        <p style={{ marginBottom: '12px' }}>
          Quý khách được quyền <strong>mở hộp đồng kiểm</strong> ngoại quan cùng nhân viên giao nhận trước khi nhận hàng.
        </p>
        <p>
          BookStore hỗ trợ <strong>đổi mới 100% hoặc hoàn tiền</strong> trong vòng <strong>7 ngày</strong> kể từ khi nhận sách nếu:
        </p>
        <ul style={{ paddingLeft: '24px' }}>
          <li>Sách bị lỗi in ấn từ nhà xuất bản (trùng trang, mất trang, mờ chữ).</li>
          <li>Sách bị ướt, móp méo hoặc rách bìa do đơn vị vận chuyển.</li>
          <li>Giao nhầm tựa sách hoặc không đúng theo đơn đặt hàng.</li>
        </ul>
      </section>
    </PolicyLayout>
  );
};

export const PaymentGuide = () => {
  return (
    <PolicyLayout
      activePath="/payment-guide"
      title="Hướng Dẫn Thanh Toán"
      subtitle="Đa dạng phương thức thanh toán an toàn, bảo mật và tiện lợi"
    >
      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          1. Thanh toán khi nhận hàng (COD - Cash On Delivery)
        </h2>
        <div style={{ display: 'flex', gap: '14px', alignItems: 'flex-start', padding: '16px', borderRadius: 'var(--radius)', backgroundColor: '#f8fafc', border: '1px solid var(--border)' }}>
          <CheckCircle2 size={24} color="var(--primary)" style={{ flexShrink: 0, marginTop: '2px' }} />
          <div>
            <strong style={{ fontSize: '15px' }}>Thanh toán tiền mặt cho nhân viên giao hàng</strong>
            <p style={{ fontSize: '13px', color: 'var(--text-muted)', marginTop: '4px' }}>
              Quý khách chỉ cần chuẩn bị tiền mặt đúng với giá trị đơn hàng và thanh toán trực tiếp cho shipper khi nhận được kiện hàng sách tại nhà. Không phát sinh thêm bất kỳ phụ phí nào ngoài số tiền hiển thị trên hóa đơn.
            </p>
          </div>
        </div>
      </section>

      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          2. Thanh toán trực tuyến qua cổng VNPay
        </h2>
        <div style={{ display: 'flex', gap: '14px', alignItems: 'flex-start', padding: '16px', borderRadius: 'var(--radius)', backgroundColor: '#eff6ff', border: '1px solid #bfdbfe', marginBottom: '16px' }}>
          <CreditCard size={24} color="var(--primary)" style={{ flexShrink: 0, marginTop: '2px' }} />
          <div>
            <strong style={{ fontSize: '15px', color: 'var(--primary)' }}>Cổng thanh toán bảo mật quốc gia VNPay</strong>
            <p style={{ fontSize: '13px', color: '#1e40af', marginTop: '4px' }}>
              Hỗ trợ thanh toán nhanh chóng 24/7 thông qua ứng dụng ngân hàng hoặc thẻ quốc tế:
            </p>
          </div>
        </div>

        <ul style={{ paddingLeft: '24px', marginBottom: '12px' }}>
          <li><strong>Quét mã VNPay-QR:</strong> Mở ứng dụng ngân hàng (Vietcombank, MB Bank, Techcombank, BIDV, Agribank, VietinBank...) hoặc ví điện tử để quét mã thanh toán tức thì.</li>
          <li><strong>Thẻ ATM / Tài khoản ngân hàng nội địa:</strong> Hỗ trợ thanh toán trực tuyến qua hơn 30 ngân hàng tại Việt Nam có đăng ký Internet Banking.</li>
          <li><strong>Thẻ thanh toán quốc tế:</strong> Chấp nhận thẻ Visa, Mastercard, JCB phát hành bởi các ngân hàng trong nước và quốc tế.</li>
        </ul>
      </section>

      <section style={{ marginBottom: '28px' }}>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          3. Hướng dẫn sử dụng Mã Giảm Giá (Voucher)
        </h2>
        <ol style={{ paddingLeft: '24px' }}>
          <li>Tại trang <strong>Thanh Toán (Checkout)</strong>, quý khách sẽ thấy ô <em>"Mã giảm giá"</em> ở cột tóm tắt đơn hàng.</li>
          <li>Nhập mã khuyến mãi hợp lệ (ví dụ: mã giảm phần trăm hoặc mã giảm giá cố định) và nhấn <strong>Áp dụng</strong>.</li>
          <li>Hệ thống sẽ tự động trừ trực tiếp số tiền chiết khấu vào tổng thanh toán đơn hàng trước khi quý khách tiến hành đặt mua.</li>
        </ol>
      </section>

      <section>
        <h2 style={{ fontSize: '18px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '12px' }}>
          4. Xử lý sự cố thanh toán
        </h2>
        <p>
          Trong trường hợp tài khoản của bạn đã bị trừ tiền nhưng website chưa cập nhật trạng thái đơn hàng (do nghẽn mạng ngân hàng hoặc kết nối gián đoạn), quý khách hoàn toàn yên tâm: vui lòng giữ lại mã giao dịch ngân hàng và liên hệ ngay hotline <strong>1900 123 456</strong> hoặc gửi email tới <strong>support@bookstore.com</strong>. Hệ thống sẽ đối soát và kích hoạt đơn hàng trong vòng 15-30 phút.
        </p>
      </section>
    </PolicyLayout>
  );
};
