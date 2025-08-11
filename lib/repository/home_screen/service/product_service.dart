import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fake_store/repository/home_screen/model/product_model.dart';

class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$productsEndpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return productModelFromJson(jsonEncode(data));
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
} 