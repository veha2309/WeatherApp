import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade800, Colors.grey.shade400],
        ),
      ),
      child: Center(
        child: Text(
          "This Application is Developed by Vedant!!!!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
