import 'package:flutter/material.dart';
import 'package:admin_fik_app/pages/pelaporan/detailkendala_page.dart';

class ReportCard extends StatelessWidget {
  final int id;
  final String nama_pelapor;
  final String nim_nrp;
  final String tanggal;
  final String nama_ruangan;
  final String jenis_kendala;
  final String bentuk_kendala;
  final String deskripsi_kendala;
  final String status; // Mengganti bool menjadi string untuk status
  final String? keterangan_penyelesaian;

  const ReportCard({
    Key? key,
    required this.id,
    required this.nama_pelapor,
    required this.nim_nrp,
    required this.tanggal,
    required this.nama_ruangan,
    required this.jenis_kendala,
    required this.bentuk_kendala,
    required this.deskripsi_kendala,
    required this.status, // Mengambil status sebagai string
    this.keterangan_penyelesaian,
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
                  id: id,
                  nama_pelapor: nama_pelapor,
                  nim_nrp: nim_nrp,
                  tanggal: tanggal,
                  nama_ruangan: nama_ruangan,
                  jenis_kendala: jenis_kendala,
                  bentuk_kendala: bentuk_kendala,
                  deskripsi_kendala: deskripsi_kendala,
                  status: status,
                  keterangan_penyelesaian: keterangan_penyelesaian ?? '',
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
                  Container(
                    width: 260, // Fixed width for the text
                    child: Text(
                      nama_pelapor,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // Truncate text with ellipsis
                      maxLines: 1, // Ensure text is a single line
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(tanggal),
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
                          Text(nama_ruangan),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.error_outline_rounded),
                          SizedBox(width: 12),
                          Text(jenis_kendala),
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
      case 'menunggu':
        return Colors.green[500]!;
      case 'dalam proses':
        return Colors.yellow[500]!;
      case 'selesai':
        return Colors.red[500]!;
      default:
        return Colors.grey; // Jika status tidak dikenali
    }
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'menunggu':
        return 'Menunggu';
      case 'dalam proses':
        return 'Dalam Proses';
      case 'selesai':
        return 'Selesai';
      default:
        return 'Unknown';
    }
  }
}