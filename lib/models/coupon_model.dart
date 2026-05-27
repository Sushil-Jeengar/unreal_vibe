class CouponResponse {
  final bool success;
  final String message;
  final CouponBooking? booking;

  CouponResponse({
    required this.success,
    required this.message,
    this.booking,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      booking: json['booking'] != null 
          ? CouponBooking.fromJson(json['booking']) 
          : null,
    );
  }
}

class CouponBooking {
  final String bookingId;
  final double originalAmount;
  final double discountAmount;
  final double finalAmount;
  final AppliedCoupon appliedCoupon;

  CouponBooking({
    required this.bookingId,
    required this.originalAmount,
    required this.discountAmount,
    required this.finalAmount,
    required this.appliedCoupon,
  });

  factory CouponBooking.fromJson(Map<String, dynamic> json) {
    return CouponBooking(
      bookingId: json['bookingId'] ?? '',
      originalAmount: (json['originalAmount'] ?? 0).toDouble(),
      discountAmount: (json['discountAmount'] ?? 0).toDouble(),
      finalAmount: (json['finalAmount'] ?? 0).toDouble(),
      appliedCoupon: AppliedCoupon.fromJson(json['appliedCoupon'] ?? {}),
    );
  }
}

class AppliedCoupon {
  final String code;
  final String type;
  final int value;

  AppliedCoupon({
    required this.code,
    required this.type,
    required this.value,
  });

  factory AppliedCoupon.fromJson(Map<String, dynamic> json) {
    return AppliedCoupon(
      code: json['code'] ?? '',
      type: json['type'] ?? '',
      value: json['value'] ?? 0,
    );
  }

  String get displayValue {
    switch (type.toUpperCase()) {
      case 'PERCENTAGE':
        return '$value%';
      case 'FIXED':
        return '₹$value';
      default:
        return '$value';
    }
  }
}