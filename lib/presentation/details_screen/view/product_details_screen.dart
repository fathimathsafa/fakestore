import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fake_store/core/constants/color_constants.dart';
import 'package:fake_store/presentation/details_screen/controller/product_details_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;
  
  const ProductDetailsScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductDetailsController controller = Get.put(ProductDetailsController());
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProductDetails(productId);
    });

    return Scaffold(
      backgroundColor: ColorTheme.backgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorTheme.primaryColor),
              ),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: ColorTheme.errorColor,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Error loading product',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.errorColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    controller.errorMessage.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorTheme.secondaryTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () => controller.fetchProductDetails(productId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final product = controller.product.value;
          if (product == null) {
            return Center(
              child: Text(
                'No product found',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorTheme.secondaryTextColor,
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300.h,
                pinned: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                      Icons.arrow_back,
                      color: ColorTheme.primaryTextColor,
                    ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: ColorTheme.backgroundColor,
                    child: Center(
                      child: product.image != null
                          ? Image.network(
                              product.image!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: ColorTheme.backgroundColor,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 80.sp,
                                    color: ColorTheme.secondaryTextColor,
                                  ),
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: ColorTheme.backgroundColor,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                      valueColor: AlwaysStoppedAnimation<Color>(ColorTheme.primaryColor),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: ColorTheme.backgroundColor,
                              child: Icon(
                                Icons.image_not_supported,
                                size: 80.sp,
                                color: ColorTheme.secondaryTextColor,
                              ),
                            ),
                    ),
                  ),
                ),
              ),

            
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        product.title ?? 'No Title',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.primaryTextColor,
                          height: 1.3,
                        ),
                      ),
                      
                      SizedBox(height: 16.h),
                      
                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: ColorTheme.secondaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16.sp,
                                      color: ColorTheme.secondaryColor,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      '${product.rating?.rate?.toStringAsFixed(1) ?? '0.0'}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ColorTheme.secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '(${product.rating?.count ?? 0} reviews)',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorTheme.secondaryTextColor,
                                ),
                              ),
                            ],
                          ),
                          
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              gradient: ColorTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 24.h),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: ColorTheme.accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          product.category ?? 'No Category',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorTheme.accentColor,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 24.h),
                      
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.primaryTextColor,
                        ),
                      ),
                      
                      SizedBox(height: 12.h),
                      
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          product.description ?? 'No description available',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorTheme.secondaryTextColor,
                            height: 1.5,
                          ),
                        ),
                      ),
                      
                      
                      
                      
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
} 