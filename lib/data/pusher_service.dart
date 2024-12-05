// import 'package:pusher_client/pusher_client.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class PusherService {
//   late PusherClient pusher;
//   late Channel channel;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   PusherService() {
//     // Konfigurasi Pusher
//     pusher = PusherClient(
//       'your-app-key', // Ganti dengan app key dari Pusher
//       PusherOptions(
//         cluster: 'your-app-cluster', // Ganti dengan cluster dari Pusher
//         encrypted: true, // Gunakan koneksi terenkripsi
//       ),
//       enableLogging: true, // Untuk debugging
//     );
//
//     // Subscribe ke channel tertentu
//     channel = pusher.subscribe('private-peminjaman'); // Ganti dengan ID user yang relevan
//
//     // Bind event untuk menerima data broadcast
//     channel.bind('new-peminjaman', (event) {
//       print('New peminjaman received: ${event.data}');
//       // Tambahkan logika untuk menangani notifikasi di sini
//     });
//
//     // Hubungkan ke Pusher
//     pusher.connect();
//
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   void _showNotification(String message) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'New Peminjaman',
//       message,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }
//
//   void disconnect() {
//     pusher.disconnect();
//   }
// }
//
