import 'package:flutter/material.dart';
import 'package:admin_fik_app/pages/peminjaman/detailpeminjaman_page.dart';

class BookstatusCard extends StatelessWidget {
  final int id;
  final String studentName;
  final String no_tlp;
  final String grup_pengguna;
  final String inputDate;
  final String ruangan;
  final bool isAccepted;
  final String studentNim;
  final int groupSize;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final String time;
  // final String jumlahPengguna;
  final String keterangan;
  final String alasanPenolakan;
  final String catatan_kejadian;
  final bool is_active;
  final String status;

  const BookstatusCard({
    Key? key,
    required this.id,
    required this.studentName,
    required this.no_tlp,
    required this.grup_pengguna,
    required this.inputDate,
    required this.ruangan,
    required this.groupSize,
    required this.isAccepted,
    required this.studentNim,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.time,
    // required this.jumlahPengguna,
    required this.keterangan,
    required this.alasanPenolakan,
    required this.catatan_kejadian,
    required this.is_active,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailpeminjamanPage(
              id: id,
              studentName: studentName,
              no_tlp: no_tlp,
              studentNim: studentNim,
              grup_pengguna: grup_pengguna,
              inputDate: inputDate,
              ruangan: ruangan,
              time: "${jamMulai} - ${jamSelesai} WIB",
              bookDate: bookDate,
              jamMulai: jamMulai,
              jamSelesai: jamSelesai,
              jumlahPengguna: groupSize,
              // jumlahPengguna: jumlahPengguna,
              keterangan: keterangan,
              alasanPenolakan: alasanPenolakan,
              catatan_kejadian: catatan_kejadian,
              isAccepted: isAccepted,
              is_active: is_active,
              // status: status,
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
                          Text(groupSize.toString()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: is_active ? Colors.green[500] : Colors.red[500],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      is_active ? 'true' : 'false',
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