import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/reportCard.dart';
import 'package:admin_fik_app/data/dummy_data.dart'; // Import dummy data

class KendalabaruPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Semua Daftar Laporan Kendala',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            ReportCard(
              studentName: DummyData.studentName,
              inputDate: DummyData.bookDate,
              time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
              ruangan: DummyData.ruangan,
              groupSize: "${DummyData.jumlahPengguna} Orang",
              status: 'Baru',
            ),
            SizedBox(height: 16),
            ReportCard(
              studentName: DummyData.studentName,
              inputDate: DummyData.bookDate,
              time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
              ruangan: DummyData.ruangan,
              groupSize: "${DummyData.jumlahPengguna} Orang",
              status: 'Baru',
            ),
            SizedBox(height: 16),
            ReportCard(
              studentName: DummyData.studentName,
              inputDate: DummyData.bookDate,
              time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
              ruangan: DummyData.ruangan,
              groupSize: "${DummyData.jumlahPengguna} Orang",
              status: 'Baru',
            ),
          ],
        ),
      ),
    );
  }
}
