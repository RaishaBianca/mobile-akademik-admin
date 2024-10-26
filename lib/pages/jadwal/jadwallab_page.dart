import 'package:admin_fik_app/customstyle/barchart.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/custombutton.dart';
import 'package:admin_fik_app/customstyle/custombuttontwo.dart';
import 'package:admin_fik_app/customstyle/notificationCard.dart';
import 'package:admin_fik_app/pages/jadwal/jadwalkelas_page.dart';
import 'package:admin_fik_app/customstyle/cardConfirmed.dart';
import 'package:admin_fik_app/pages/jadwal/kodedosenmk_page.dart';
import 'package:admin_fik_app/data/dummy_data.dart';

import 'package:flutter_sales_graph/flutter_sales_graph.dart';

class JadwallabPage extends StatefulWidget {
  const JadwallabPage({Key? key}) : super(key: key);

  @override
  State<JadwallabPage> createState() => _JadwallabPageState();
}

class _JadwallabPageState extends State<JadwallabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false, // Disable back button
        title: Text(
          'Home Lita',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
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
                          'Pemakaian Ruang Lab dan Kelas FIK UPNVJ',
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
                              label: 'Lihat Jadwal Ruang Lab',
                              onPressed: () {
                                // Aksi ketika tombol ditekan
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
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButtonTwo(
                              label: 'Lihat Jadwal KRSku',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KodedosenmkPage()),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Peminjaman Ruang Lab dan Kelas FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButton(
                              label: 'Ajukan Peminjaman Ruang Lab',
                              onPressed: () {
                                // Aksi ketika tombol ditekan
                              },
                            ),
                            CustomButton(
                              label: 'Ajukan Peminjaman Ruang Kelas',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => JadwalkelasPage()),
                                );
                              },
                            ),
                          ],
                        ), // Tutup Row
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Pelaporan Kendala Lab dan Kelas FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20), // Jarak antara teks dan gambar grafik
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButton(
                              label: 'Ajukan Kendala Lab',
                              onPressed: () {
                                // Aksi ketika tombol ditekan
                              },
                            ),
                            CustomButton(
                              label: 'Ajukan Kendala Kelas',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => JadwalkelasPage()),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        CardConfirmed(
                          studentName: DummyData.studentName,
                          studentNim: DummyData.studentNim,
                          inputDate: DummyData.bookDate,
                          time: "${DummyData.jamMulai} - ${DummyData.jamSelesai} WIB",
                          ruangan: DummyData.ruangan,
                          groupSize: "${DummyData.jumlahPengguna} Orang",
                          isAccepted: true, bookDate: '', jamMulai: '', jamSelesai: '', jumlahPengguna: '', keterangan: '', // Atur sesuai status
                        ),
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
