import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/bookingCard.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class SemuadaftarPage extends StatefulWidget {
  @override
  _SemuadaftarPageState createState() => _SemuadaftarPageState();
}

class _SemuadaftarPageState extends State<SemuadaftarPage> {
  late Future<List<Map<String, dynamic>>> _peminjamanFuture;

  @override
  void initState() {
    super.initState();
    _peminjamanFuture = fetchPeminjaman();
  }

  Future<List<Map<String, dynamic>>> fetchPeminjaman() async {
    return await api_data.getAllPeminjaman();
  }

  Future<int> verifikasiPeminjaman(String id, String status) async {
    int statusCode = await api_data.verifikasiPeminjaman(id, status);
    if (statusCode == 200) {
      print('Peminjaman $id $status');
      setState(() {
        _peminjamanFuture = fetchPeminjaman();
      });
    } else {
      print('Failed to verify peminjaman $id: $statusCode');
    }
    return statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Semua Daftar Peminjaman',
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
                print(peminjaman);
                return BookingCard(
                  studentName: peminjaman['nama_peminjam'],
                  inputDate: peminjaman['tanggal'],
                  studentNim: peminjaman['nim'],
                  keterangan : peminjaman['keterangan'],
                  time: "${peminjaman['jam_mulai']} - ${peminjaman['jam_selesai']} WIB",
                  ruangan: peminjaman['ruangan'],
                  groupSize: "${peminjaman['jumlah_orang']} Orang",
                  status: peminjaman['status'],
                  onAccept: () async {
                    await verifikasiPeminjaman(peminjaman['id'].toString(), 'approved');
                  },
                  onReject: () async {
                    await verifikasiPeminjaman(peminjaman['id'].toString(), 'rejected');
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}