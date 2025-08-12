import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fake_store/repository/details_screen/model/single_product_model.dart';

class ProductDetailsService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<SingleProductModel> getProductDetails(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$productId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return SingleProductModel.fromJson(data);
      } else {
        throw Exception('Failed to load product details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
} 