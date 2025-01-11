import 'package:admin_fik_app/pages/pelaporan/pelaporan_page.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/buttonaccept.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

const List<String> list = <String>['waiting','onprogress', 'resolved'];

class DetailkendalaPage extends StatefulWidget {
  final int id;
  final String nama_pelapor;
  final String nim_nrp;
  final String tanggal;
  final String nama_ruangan;
  final String jenis_kendala;
  final String bentuk_kendala;
  final String deskripsi_kendala;
  final String status;
  final String keterangan_penyelesaian;

  DetailkendalaPage({
    Key? key,
    required this.id,
    required this.nama_pelapor,
    required this.nim_nrp,
    required this.tanggal,
    required this.nama_ruangan,
    required this.jenis_kendala,
    required this.bentuk_kendala,
    required this.deskripsi_kendala,
    required this.status,
    required this.keterangan_penyelesaian,
  }) : super(key: key);

  @override
  _DetailkendalaPageState createState() => _DetailkendalaPageState();
}

// const List<String> list = <String>['Terima', 'Selesai'];
class _DetailkendalaPageState extends State<DetailkendalaPage> {
  String? statusDropdown;
  List<Map<String, dynamic>> statusList = [];
  bool isLoadingStatus = true;
  String _lastSavedStatus = '';
  String _deskripsi_kendala = '';
  final TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _kendalaFuture = fetchKendala();
    // reasonController = TextEditingController(text: widget.keterangan_penyelesaian);
    _deskripsi_kendala = widget.deskripsi_kendala;
    statusDropdown = widget.status;
    reasonController.text = widget.keterangan_penyelesaian;
    _fetchStatus();
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  Future<void> _fetchStatus() async {
    setState(() {
      isLoadingStatus = true;
    });

    try {
      var data = await api_data.getStatus();
      setState(() {
        // Filter only kendala status
        statusList = data.where((status) =>
        status['fungsi'] == 'kendala').toList();

        if (widget.status != null) {
          var matchingStatus = statusList.firstWhere(
                  (s) => s['status'].toString().toLowerCase() == widget.status.toLowerCase(),
              orElse: () => {'id_status': null}
          );
          statusDropdown = matchingStatus['id_status']?.toString();
        }

        isLoadingStatus = false;
      });
    } catch (e) {
      print('Error fetching status: $e');
      setState(() {
        isLoadingStatus = false;
      });
    }
  }

  // Future<void> _handlePost() async {
  //   api_data.verifikasiKendala(
  //     widget.id.toString(),
  //     statusDropdown,
  //     reasonController.text,
  //   );
  //
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //     content: Text('Berhasil menyimpan'),
  //     duration: Duration(seconds: 2),
  //     ),
  //   );
  //   //close widget
  //   Navigator.of(context).pop();
  //   Navigator.of(context).pop();
  // }

  Future<void> _handlePost() async {
    try {
      if (!_validateForm()) {
        return;
      }
      print('Sending data:');
      print('ID: ${widget.id}');
      print('Status: ${statusDropdown}');
      print('Reason: ${reasonController.text}');

      final statusCode = await api_data.verifikasiKendala(
          widget.id.toString(),
          statusDropdown!,
          reasonController.text,
      );

      if (statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil menyimpan'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menyimpan'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error in _handlePost: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<List<Map<String, dynamic>>> fetchKendala() async {
    List<Map<String, dynamic>> allKendala = await api_data.getAllKendala();
    return allKendala.toList();
  }

  void _handleSave(String status) {
    setState(() {
      _lastSavedStatus = status;
      _deskripsi_kendala = reasonController.text;
    });
  }

  bool _validateForm() {
    if (statusDropdown == null || statusDropdown!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silahkan pilih status'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Laporan Kendala",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: SingleChildScrollView(
        child: 
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRowWithDivider('ID', widget.id.toString()),
                buildRowWithDivider('Nama', widget.nama_pelapor),
                buildRowWithDivider('NIM', widget.nim_nrp),
                buildRowWithDivider('Tgl Input', widget.tanggal),
                buildRowWithDivider('Ruangan', widget.nama_ruangan),
                buildRowWithDivider('Jenis Kendala', widget.jenis_kendala),
                buildRowWithDivider('Bentuk Kendala', widget.bentuk_kendala),
                buildRowWithDivider('Deskripsi', _deskripsi_kendala),
                SizedBox(height: 16),
                Text(
                  'Keterangan Pengerjaan:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x99FF5833)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x99FF5833)),
                    ),
                    hintText: 'Masukkan keterangan penanganan kendala',
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                // Status dropdown from API
                DropdownButtonFormField<String>(
                  value: statusDropdown,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x99FF5833)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x99FF5833)),
                    ),
                  ),
                  hint: Text("Pilih Status"),
                  onChanged: isLoadingStatus ? null : (String? newValue) {
                    setState(() {
                      statusDropdown = newValue;
                    });
                  },
                  items: statusList.map<DropdownMenuItem<String>>((Map<String, dynamic> status) {
                    // String statusValue = status['status'].toString().toLowerCase();
                    return DropdownMenuItem<String>(
                      value: status['id_status'].toString(),
                      child: Text(status['status']),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonAccept(
                      label: 'Simpan',
                      onPressed: () {
                        _handlePost();
                        // print("Diterima");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }

  // Helper widgets
  Widget buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    );
  }

  Widget buildRowWithDivider(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 160,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        Divider(color: Color(0x99FF5833)),
      ],
    );
  }
}