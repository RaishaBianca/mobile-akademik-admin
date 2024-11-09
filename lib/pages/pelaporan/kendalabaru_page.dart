import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/reportCard.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class KendalabaruPage extends StatefulWidget {
  @override
  _KendalabaruPageState createState() => _KendalabaruPageState();
}

class _KendalabaruPageState extends State<KendalabaruPage> {
  late Future<List<Map<String, dynamic>>> _kendalaFuture;

  @override
  void initState() {
    super.initState();
    _kendalaFuture = fetchKendala();
  }

  Future<List<Map<String, dynamic>>> fetchKendala() async {
    List<Map<String, dynamic>> allKendala = await api_data.getAllKendala();
    return allKendala.where((kendala) => kendala['status'] == 'rejected').toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Daftar Laporan Kendala Selesai',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _kendalaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<Map<String, dynamic>> kendalaList = snapshot.data!;
            return ListView.builder(
              itemCount: kendalaList.length,
              itemBuilder: (context, index) {
                var kendala = kendalaList[index];
                return ReportCard(
                  nama_pelapor: kendala['nama_pelapor'],
                  nama_ruangan: kendala['nama_ruangan'],
                  status: kendala['status'],
                  tanggal: kendala['tanggal'],
                  jenis_kendala: kendala['jenis_kendala'],
                  bentuk_kendala: kendala['bentuk_kendala'],
                );
              },
            );
          }
        },
      ),
    );
  }
}