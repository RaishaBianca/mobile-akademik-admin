import 'package:flutter/material.dart';
import 'package:admin_fik_app/pages/peminjaman/detailpeminjaman_page.dart';

class CardConfirmed extends StatelessWidget {
  final String studentName;
  final String inputDate;
  final String ruangan;
  final bool isAccepted;
  final String studentNim;
  final String groupSize;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String jumlahPengguna;
  final String keterangan;

  const CardConfirmed({
    Key? key,
    required this.studentName,
    required this.inputDate,
    required this.ruangan,
    required this.groupSize,
    required this.isAccepted,
    required this.studentNim,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPengguna,
    required this.keterangan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailpeminjamanPage(
              studentName: studentName,
              studentNim: studentNim,
              inputDate: inputDate,
              ruangan: ruangan,
              time: "${jamMulai} - ${jamSelesai} WIB",
              bookDate: bookDate,
              jamMulai: jamMulai,
              jamSelesai: jamSelesai,
              jumlahPengguna: jumlahPengguna,
              keterangan: keterangan,
              isAccepted: isAccepted,
            ),
          ),
        );
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    studentName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(inputDate),
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
                          Icon(Icons.access_time),
                          SizedBox(width: 12),
                          Text("${jamMulai} - ${jamSelesai} WIB"),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.location_pin),
                          SizedBox(width: 12),
                          Text(ruangan),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.group),
                          SizedBox(width: 12),
                          Text(groupSize),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: isAccepted ? Colors.green[500] : Colors.red[500],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isAccepted ? 'Diterima' : 'Ditolak',
                      style: TextStyle(
                        color: Colors.white,
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
}