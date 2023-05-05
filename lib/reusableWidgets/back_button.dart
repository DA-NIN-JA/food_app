import 'package:flutter/material.dart';
import '../constants.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kblack,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          const BoxShadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 1))
        ],
      ),
      child: const Center(
        child: Icon(Icons.arrow_back, color: kwhite, size: 28),
      ),
    );
  }
}