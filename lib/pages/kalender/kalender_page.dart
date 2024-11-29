import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class KalenderPage extends StatefulWidget {
  @override
  _KalenderPageState createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String? localPath;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPdf('Universitas');
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        _loadPdf(_tabController!.index == 0 ? 'Universitas' : 'Fakultas');
      }
    });
  }

  Future<void> _loadPdf(String category) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/academic_calendar.pdf');

    // Load the appropriate PDF based on the selected category
    final pdfAsset = category == 'Universitas'
        ? 'assets/assets/KALENDER-AKADEMIK-2024-2025.pdf'
        : 'assets/assets/KALENDER-AKADEMIK-FIK-2024-2025.pdf';

    final data = await DefaultAssetBundle.of(context).load(pdfAsset);
    await file.writeAsBytes(data.buffer.asUint8List());

    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Kalender Akademik',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Color(0xFFFF5833),
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Universitas'),
                Tab(text: 'Fakultas'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  localPath != null
                      ? PDFView(filePath: localPath!)
                      : Center(child: CircularProgressIndicator()),
                  localPath != null
                      ? PDFView(filePath: localPath!)
                      : Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}