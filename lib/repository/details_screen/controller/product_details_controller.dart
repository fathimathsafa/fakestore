import 'package:get/get.dart';
import 'package:fake_store/repository/details_screen/model/single_product_model.dart';
import 'package:fake_store/repository/details_screen/service/product_details_service.dart';

class ProductDetailsController extends GetxController {
  final ProductDetailsService _productDetailsService = ProductDetailsService();
  
  // Observable variables
  final RxBool isLoading = false.obs;
  final Rx<SingleProductModel?> product = Rx<SingleProductModel?>(null);
  final RxString errorMessage = ''.obs;

  // Fetch product details method
  Future<void> fetchProductDetails(int productId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final productDetails = await _productDetailsService.getProductDetails(productId);
      product.value = productDetails;
      
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error fetching product details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Clear data when leaving screen
  void clearData() {
    product.value = null;
    errorMessage.value = '';
  }
} 