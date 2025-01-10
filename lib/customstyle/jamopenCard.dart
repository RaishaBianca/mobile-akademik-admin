import 'package:flutter/material.dart';

class JamopenCard extends StatelessWidget {
  final String jamMulai;
  final String jamSelesai;
  final Function(String, String) onChanged;

  const JamopenCard({
    Key? key,
    required this.jamMulai,
    required this.jamSelesai,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text('Jam Mulai'),
                Text(jamMulai, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Text('Jam Selesai'),
                Text(jamSelesai, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}