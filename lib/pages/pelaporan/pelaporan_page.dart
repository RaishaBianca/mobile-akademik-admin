import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/custombuttonone.dart';
import 'package:admin_fik_app/pages/pelaporan/kendalabaru_page.dart';
import 'package:admin_fik_app/pages/pelaporan/kendaladikerjakan_page.dart';
import 'package:admin_fik_app/pages/pelaporan/kendalaselesai_page.dart';
import 'package:admin_fik_app/pages/pelaporan/semuakendala_page.dart';
import 'package:admin_fik_app/pages/pelaporan/detailkendala_page.dart';

class PelaporanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pelaporan Kendala/Kerusakan Ruangan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[700], // Warna biru untuk AppBar
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
                          'Pelaporan Ruang Lab Komputer FIK',
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
                            CustomButtonOne(
                              label: 'Laporan Baru',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KendalabaruPage()),
                                );
                              },
                              subText: '6', // Angka tambahan di bawah label
                            ),
                            CustomButtonOne(
                              label: 'Laporan Dikerjakan',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KendaladikerjakanPage()),
                                );
                              },
                              subText: '12', // Angka tambahan di bawah label
                            ),
                          ],
                        ),
                        SizedBox(height: 20), // Jarak antara teks dan tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButtonOne(
                              label: 'Laporan Selesai',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => KendalaselesaiPage()),
                                );
                              },
                              subText: '6', // Angka tambahan di bawah label
                            ),
                            CustomButtonOne(
                              label: 'Semua Laporan',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SemuakendalaPage()),
                                );
                              },
                              subText: '12', // Angka tambahan di bawah label
                            ),
                          ],
                        ),
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Statistika Pelaporan Lab Komputer FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                        Container(
                          height: 300, // Ukuran tinggi gambar
                          width: double.infinity, // Ukuran gambar mengikuti lebar layar
                          child: Image.asset(
                            'assets/images/grafik.png', // Path gambar grafik lokal
                            fit: BoxFit.cover, // Menyesuaikan gambar ke dalam container
                          ),
                        ),
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Pelaporan Ruang Kelas FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                        SizedBox(height: 20), // Jarak antara teks dan tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButtonOne(
                              label: 'Laporan Baru',
                              onPressed: () {
                                // Aksi saat tombol ditekan
                              },
                              subText: '6', // Angka tambahan di bawah label
                            ),
                            CustomButtonOne(
                              label: 'Laporan Dikerjakan',
                              onPressed: () {
                                // Aksi saat tombol ditekan
                              },
                              subText: '12', // Angka tambahan di bawah label
                            ),
                          ],
                        ),
                        SizedBox(height: 20), // Jarak antara teks dan tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButtonOne(
                              label: 'Laporan Selesai',
                              onPressed: () {
                                // Aksi saat tombol ditekan
                              },
                              subText: '6', // Angka tambahan di bawah label
                            ),
                            CustomButtonOne(
                              label: 'Semua Laporan',
                              onPressed: () {
                                // Aksi saat tombol ditekan
                              },
                              subText: '12', // Angka tambahan di bawah label
                            ),
                          ],
                        ),
                        SizedBox(height: 30), // Jarak antara tombol dan teks baru
                        Text(
                          'Statistika Pelaporan Ruang Kelas FIK',
                          textAlign: TextAlign.left, // Teks rata kiri
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Jarak antara teks dan gambar grafik
                        Container(
                          height: 300, // Ukuran tinggi gambar
                          width: double.infinity, // Ukuran gambar mengikuti lebar layar
                          child: Image.asset(
                            'assets/images/grafik.png', // Path gambar grafik lokal
                            fit: BoxFit.cover, // Menyesuaikan gambar ke dalam container
                          ),
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
