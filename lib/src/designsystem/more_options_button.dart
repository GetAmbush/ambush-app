import 'package:flutter/material.dart';

class MoreOptionsButton extends StatelessWidget {
  const MoreOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Reduced width
      height: 50, // Reduced height
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.purple.shade200,
          width: 2, // Adjusted border width
        ),
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2), // Adjusted padding
              child: CircleAvatar(
                radius: 3, // Reduced radius for smaller dots
                backgroundColor: Colors.purple.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}