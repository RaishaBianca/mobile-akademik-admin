import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

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
        ? 'assets/files/kalender_universitas.pdf'
        : 'assets/files/kalender_fik.pdf';

    final data = await DefaultAssetBundle.of(context).load(pdfAsset);
    await file.writeAsBytes(data.buffer.asUint8List());

    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Kalender Akademik',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5833),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar.secondary(
              controller: _tabController,
              labelColor: const Color(0xFFFF5833),
              unselectedLabelColor: Colors.black,
              tabs: const <Widget>[
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
                      : const Center(child: CircularProgressIndicator()),
                  localPath != null
                      ? PDFView(filePath: localPath!)
                      : const Center(child: CircularProgressIndicator()),
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