import 'package:flutter/material.dart';

class Squaretile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const Squaretile({super.key, required this.imagePath, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromRGBO(30, 30, 30, 1),
          border: Border.all(color: Color.fromRGBO(30, 30, 30, 1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
