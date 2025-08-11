import 'dart:developer';
import 'package:fake_store/repository/login_screen/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginService _authService = LoginService();
  
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString token = ''.obs;

  // Login method
  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authService.login(username, password);

      if (response['success'] == true && response['token'] != null) {
        token.value = response['token'];
        isLoggedIn.value = true;
        errorMessage.value = '';
        
        // Log the response to console
        log('=== LOGIN SUCCESS ===');
        log('Token: ${response['token']}');
        log('Success: ${response['success']}');
        log('Message: ${response['message']}');
        log('Full Response: ${response['data']}');
        log('====================');
        
        // Show success message
        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
        );
        
        // Navigate to home screen
        Get.offAllNamed('/home');
        
      } else {
        errorMessage.value = response['message'] ?? 'Login failed';
        
        // Show error message
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Logout method
  void logout() {
    token.value = '';
    isLoggedIn.value = false;
    errorMessage.value = '';
    
    // Navigate to login screen
    // Get.offAllNamed('/login');
  }

  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }
} 