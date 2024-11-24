import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/cardConfirmed.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class TerkonfirmasiPage extends StatefulWidget {
  final String room;

  TerkonfirmasiPage({required this.room});

  @override
  _TerkonfirmasiPageState createState() => _TerkonfirmasiPageState();
}

class _TerkonfirmasiPageState extends State<TerkonfirmasiPage> {
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
    return peminjaman.where((peminjaman) => peminjaman['status'] == 'disetujui' || peminjaman['status'] == 'ditolak').toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Daftar Sudah Dikonfirmasi',
          style: TextStyle(
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
                  ruangan: peminjaman['ruangan'],
                  groupSize: "${peminjaman['jumlah_orang']} Orang",
                  isAccepted: peminjaman['status'] == 'disetujui',
                  studentNim: peminjaman['nim'],
                  bookDate: peminjaman['tanggal'],
                  jamMulai: peminjaman['jam_mulai'],
                  jamSelesai: peminjaman['jam_selesai'],
                  keterangan: peminjaman['keterangan'],
                  inputDate: peminjaman['tanggal'],
                  jumlahPengguna: "${peminjaman['jumlah_orang']} Orang",
                );
              },
            );
          }
        },
      ),
    );
  }
}