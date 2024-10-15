import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/reportCard.dart';
import 'package:admin_fik_app/data/dummy_report.dart'; // Import dummy data

class KendalaselesaiPage extends StatelessWidget {
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
              studentName: DummyReport.studentName,
              inputDate: DummyReport.inputDate,
              ruangan: DummyReport.ruangan,
              jenis: DummyReport.jenis,
              status: 'Selesai',
            ),
            SizedBox(height: 16),
            ReportCard(
              studentName: DummyReport.studentName,
              inputDate: DummyReport.inputDate,
              ruangan: DummyReport.ruangan,
              jenis: DummyReport.jenis,
              status: 'Selesai',
            ),
            SizedBox(height: 16),
            ReportCard(
              studentName: DummyReport.studentName,
              inputDate: DummyReport.inputDate,
              ruangan: DummyReport.ruangan,
              jenis: DummyReport.jenis,
              status: 'Selesai',
            ),
          ],
        ),
      ),
    );
  }
}
