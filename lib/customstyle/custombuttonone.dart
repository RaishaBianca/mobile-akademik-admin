import 'package:flutter/material.dart';

class CustomButtonOne extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final String? subText; // Tambahkan parameter opsional subText

  const CustomButtonOne({
    Key? key,
    required this.label,
    required this.onPressed,
    this.subText, // SubText opsional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 80, // Update tinggi untuk menampung subText jika ada
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Padding default
          backgroundColor: Color(0xCCFF5833), // Background color fallback to primary
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan elemen di tengah tombol
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({}) ??
                  const TextStyle( // Fallback text style jika tidak ada di tema
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            if (subText != null) ...[
              const SizedBox(height: 5), // Jarak antara label dan subText
              Text(
                subText!,
                style: const TextStyle( // Fallback subText style
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
