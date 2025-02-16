import 'package:admin_fik_app/pages/peminjaman/menunggu_page.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/buttonaccept.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;
import 'package:url_launcher/url_launcher.dart';
import '';

const List<String> list = <String>['waiting', 'rejected', 'accepted', 'ongoing', 'completed'];
const List<String> roomTypes = <String>['lab', 'kelas'];

class DetailpeminjamanPage extends StatefulWidget {
  final int id;
  final String studentName;
  final String no_tlp;
  final String studentNim;
  final String grup_pengguna;
  final String inputDate;
  final String ruangan;
  final String bookDate;
  final String jamMulai;
  final String jamSelesai;
  final int jumlahPengguna;
  final String keterangan;
  final String alasanPenolakan;
  final String catatan_kejadian;
  final String time;
  final String status;

  const DetailpeminjamanPage({
    Key? key,
    required this.id,
    required this.studentName,
    required this.no_tlp,
    required this.studentNim,
    required this.grup_pengguna,
    required this.inputDate,
    required this.ruangan,
    required this.bookDate,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPengguna,
    required this.keterangan,
    required this.alasanPenolakan,
    required this.catatan_kejadian,
    // required this.isAccepted, required String time,
    required this.time,
    required this.status,
  }) : super(key: key);

  @override
  _DetailpeminjamanPageState createState() => _DetailpeminjamanPageState();
}

class _DetailpeminjamanPageState extends State<DetailpeminjamanPage> {
  String? statusDropdown;
  List<Map<String, dynamic>> statusList = [];
  bool isLoadingStatus = true;
  
  // Add controllers
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController catatanKejadianController = TextEditingController();
  final TextEditingController jamMulaiController = TextEditingController();
  final TextEditingController jamSelesaiController = TextEditingController();

  Widget _buildAdditionalFields() {
    // Get current status ID from statusDropdown or initial widget status
    final currentStatusId = int.tryParse(statusDropdown ?? '') ?? 
                          int.tryParse(widget.status) ?? 0;
    
    if (currentStatusId == 4 || currentStatusId == 5) { // waiting or rejected
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          buildLabel('Alasan Ditolak:'),
          buildTextField(reasonController, 'Masukkan alasan ditolak'),
        ],
      );
    } else if (currentStatusId == 7 || currentStatusId == 8) { // ongoing or completed
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          buildLabel('Catatan Kejadian:'),
          buildTextField(catatanKejadianController, 'Masukkan catatan kejadian'),
        ],
      );
    }
    
    return SizedBox(); // Return empty widget for accepted status (6)
  }

  @override
  void initState() {
    super.initState();
    statusDropdown = widget.status;
    reasonController.text = widget.alasanPenolakan;
    catatanKejadianController.text = widget.catatan_kejadian;
    jamMulaiController.text = widget.jamMulai;
    jamSelesaiController.text = widget.jamSelesai;
    _fetchStatus();
  }

  @override 
  void dispose() {
    reasonController.dispose();
    catatanKejadianController.dispose();
    jamMulaiController.dispose();
    jamSelesaiController.dispose();
    super.dispose();
  }

  Future<void> _fetchStatus() async {
    setState(() {
      isLoadingStatus = true;
    });

    try {
      var data = await api_data.getStatus();
      setState(() {
        // Filter only peminjaman status
        statusList = data.where((status) => 
          status['fungsi'] == 'peminjaman').toList();
        
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

  Future<void> _handlePost() async {
    try {
      if (!_validateForm()) {
      return;
    }
      print('Sending data:');
      print('ID: ${widget.id}');
      print('Status: ${statusDropdown}');
      print('Reason: ${reasonController.text}');
      print('Notes: ${catatanKejadianController.text}');
      print('Start Time: ${jamMulaiController.text}');
      print('End Time: ${jamSelesaiController.text}');
      print('Room: ${widget.ruangan}');

      final statusCode = await api_data.verifikasiPeminjaman(
      widget.id.toString(),
      statusDropdown!,
      reasonController.text,
      catatanKejadianController.text,
      jamMulaiController.text,
      jamSelesaiController.text,
      widget.ruangan
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

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
          "Detail Peminjaman",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              buildRowWithDivider('ID', widget.id.toString()),
              buildRowWithDivider('Nama', widget.studentName), 
              buildPhoneRow('No. Telp', widget.no_tlp),
              buildRowWithDivider('NIM', widget.studentNim),
              buildRowWithDivider('Grup Pengguna', widget.grup_pengguna),
              buildRowWithDivider('Tgl Input', widget.inputDate),
              buildRowWithDivider('Tgl Peminjaman', widget.bookDate),
              buildRowWithDivider('Ruangan', widget.ruangan),
              buildEditableRow('Jam Mulai', jamMulaiController),
              buildEditableRow('Jam Selesai', jamSelesaiController),
              buildRowWithDivider('Jml Pengguna', widget.jumlahPengguna.toString()),
              buildRowWithDivider('Keterangan', widget.keterangan),
              // SizedBox(height: 16),
              // buildLabel('Alasan Ditolak:'),
              // buildTextField(reasonController, 'Masukkan alasan ditolak'),
              
              // SizedBox(height: 16),
              // buildLabel('Catatan Kejadian:'), 
              // buildTextField(catatanKejadianController, 'Masukkan catatan kejadian'),
               _buildAdditionalFields(),
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
                       if (_validateForm()) {
                        _handlePost();
                       }
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

  Widget buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0x99FF5833)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0x99FF5833)),
        ),
        hintText: hint,
      ),
      maxLines: 3,
    );
  }

  Widget buildPhoneRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 160,
              child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: InkWell(
                onTap: () => _launchURL('https://wa.me/$value'),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
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

  Widget buildEditableRow(String label, TextEditingController controller, {bool isPhoneNumber = false}) {
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
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x99FF5833)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x99FF5833)),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(color: Color(0x99FF5833)),
      ],
    );
  }

  Widget buildDropdownRow(String label, List<String> items, String? selectedItem, ValueChanged<String?> onChanged, bool isLoading) {
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
              child: DropdownButton<String>(
                value: selectedItem,
                hint: Text("Pilih", style: TextStyle(color: Colors.black)),
                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: isLoading ? null : onChanged,
                dropdownColor: Color(0xFFFFBE33),
                underline: SizedBox(),
              ),
            ),
          ],
        ),
        Divider(color: Color(0x99FF5833)),
      ],
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
                ),
              ),
            ),
          ],
        ),
        Divider(color: Color(0x99FF5833)),
      ],
    );
  }

//             Expanded(
//               child: isPhoneNumber
//                   ? InkWell(
//                 onTap: () => _launchURL('https://wa.me/$value'),
//                 child: Text(
//                   value,
//                   style: const TextStyle(
//                     color: Colors.blue,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               )
//                   : Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Divider(color: Color(0x99FF5833)),
//       ],
//     );
//   }
// }