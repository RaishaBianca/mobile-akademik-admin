import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/cardConfirmed.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class MenungguPage extends StatefulWidget {
  final String room;

  MenungguPage({required this.room});

  @override
  _MenungguPageState createState() => _MenungguPageState();
}

class _MenungguPageState extends State<MenungguPage> {
  late Future<List<Map<String, dynamic>>> _peminjamanFuture;

  @override
  void initState() {
    super.initState();
    _peminjamanFuture = fetchPeminjaman();
  }

  Future<List<Map<String, dynamic>>> fetchPeminjaman() async {
    List<Map<String, dynamic>> peminjaman;
    if(widget.room == 'lab') {
      peminjaman = await api_data.getPeminjamanLab();
    }else{
      peminjaman = await api_data.getPeminjamanKelas();
    }
    print("peminjaman: ${peminjaman.where((peminjaman) => peminjaman['id_status'] == 4).toList()}");
    return peminjaman.where((peminjaman) => peminjaman['id_status'] == 4).toList();
  }

  // Future<int> verifikasiPeminjaman(String id, String id_status, String status, String alasanPenolakan, String catatan_kejadian, String jamMulai, String jamSelesai, String idRuang) async {
  //   int statusCode = await api_data.verifikasiPeminjaman(id, id_status, alasanPenolakan, catatan_kejadian, jamMulai, jamSelesai, idRuang);
  //   if (statusCode == 200) {
  //     print('Peminjaman $id $id_status');
  //     setState(() {
  //       _peminjamanFuture = fetchPeminjaman();
  //     });
  //   } else {
  //     print('Failed to verify peminjaman $id: $statusCode');
  //   }
  //   return statusCode;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Daftar Dalam Antrian',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _peminjamanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<Map<String, dynamic>> peminjamanList = snapshot.data!;
            return ListView.builder(
              itemCount: peminjamanList.length,
              itemBuilder: (context, index) {
                var peminjaman = peminjamanList[index];
                return CardConfirmed(
                  id: peminjaman['id'],
                  studentName: peminjaman['nama_peminjam'],
                  no_tlp: peminjaman['no_tlp'],
                  grup_pengguna: peminjaman['grup_pengguna'],
                  inputDate: peminjaman['tanggal'],
                  bookDate: peminjaman['tanggal'],
                  studentNim: peminjaman['nim'],
                  keterangan: peminjaman['keterangan'] ?? '',
                  alasanPenolakan: peminjaman['alasan_penolakan'] ?? '',
                  catatan_kejadian: peminjaman['catatan_kejadian'] ?? '',
                  time: "${peminjaman['jam_mulai']} - ${peminjaman['jam_selesai']} WIB",
                  jamMulai: peminjaman['jam_mulai'],
                  jamSelesai: peminjaman['jam_selesai'],
                  ruangan: peminjaman['ruangan'],
                  groupSize: peminjaman['jumlah_orang'],
                  status: peminjaman['status'],
                  // onAccept: () async {
                  //   await verifikasiPeminjaman(peminjaman['id'].toString(), '2', 'disetujui', '', '', peminjaman['jam_mulai'] ?? '', peminjaman['jam_selesai'] ?? '', peminjaman['id_ruang'] ?? '');
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text('Berhasil menyimpan'),
                  //       duration: Duration(seconds: 2),
                  //     ),
                  //   );
                  // },
                  // onReject: () async {
                  //   await verifikasiPeminjaman(peminjaman['id'].toString(),
                  //       '3', 'rejected', peminjaman['alasan_penolakan'] ?? '', peminjaman['catatan_kejadian'] ?? '', peminjaman['jam_mulai'] ?? '', peminjaman['jam_selesai'] ?? '', peminjaman['id_ruang'] ?? ''
                  //   );
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text('Berhasil menyimpan'),
                  //       duration: Duration(seconds: 2),
                  //     ),
                  //   );
                  // },
                );
              },
            );
          }
        },
      ),
    );
  }
}