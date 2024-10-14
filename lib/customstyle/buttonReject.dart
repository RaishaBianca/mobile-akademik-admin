import 'package:flutter/material.dart';

class ButtonReject extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ButtonReject({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Adjusted width
      height: 40, // Adjusted height
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Reduced padding
          backgroundColor: Colors.red[500], // Background color fallback to primary
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({}) ??
              const TextStyle( // Fallback text style jika tidak ada di tema
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}