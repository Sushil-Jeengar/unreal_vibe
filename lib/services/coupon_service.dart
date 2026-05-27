import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_routes.dart';
import 'user_storage.dart';

class CouponService {
  /// Apply coupon to a booking
  static Future<Map<String, dynamic>> applyCoupon({
    required String bookingId,
    required String couponCode,
  }) async {
    try {
      final endpoint = ApiConfig.applyCoupon;
      print('═══════════════════════════════════════════════════════');
      print('🎫 APPLY COUPON DEBUG LOG');
      print('═══════════════════════════════════════════════════════');
      print('📍 Endpoint: $endpoint');
      print('🎯 Booking ID: $bookingId');
      print('🎟️ Coupon Code: $couponCode');
      
      // Get auth token
      final token = await UserStorage.getToken();
      final isLoggedIn = await UserStorage.getLoginStatus();
      
      if (token == null || !isLoggedIn) {
        print('\n❌ AUTHENTICATION REQUIRED - no valid token');
        throw Exception('AUTHENTICATION_REQUIRED');
      }
      
      final requestBody = {
        'bookingId': bookingId,
        'couponCode': couponCode.toUpperCase(),
      };
      
      print('\n📦 REQUEST BODY:');
      print(json.encode(requestBody));
      
      final headers = await ApiConfig.getAuthHeadersWithCookies(token);
      print('\n🔐 REQUEST HEADERS:');
      headers.forEach((key, value) {
        if (key.toLowerCase() == 'authorization' || key.toLowerCase() == 'cookie') {
          print('  ├─ $key: ${value.substring(0, 60)}...');
        } else {
          print('  ├─ $key: $value');
        }
      });
      
      print('\n🚀 SENDING COUPON REQUEST...');
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: json.encode(requestBody),
      ).timeout(const Duration(seconds: 10));

      print('\n📥 RESPONSE RECEIVED:');
      print('  ├─ Status Code: ${response.statusCode}');
      print('  ├─ Response Body: ${response.body}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['success'] == true) {
          print('\n✅ COUPON APPLIED SUCCESSFULLY');
          
          // Log coupon details
          final booking = data['booking'];
          if (booking != null) {
            print('  ├─ Original Amount: ₹${booking['originalAmount']}');
            print('  ├─ Discount Amount: ₹${booking['discountAmount']}');
            print('  ├─ Final Amount: ₹${booking['finalAmount']}');
            
            final appliedCoupon = booking['appliedCoupon'];
            if (appliedCoupon != null) {
              print('  ├─ Coupon Code: ${appliedCoupon['code']}');
              print('  ├─ Coupon Type: ${appliedCoupon['type']}');
              print('  ├─ Coupon Value: ${appliedCoupon['value']}');
            }
          }
          
          print('═══════════════════════════════════════════════════════\n');
          return data;
        } else {
          print('\n❌ API RETURNED success: false');
          final message = data['message'] ?? 'Coupon application failed';
          print('  └─ Error: $message');
          print('═══════════════════════════════════════════════════════\n');
          throw Exception('COUPON_ERROR: $message');
        }
      } else if (response.statusCode == 400) {
        print('\n❌ 400 BAD REQUEST');
        try {
          final errorData = json.decode(response.body);
          final message = errorData['message'] ?? 'Invalid coupon request';
          print('  └─ Error: $message');
          print('═══════════════════════════════════════════════════════\n');
          
          if (message.toLowerCase().contains('invalid') ||
              message.toLowerCase().contains('expired') ||
              message.toLowerCase().contains('not found')) {
            throw Exception('INVALID_COUPON: $message');
          } else if (message.toLowerCase().contains('already used') ||
                     message.toLowerCase().contains('limit exceeded')) {
            throw Exception('COUPON_LIMIT: $message');
          } else {
            throw Exception('COUPON_ERROR: $message');
          }
        } catch (e) {
          if (e.toString().startsWith('Exception: ')) {
            rethrow; // Re-throw our custom exceptions
          }
          throw Exception('COUPON_ERROR: Invalid coupon code or request.');
        }
      } else if (response.statusCode == 401) {
        print('\n❌ 401 UNAUTHORIZED');
        await UserStorage.clearAll();
        throw Exception('AUTHENTICATION_REQUIRED: Please log in again to apply coupons.');
      } else if (response.statusCode == 404) {
        print('\n❌ 404 NOT FOUND');
        print('═══════════════════════════════════════════════════════\n');
        throw Exception('BOOKING_NOT_FOUND: Booking not found or coupon service unavailable.');
      } else if (response.statusCode >= 500) {
        print('\n❌ ${response.statusCode} SERVER ERROR');
        print('═══════════════════════════════════════════════════════\n');
        throw Exception('SERVER_ERROR: Coupon service is temporarily unavailable. Please try again.');
      } else {
        print('\n❌ UNEXPECTED STATUS CODE: ${response.statusCode}');
        print('═══════════════════════════════════════════════════════\n');
        try {
          final errorData = json.decode(response.body);
          throw Exception('COUPON_ERROR: ${errorData['message'] ?? 'Unexpected error occurred'}');
        } catch (e) {
          throw Exception('COUPON_ERROR: Unable to apply coupon. Please try again.');
        }
      }
    } catch (e) {
      print('\n💥 COUPON EXCEPTION CAUGHT:');
      print('  └─ Error: $e');
      print('═══════════════════════════════════════════════════════\n');
      rethrow;
    }
  }
}