import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/monthCard.dart';

class KalenderPage extends StatelessWidget {
  const KalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Kalendar Akademik',
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
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kalender Akademik Fakultas Ilmu Komputer 2024/2025',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        MonthCard(
                          month: 'November 2024',
                          imagePath: '/images/Nov24.png',
                          description: '4 November 2024: Rapat Tinjauan Manajemen\n4 -15 November 2024  : Sidang Proposal\n10 November: Hari Pahlawan\n30 November: Dies Natalis 47 UPNVJ',
                        ),
                        MonthCard(
                          month: 'Desember 2024',
                          imagePath: '/images/Des24.png',
                          description: '2 Desember 2024: Rapat Tinjauan Manajemen\n2 - 7 Desember 2024: Minggu Tenang\n19 Desember 2024: Hari Bela Negara\n19 - 21 Des 2024: Ujian Akhir Semester (UAS)\n25 Desember 2024: Hari Raya Natal\n26 Desember 2024: Cuti bersama Hari Raya Natal\n28 Desember 2024: Batas Input Nilai UAS',
                        ),
                        MonthCard(
                          month: 'Januari 2025',
                          imagePath: '/images/Jan25.png',
                          description: '1 Januari 2025: Hari Tahun Baru\n2 - 18 Jan 2025: Pendataan MBKM Semester Ganjil UPNVJ\n2 - 17 Jan 2025: Registrasi Keu (Pembayaran UKT) Semester Genap\n6 Januari 2025: Rapat Tinjauan Manajemen\n18 Januari 2025: Batas Akhir Ujian Tugas Akhir sebelumnya dan masih mengambil MK selain tugas akhir\n20 Januari 2025: Batas Akhir Input Nilai Tugas Akhir/Skripsi, Penetapan Kelulusan (Surat Permohonan Yudisium)\n27 Januari 2025: Maulid Nabi Muhammad\n29 Januari 2025: Tahun Baru Imlek\n31 Januari 2025: Batas Akhir Penerbitan Keputusan Yudisium Semester Ganjil',
                        ),
                        MonthCard(
                          month: 'Februari 2025',
                          imagePath: '/images/Feb25.png',
                          description: '3 Februari 2025: Rapat Tinjauan Manajemen\n20 Jan 2024 - 7 Feb 2025: Pengisian Kartu Rencana Studi (KRS) Online\n7 Februari 2025: Batas Akhir Pendaftaran Wisuda 74 Semester Ganjil 2024/2025\n7 Februari 2025: Batas Akhir Pengajuan Cuti Akademik\n7 Februari 2025: Batas Akhir SK Pemberhentian Mahasiswa Pengunduran Diri\n10 Februari 2025: Awal Perkuliahan Semester Genap\n17 - 21 Februari 2025: Perubahan Kartu Rencana Studi\n28 Februari 2025: Pelaporan KRS (Batas Akhir Pelaporan Aktivitas Kuliah Mahasiswa di PDDIKTI)\n10 Feb - 28 Jun 2025: Masa Perkuliahan',
                        ),
                        MonthCard(
                          month: 'Maret 2025',
                          imagePath: '/images/Mar25.png',
                          description: '3 Maret 2025: Rapat Tinjauan Manajemen\n14 - 19 Maret 2025: Ujian Tengah Semester (UTS)\n19 Maret 2025: Wisuda 74 Semester Ganjil TA. 2024/2025\n29 Maret 2025: Hari Raya Nyepi\n31 Maret 2025: Hari Raya Idul Fitri',
                        ),
                        MonthCard(
                          month: 'April 2025',
                          imagePath: '/images/Apr25.png',
                          description: '1 April 2025: Hari Raya Idul Fitri\n7 April 2025: Rapat Tinjauan Manajemen\n18 April 2025: Wafat Yesus Kristus\n19 April 2025: Wisuda ke-74\n26 April 2025: Batas Akhir Input Nilai UTS',
                        ),
                        MonthCard(
                          month: 'Mei 2025',
                          imagePath: '/images/Mei25.png',
                          description: '1 Mei 2025: Hari Buruh Internasional\n2 Mei 2025: Hari Pendidikan Nasional\n5 Mei 2025: Rapat Tinjauan Manajemen\n12 Mei 2025: Hari Waisak\n29 Mei 2025: Kenaikan Yesus Kristus',
                        ),
                        MonthCard(
                          month: 'Juni 2025',
                          imagePath: '/images/Jun25.png',
                          description: '1 Juni 2025: Hari Lahir Pancasila\n2 Juni 2025: Rapat Tinjauan Manajemen\n7 Juni 2025: Hari Raya Idul Adha\n16 - 28 Juni 2025: Ujian Akhir Semester (UAS)\n26 Juni 2025: Tahun Baru Islam',
                        ),
                        MonthCard(
                          month: 'Juli 2025',
                          imagePath: '/images/Jul25.png',
                          description: '5 Juli 2025: Batas Akhir Input Nilai UAS\n5 Juli 2025: Batas Akhir Ujian Tengah Semester\n7 Juli 2025: Rapat Tinjauan Manajemen\n11 Juli 2025: Batas Akhir Input Nilai Tugas Akhir/Skripsi, Penetapan Kelulusan (Surat Permohonan Keputusan Yudisium)\n7 - 25 Juli 2025: Pendataan MBKM Semester Genap UPNVJ\n31 Juli 2025: Batas Akhir Penerbitan Keputusan Yudisium Semester Ganjil',
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