import 'package:flutter/material.dart';

class MonthCard extends StatelessWidget {
  final String kegiatan;
  final String tgl_mulai;
  final String tgl_selesai;

  const MonthCard({
    Key? key,
    required this.kegiatan,
    required this.tgl_mulai,
    required this.tgl_selesai,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          "$tgl_mulai - $tgl_selesai : $kegiatan,",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}