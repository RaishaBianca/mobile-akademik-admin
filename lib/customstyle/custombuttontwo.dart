import 'package:flutter/material.dart';

class CustomButtonTwo extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButtonTwo({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Padding default
          backgroundColor: Color(0xCCFF5833), // Background color fallback to primary
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({}) ??
              const TextStyle( // Fallback text style jika tidak ada di tema
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
