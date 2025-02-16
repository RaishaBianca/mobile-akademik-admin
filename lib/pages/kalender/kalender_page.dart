import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:admin_fik_app/data/api_data.dart' as api_data;
import 'package:http/http.dart' as http;

class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

  @override
  _KalenderPageState createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> with SingleTickerProviderStateMixin {
  late TabController? _tabController;

  // String? localPath;
  String? _akademikPdfUrl;
  String? _fakultasPdfUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPdfs();
    // _loadPdf('Universitas');
    // _tabController!.addListener(() {
    //   if (_tabController!.indexIsChanging) {
    //     _loadPdf(_tabController!.index == 0 ? 'Universitas' : 'Fakultas');
    //   }
    // });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  // Future<void> _loadPdf(String category) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/academic_calendar.pdf');
  //
  //   // Load the appropriate PDF based on the selected category
  //   final pdfAsset = category == 'Universitas'
  //       ? 'assets/files/kalender_universitas.pdf'
  //       : 'assets/files/kalender_fik.pdf';
  //
  //   final data = await DefaultAssetBundle.of(context).load(pdfAsset);
  //   await file.writeAsBytes(data.buffer.asUint8List());
  //
  //   setState(() {
  //     localPath = file.path;
  //   });
  // }

  Future<void> _loadPdfs() async {
    setState(() => _isLoading = true);
    try {
      _akademikPdfUrl = await api_data.getCalendarPDF('akademik');
      _fakultasPdfUrl = await api_data.getCalendarPDF('fakultas');
      print('PDFs loaded');
    } catch (e) {
      print('Error loading PDFs: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildPdfView(String? url) {
    if (url == null) {
      return const Center(
        child: Text('PDF tidak tersedia', style: TextStyle(fontSize: 16)),
      );
    }

    return Stack(
      children: [
        FutureBuilder<http.Response>(
          future: http.get(Uri.parse(url)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF5833),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red)
                ),
              );
            }

            if (snapshot.hasData) {
              return PDFView(
                pdfData: snapshot.data!.bodyBytes,
                onError: (error) {
                  print('PDF Error: $error');
                },
                onPageError: (page, error) {
                  print('Page $page: $error');
                },
              );
            }

            return const Center(
              child: Text('Failed to load PDF'),
            );
          },
        ),
      ],
    );
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
              child: _isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF5833),
                ),
              )
                  : TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildPdfView(_akademikPdfUrl),
                  _buildPdfView(_fakultasPdfUrl),
                ],
              ),
            )
            // Expanded(
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: [
            //       localPath != null
            //           ? PDFView(filePath: localPath!)
            //           : const Center(child: CircularProgressIndicator()),
            //       localPath != null
            //           ? PDFView(filePath: localPath!)
            //           : const Center(child: CircularProgressIndicator()),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}