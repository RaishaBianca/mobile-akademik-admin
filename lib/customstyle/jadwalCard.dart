import 'package:flutter/material.dart';

class JadwalCard extends StatelessWidget {
  final String namaMatkul;
  final String kodeMatkul;
  final String namaDosen;
  final String kodeDosen;
  final String ruangan;

  JadwalCard({
    required this.namaMatkul,
    required this.kodeMatkul,
    required this.namaDosen,
    required this.kodeDosen,
    required this.ruangan,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xCCFF5833), // Background warna untuk mata kuliah
          borderRadius: BorderRadius.circular(12), // Tambahkan border radius
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              namaMatkul, // Data Mata Kuliah
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              kodeMatkul, // Kode Mata Kuliah
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_pin, color: Colors.white,),
                SizedBox(width: 12),
                Text(ruangan, style: TextStyle(color: Colors.white,),),
              ],
            ),
            Row(
              children: [
                Icon(Icons.person, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(namaDosen, style: TextStyle(color: Colors.white),),
                      Text(kodeDosen, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}