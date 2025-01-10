import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/buttonaccept.dart';
import 'package:admin_fik_app/customstyle/buttonreject.dart';
import 'package:admin_fik_app/pages/peminjaman/detailpeminjaman_page.dart';

class BookingCard extends StatelessWidget {
  final int id;
  final String ruangan;
  final String studentName;
  final String no_tlp;
  final String grup_pengguna;
  final String inputDate;
  final String bookDate;
  final String time;
  final int groupSize;
  final String status;
  final String studentNim;
  final String keterangan;
  final String alasanPenolakan;
  final String catatan_kejadian;
  final Function onAccept;
  final Function onReject;

  const BookingCard({
    Key? key,
    required this.id,
    required this.ruangan,
    required this.studentName,
    required this.no_tlp,
    required this.grup_pengguna,
    required this.inputDate,
    required this.bookDate,
    required this.studentNim,
    required this.keterangan,
    required this.time,
    required this.groupSize,
    required this.status,
    required this.alasanPenolakan,
    required this.catatan_kejadian,
    required this.onAccept,
    required this.onReject,
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
              bookDate: bookDate,
              jamMulai: time.split(' - ')[0],
              jamSelesai: time.split(' - ')[1].replaceAll(' WIB', ''),
              jumlahPengguna: groupSize,
              keterangan: keterangan,
              alasanPenolakan: alasanPenolakan,
              catatan_kejadian: catatan_kejadian,
              isAccepted: status == 'disetujui',
              is_active: true,
              time: time,
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
                      fontSize: 16,
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
                          Text(time),
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
                          Text(groupSize.toString() + ' Orang'),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(status == 'menunggu')...[
                        ButtonAccept(
                          label: 'Terima',
                          onPressed: () => onAccept(),
                        ),
                        SizedBox(height: 12),
                        ButtonReject(
                          label: 'Tolak',
                          onPressed: () => onReject(),
                        ),
                      ],
                      if(status == 'accepted')
                        Text(
                          'Diterima',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if(status == 'rejected')
                        Text(
                          'Ditolak',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
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