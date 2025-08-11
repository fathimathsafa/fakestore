import 'package:flutter/material.dart';
import 'package:fake_store/core/constants/color_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
    
    // Navigate after 3 seconds
   // _navigateToNextScreen();
  }

  // void _navigateToNextScreen() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     if (mounted) {
  //       Navigator.pushReplacement(
  //         context,
  //         PageRouteBuilder(
  //           pageBuilder: (context, animation, secondaryAnimation) => LogInScreen(),
  //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //             const begin = Offset(1.0, 0.0);
  //             const end = Offset.zero;
  //             const curve = Curves.easeInOut;

  //             var tween = Tween(begin: begin, end: end).chain(
  //               CurveTween(curve: curve),
  //             );

  //             return SlideTransition(
  //               position: animation.drive(tween),
  //               child: child,
  //             );
  //           },
  //           transitionDuration: const Duration(milliseconds: 500),
  //         ),
  //       );
  //     }
  //   });
  // }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Responsive values
    final isTablet = screenWidth > 600;
    final fontSize = isTablet ? 48.0 : 36.0;
    final letterSpacing = isTablet ? 2.0 : 1.5;
    final spacing = isTablet ? 20.0 : 15.0;
    final iconSize = isTablet ? 30.0 : 25.0;
    final strokeWidth = isTablet ? 2.0 : 1.5;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: ColorTheme.primaryGradient,
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Icon
                    
                      
                      // App Name
                      Text(
                        'SnapCart',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w900,
                          color: ColorTheme.lightTextColor,
                          letterSpacing: letterSpacing,
                          fontFamily: 'Arial',
                        ),
                      ),
                      
                      SizedBox(height: 8),
                      
                      // Tagline
                      Text(
                        'Your Ultimate Shopping Destination',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 14,
                          color: ColorTheme.lightTextColor.withOpacity(0.9),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      
                      SizedBox(height: spacing + 20),
                      
                      // Loading indicator
                      SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorTheme.lightTextColor,
                          ),
                          strokeWidth: strokeWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
