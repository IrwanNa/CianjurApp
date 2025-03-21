import 'package:flutter/material.dart';

class ReportButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const ReportButton({
    super.key,
    required this.label,
    this.backgroundColor = Colors.lightBlue,
    this.textColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding:
              const EdgeInsets.symmetric(vertical: 16.0), // Fixed padding usage
        ),
        onPressed: onPressed, // Correct placement of onPressed
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
