import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/bookingCard.dart'; // Import BookingCard
import 'package:admin_fik_app/data/dummy_data.dart'; // Import dummy data

class MenungguPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Daftar Belum Dikonfirmasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            BookingCard(
              studentName: DummyData.studentName,
              inputDate: DummyData.bookDate,
              time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
              ruangan: DummyData.ruangan,
              groupSize: "${DummyData.jumlahPengguna} Orang",
              onAccept: () {
                // Aksi saat tombol 'Terima' ditekan
              },
              onReject: () {
                // Aksi saat tombol 'Tolak' ditekan
              },
            ),
            SizedBox(height: 16),
            BookingCard(
              studentName: DummyData.studentName,
              inputDate: DummyData.bookDate,
              time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
              ruangan: DummyData.ruangan,
              groupSize: "${DummyData.jumlahPengguna} Orang",
              onAccept: () {
                // Aksi saat tombol 'Terima' ditekan
              },
              onReject: () {
                // Aksi saat tombol 'Tolak' ditekan
              },
            ),
            SizedBox(height: 16),
            BookingCard(
              studentName: DummyData.studentName,
              inputDate: DummyData.bookDate,
              time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
              ruangan: DummyData.ruangan,
              groupSize: "${DummyData.jumlahPengguna} Orang",
              onAccept: () {
                // Aksi saat tombol 'Terima' ditekan
              },
              onReject: () {
                // Aksi saat tombol 'Tolak' ditekan
              },
            ),
          ],
        ),
      ),
    );
  }
}
