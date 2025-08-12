import 'dart:developer';
import 'package:fake_store/repository/login_screen/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginService _authService = LoginService();
  
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString token = ''.obs;

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authService.login(username, password);

      if (response['success'] == true && response['token'] != null) {
        token.value = response['token'];
        isLoggedIn.value = true;
        errorMessage.value = '';
        
        log('=== LOGIN SUCCESS ===');
        log('Token: ${response['token']}');
        log('Success: ${response['success']}');
        log('Message: ${response['message']}');
        log('Full Response: ${response['data']}');
        log('====================');
        
        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
        );
        
        Get.offAllNamed('/home');
        
      } else {
        errorMessage.value = response['message'] ?? 'Login failed';
        
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

  void logout() {
    token.value = '';
    isLoggedIn.value = false;
    errorMessage.value = '';
    
   
  }

 
  void clearError() {
    errorMessage.value = '';
  }
} 