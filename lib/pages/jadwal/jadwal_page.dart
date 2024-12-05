import 'package:admin_fik_app/customstyle/barchart.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/custombutton.dart';
import 'package:admin_fik_app/pages/jadwal/jadwalkelas_page.dart';
import 'package:admin_fik_app/pages/jadwal/jadwallab_page.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({Key? key}) : super(key: key);

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: Text(
          'Jadwal',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white, // Warna putih untuk konten utama
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks dan elemen lainnya rata kiri
                      children: [
                        Text(
                          'Jadwal Penggunaan Ruang Lab dan Kelas FIK UPN Veteran Jakarta',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20), // Jarak antara teks dan tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButton(
                              label: 'Lihat Jadwal Lab Komputer',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => JadwallabPage()),
                                );
                              },
                            ),
                            CustomButton(
                              label: 'Lihat Jadwal Ruang Kelas',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => JadwalkelasPage()),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Statistika Kepadatan Penggunaan Ruangan Lab Komputer FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                        BarChart(room: 'lab', type: 'peminjaman',),
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Statistika Kepadatan Penggunaan Ruangan Kelas FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                        BarChart(room: 'kelas', type: 'peminjaman')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
