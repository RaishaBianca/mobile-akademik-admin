import 'package:flutter/material.dart';

class MkCard extends StatelessWidget {
  final String mkName;
  final String mkCode;

  MkCard({required this.mkName, required this.mkCode});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100], // Background warna untuk mata kuliah
          borderRadius: BorderRadius.circular(12), // Tambahkan border radius
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mkName, // Data Mata Kuliah
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              mkCode, // Kode Mata Kuliah
              overflow: TextOverflow.ellipsis,
            ),
            // Tambahan teks untuk testing jika diperlukan
            Text(
              mkName, // Data Mata Kuliah
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              mkCode, // Kode Mata Kuliah
            ),
          ],
        ),
      ),
    );
  }
}
