import 'package:flutter/material.dart';
import 'package:admin_fik_app/pages/authentication/welcome_screen.dart';
import 'package:admin_fik_app/pages/authentication/signin_screen.dart';
import 'package:admin_fik_app/pages/jadwal/jadwal_page.dart';
import 'package:admin_fik_app/pages/peminjaman/peminjaman_page.dart';
import 'package:admin_fik_app/pages/pelaporan/pelaporan_page.dart';
import 'package:admin_fik_app/pages/profile/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
// import 'pusher_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late PusherService pusherService;
  int _selectedIndex = 0; // Menyimpan indeks halaman yang dipilih

  // @override
  // void initState() {
  //   super.initState();
  //   pusherService = PusherService();
  // }
  //
  // @override
  // void dispose() {
  //   pusherService.disconnect();
  //   super.dispose();
  // }

  // Daftar halaman yang ditampilkan berdasarkan indeks
  final List<Widget> _pages = [
    JadwalPage(),
    PeminjamanPage(),
    PelaporanPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    // Exit the app when back button is pressed
    SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin FIK: Lab-Kelas',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFFFF5833), // Primary color
          secondary: Color(0xFFFFBE33), // Secondary color
          tertiary: Color(0xFFFF3374), // Tertiary color
        ),
      ),
      home: const WelcomeScreen(),
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/home': (context) => WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            body: _pages[_selectedIndex], // Menampilkan halaman berdasarkan indeks
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFFF5833), // Color of the top border
                    width: 2.0, // Width of the top border
                  ),
                ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xFFFFFFFF),
                selectedItemColor: Color(0xFFFF5833), // Warna icon dan text yang dipilih
                unselectedItemColor: Color(0x66FF5833), // Warna icon dan text yang tidak dipilih
                currentIndex: _selectedIndex, // Indeks yang aktif
                onTap: _onItemTapped, // Mengubah indeks saat diklik
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today_rounded),
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
          ),
        ),
      },
    );
  }
}