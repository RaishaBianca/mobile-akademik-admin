import 'package:flutter/material.dart';
import 'package:admin_fik_app/data/dummy_report.dart';
import 'package:admin_fik_app/pages/pelaporan/detailkendala_page.dart';

class ReportCard extends StatelessWidget {
  final String studentName;
  final String inputDate;
  final String ruangan;
  final String jenis;
  final String status; // Mengganti bool menjadi string untuk status

  const ReportCard({
    Key? key,
    required this.studentName,
    required this.inputDate,
    required this.ruangan,
    required this.jenis,
    required this.status, // Mengambil status sebagai string
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailkendalaPage(
                  // labName: DummyReport.labName,
                  studentName: DummyReport.studentName,
                  studentNim: DummyReport.studentNim,
                  inputDate: DummyReport.inputDate,
                  ruangan: DummyReport.ruangan,
                  jenis: DummyReport.jenis,
                  bentuk: DummyReport.bentuk,
                  deskripsi: DummyReport.deskripsi,
                ),
          ),);
      },
      child: Card(
        elevation: 4,
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(studentName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,)
                  ),
                  SizedBox(width: 150),
                  Expanded(
                    child: Text(inputDate),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_pin),
                          SizedBox(width: 12),
                          Text(ruangan),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.error_outline_rounded),
                          SizedBox(width: 12),
                          Text(jenis),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: _getStatusColor(), // Function to get status color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status, // Display status
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menentukan warna berdasarkan status
  Color _getStatusColor() {
    switch (status) {
      case 'Baru':
        return Colors.green[500]!;
      case 'Pengerjaan':
        return Colors.yellow[500]!;
      case 'Selesai':
        return Colors.red[500]!;
      default:
        return Colors.grey; // Jika status tidak dikenali
    }
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'Belum Dikerjakan':
        return 'Baru';
      case 'Sedang Dikerjakan':
        return 'Pengerjaan';
      case 'Selesai':
        return 'Selesai';
      default:
        return 'Unknown';
    }
  }
}