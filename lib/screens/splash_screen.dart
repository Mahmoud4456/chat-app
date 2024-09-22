import 'package:firebase_e1/screens/components/constants.dart';
import 'package:firebase_e1/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static String id = "Splash screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> delay()async {
   await Future.delayed(const Duration(seconds: 5));
  Navigator.pushNamed(context, LoginScreen.id );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/chat_phone.json',
              height: 150,
            ),
            Image.asset(
              'assets/images/scholar.png',
              width: 150,
              height: 150,
            ),
           const SizedBox(height: 10),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                delay();
                return Transform.scale(
                  scale: 1.0 + (_animation.value * 0.1),
                  child: const Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                        fontFamily: "Pacifico"
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}





