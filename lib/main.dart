import 'package:flutter/material.dart';
import 'package:admin_fik_app/pages/jadwal/jadwal_page.dart';
import 'package:admin_fik_app/pages/jadwal/kodedosenmk_page.dart';
import 'package:admin_fik_app/pages/peminjaman/peminjaman_page.dart'; //
import 'package:admin_fik_app/pages/peminjaman/menunggu_page.dart'; //
import 'package:admin_fik_app/pages/peminjaman/terkonfirmasi_page.dart';
import 'package:admin_fik_app/pages/peminjaman/semuadaftar_page.dart';
import 'package:admin_fik_app/pages/peminjaman/detailpeminjaman_page.dart';
import 'package:admin_fik_app/pages/pelaporan/pelaporan_page.dart'; //
import 'package:admin_fik_app/pages/pelaporan/kendalabaru_page.dart';
import 'package:admin_fik_app/pages/pelaporan/detailkendala_page.dart';

import 'package:admin_fik_app/pages/profile/profile_page.dart'; //
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_sales_graph/flutter_sales_graph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0; // Menyimpan indeks halaman yang dipilih

  // Daftar halaman yang ditampilkan berdasarkan indeks
  final List<Widget> _pages = [
    JadwalPage(),
    PeminjamanPage(),
    PelaporanPage(),
    ProfilePage(),
  ];

  // Fungsi untuk mengganti halaman saat tombol BottomNavigationBar diklik
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[700], // Warna utama
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue[700], // Sesuaikan warna utama di sini
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: Scaffold(
        body: _pages[_selectedIndex], // Menampilkan halaman berdasarkan indeks
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue[700], // Warna bottom navigation biru
          selectedItemColor: Colors.white, // Warna icon dan text yang dipilih
          unselectedItemColor: Colors.blue[300], // Warna icon dan text yang tidak dipilih
          currentIndex: _selectedIndex, // Indeks yang aktif
          onTap: _onItemTapped, // Mengubah indeks saat diklik
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmarks_outlined),
              label: 'Peminjaman',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning_amber_rounded),
              label: 'Pelaporan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
