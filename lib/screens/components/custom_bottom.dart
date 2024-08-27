import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom({super.key, required this.onTap ,required this.text});
  final String text ;
 final VoidCallback? onTap ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 55,
        width: double.infinity,
        child: Center(
          child: Text(
           text,
            style: const TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
