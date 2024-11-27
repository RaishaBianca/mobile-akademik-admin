import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/monthCard.dart';
import 'package:admin_fik_app/data/api_data.dart' as api_data;

class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

  @override
  _KalenderPageState createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<Map<String, List<Map<String, dynamic>>>> _kalenderFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _kalenderFuture = fetchKalender();
  }

  Future<Map<String, List<Map<String, dynamic>>>> fetchKalender() async {
    return await api_data.getKalender();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Kalendar Akademik',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5833),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar.secondary(
              controller: _tabController,
              indicatorWeight: 2.0,
              labelColor: Color(0xFFFF5833),
              unselectedLabelColor: Colors.black,
              tabs: const <Widget>[
                Tab(text: 'Kalender FIK'),
                Tab(text: 'Kalender Universitas'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _buildKalenderFIK(),
                  _buildKalenderUniversitas(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKalenderFIK() {
    return FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
      future: _kalenderFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          Map<String, List<Map<String, dynamic>>> kalenderMap = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: kalenderMap.entries.map((entry) {
                String monthYear = entry.key;
                List<Map<String, dynamic>> events = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      monthYear,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFFF5833),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.network('https://radarlambar.bacakoran.co/upload/e6951955785e896859feadacd94e8715.jpg'),
                    SizedBox(height: 20),
                    ...events.map((event) {
                      return MonthCard(
                        kegiatan: event['kegiatan'],
                        tgl_mulai: event['tgl_mulai'],
                        tgl_selesai: event['tgl_selesai'],
                      );
                    }).toList(),
                    SizedBox(height: 36),
                  ],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget _buildKalenderUniversitas() {
    return SafeArea(
      child: Center(
        child: Text(
          'Kalender Universitas content goes here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}