import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/pages/authentication/welcome_screen.dart';
import 'package:admin_fik_app/pages/authentication/signin_screen.dart';
import 'package:admin_fik_app/pages/jadwal/jadwal_page.dart';
import 'package:admin_fik_app/pages/peminjaman/peminjaman_page.dart';
import 'package:admin_fik_app/pages/pelaporan/pelaporan_page.dart';
import 'package:admin_fik_app/pages/profile/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:admin_fik_app/data/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'admin-fik-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false
  );

  if (Platform.isAndroid) {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Set FCM foreground notification presentation options
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    name: 'admin-fik-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print('Background service initialized');
  print('Handling a background message: ${message.messageId}');
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification?.title}');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    JadwalPage(),
    PeminjamanPage(),
    PelaporanPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    // _initNotifications();
    _setupFCM();
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap here if needed
        setState(() {
          _selectedIndex = 1; // Navigate to Peminjaman page
        });
      },
    );
  }

  void _setupFCM() {
    FirebaseMessaging.instance.getToken().then((token) async {
      print('FCM Token: $token');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', token!);
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      print('FCM Token Refreshed: $token');
    });

    // Let FCM handle the notification display
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      setState(() {
        _selectedIndex = 1; // Navigate to Peminjaman page
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin FIK: Lab-Kelas',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFFFF5833),
          secondary: Color(0xFFFFBE33),
          tertiary: Color(0xFFFF3374),
        ),
      ),
      home: const WelcomeScreen(),
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/home': (context) => WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            body: _pages[_selectedIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFFF5833),
                    width: 2.0,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xFFFFFFFF),
                selectedItemColor: Color(0xFFFF5833),
                unselectedItemColor: Color(0x66FF5833),
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today_rounded),
                    label: 'Jadwal',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmarks_outlined),
                    label: 'Peminjaman',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.warning_amber_rounded),
                    label: 'Pelaporan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_rounded),
                    label: 'Profil',
                  ),
                ],
              ),
            ),
          ),
        ),
      },
    );
  }
}