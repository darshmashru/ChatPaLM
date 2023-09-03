import 'package:flutter/material.dart';

class Squaretile extends StatelessWidget {
  final String imagePath;
  const Squaretile({super.key, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
