import 'package:flutter/material.dart';
import 'package:admin_fik_app/data/kode_dummy.dart';

class JamCard extends StatelessWidget {
  final String jamMulai;
  final String jamSelesai;

  const JamCard({
    Key? key,
    required this.jamMulai,
    required this.jamSelesai,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1, // Lebih kecil dibandingkan kolom mata kuliah
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            jamMulai,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            jamSelesai,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
