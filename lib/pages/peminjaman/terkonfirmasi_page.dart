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
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _peminjamanFuture = fetchPeminjaman();
  }

  Future<List<Map<String, dynamic>>> fetchPeminjaman() async {
    List<Map<String, dynamic>> peminjaman = [];
    try {
      if(widget.room == 'lab') {
        peminjaman = await api_data.getPeminjamanLab();
      } else if (widget.room == 'kelas') {
        peminjaman = await api_data.getPeminjamanKelas();
      }
      print("peminjaman: ${peminjaman.where((peminjaman) => peminjaman['id_status'] == 5 || peminjaman['id_status'] == 6).toList()}");
      return peminjaman.where((peminjaman) => peminjaman['id_status'] == 5 || peminjaman['id_status'] == 6).toList();
      return peminjaman.map((item) => {
        'id': item['id'] ?? 0, // Provide default value
        'nama_peminjam': item['nama_peminjam'] ?? '',
        'no_tlp': item['no_tlp'] ?? '',
        'grup_pengguna': item['grup_pengguna'] ?? '',
        'tanggal': item['tanggal'] ?? '',
        'nim': item['nim'] ?? '',
        'keterangan': item['keterangan'] ?? '',
        'alasan_penolakan': item['alasan_penolakan'] ?? '',
        'catatan_kejadian': item['catatan_kejadian'] ?? '',
        'jam_mulai': item['jam_mulai'] ?? '',
        'jam_selesai': item['jam_selesai'] ?? '',
        'ruangan': item['ruangan'] ?? '',
        'jumlah_orang': item['jumlah_orang'] ?? 0,
        'status': item['status'] ?? '',
      }).toList();
    } catch (e) {
      print('Error in fetchPeminjaman: $e');
      return [];
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Daftar Diterima/Ditolak',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari nama peminjam atau ruangan...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0x99FF5833)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0x99FF5833)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFFF5833)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          // List View
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
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

                  // Filter the list based on search query
                  var filteredList = peminjamanList.where((peminjaman) {
                    final namaPeminjam = peminjaman['nama_peminjam'].toString().toLowerCase();
                    final ruangan = peminjaman['ruangan'].toString().toLowerCase();
                    return namaPeminjam.contains(searchQuery) ||
                        ruangan.contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      var peminjaman = filteredList[index];
                      return CardConfirmed(
                        id: peminjaman['id'] as int,
                        studentName: peminjaman['nama_peminjam'] ?? '',
                        no_tlp: peminjaman['no_tlp'] ?? '',
                        grup_pengguna: peminjaman['grup_pengguna'] ?? '',
                        inputDate: peminjaman['tanggal'] ?? '',
                        bookDate: peminjaman['tanggal'] ?? '',
                        studentNim: peminjaman['nim'] ?? '',
                        keterangan: peminjaman['keterangan'] ?? '',
                        alasanPenolakan: peminjaman['alasan_penolakan'] ?? '',
                        catatan_kejadian: peminjaman['catatan_kejadian'] ?? '',
                        time: "${peminjaman['jam_mulai'] ?? ''} - ${peminjaman['jam_selesai'] ?? ''} WIB",
                        jamMulai: peminjaman['jam_mulai'] ?? '',
                        jamSelesai: peminjaman['jam_selesai'] ?? '',
                        ruangan: peminjaman['ruangan'] ?? '',
                        groupSize: peminjaman['jumlah_orang'] as int? ?? 0,
                        status: peminjaman['status'] ?? '',
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}