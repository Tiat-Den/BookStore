namespace BookStore.Domain.Enums;

public enum UserStatus
{
    Active = 1,
    Inactive = 2,
    Locked = 3
}

public enum BookStatus
{
    Draft = 0,
    Active = 1,
    OutOfStock = 2,
    Discontinued = 3
}

public static class OrderStatusConstants
{
    public const string Pending = "PENDING";
    public const string Confirmed = "CONFIRMED";
    public const string Processing = "PROCESSING";
    public const string Shipping = "SHIPPING";
    public const string Delivered = "DELIVERED";
    public const string Cancelled = "CANCELLED";
    public const string Returned = "RETURNED";
}

public static class PaymentStatusConstants
{
    public const string Pending = "PENDING";
    public const string Paid = "PAID";
    public const string Failed = "FAILED";
    public const string Refunded = "REFUNDED";
}

public static class PaymentMethodConstants
{
    public const string COD = "COD";
    public const string VNPay = "VNPAY";
    public const string MoMo = "MOMO";
    public const string BankTransfer = "BANK_TRANSFER";
}

public static class CouponTypeConstants
{
    public const string Percent = "PERCENT";
    public const string FixedAmount = "FIXED_AMOUNT";
}

public static class InventoryTransactionTypeConstants
{
    public const string Import = "IMPORT";
    public const string Export = "EXPORT";
    public const string Adjustment = "ADJUSTMENT";
    public const string Return = "RETURN";
}
