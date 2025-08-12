import 'package:get/get.dart';
import 'package:fake_store/repository/home_screen/model/product_model.dart';
import 'package:fake_store/repository/home_screen/service/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();
  
  final RxBool isLoading = false.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final productList = await _productService.getProducts();
      products.value = productList;
      
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }
} 