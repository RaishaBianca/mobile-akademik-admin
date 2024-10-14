import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/custombutton.dart';
import 'package:admin_fik_app/customstyle/custombuttontwo.dart';
import 'package:admin_fik_app/pages/jadwal/jadwalkelas_page.dart';
import 'package:admin_fik_app/pages/jadwal/kodedosenmk_page.dart';

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
        title: Text(
          'Jadwal',
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
                          'Jadwal Penggunaan Ruangan FIK UPN Veteran Jakarta',
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
                        ), // Tutup Row
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur spasi antar tombol
                          children: [
                            CustomButtonTwo(
                              label: 'Lihat Kode Dosen dan Mata Kuliah',
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
                          'Statistika Kepadatan Penggunaan Ruangan Lab Komputer FIK',
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
                          'Statistika Kepadatan Penggunaan Ruangan Kelas FIK',
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
