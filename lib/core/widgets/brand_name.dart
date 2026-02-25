import 'package:flutter/material.dart';

class BrandName extends StatelessWidget {
  const BrandName({super.key, required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      "VELORA",
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }
}
