import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  ///test
  final String apiKey = 'pk_test_StgxybGgBpWC5y3Z3BQrbVP2wMU9xmcvKoZT2dPx';
  ///live
  // final String apiKey = 'pk_live_Gb3HfRBEW7qYo1341dLBWTpNR3uiZwfyRKVoJJor';


  final String apiUrl = 'https://api.moyasar.com/v1/payments';

  Future<PaymentResult> createPayment({
    required double amount,
    required String currency,
    required String description,
    required String callbackUrl,
    required String sourceType,
    required String sourceName,
    required String sourceNumber,
    required String sourceCvc,
    required String sourceMonth,
    required String sourceYear,
  }) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$apiKey:'))}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'amount': (amount * 100).toInt(), // التحويل إلى هللة
        'currency': currency,
        'description': description,
        'callback_url': callbackUrl,
        'source': {
          'type': sourceType,
          'name': sourceName,
          'number': sourceNumber,
          'cvc': sourceCvc,
          'month': sourceMonth,
          'year': sourceYear,
        },
      }),
    );

    if (response.statusCode == 201) {
      print('Payment created successfully');
      return PaymentResult(success: true);
    } else {
      print('Failed to create payment: ${response.body}');
      return PaymentResult(success: false);
    }
  }
}
class PaymentResult {
  final bool success;
  PaymentResult({required this.success});
}