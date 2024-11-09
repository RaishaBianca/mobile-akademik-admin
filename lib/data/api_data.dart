import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// final String base_url = 'http://192.168.0.174:8000/api/admin/';
final String base_url = 'https://429b-180-252-160-189.ngrok-free.app/api/admin/';
// final String base_url = 'https://7861-125-162-165-72:8000.ngrok-free.app';
late String endpoint;

// Future<int> login(String email, String password) async {
//   // Mock response for login
//   await Future.delayed(Duration(seconds: 1)); // Simulate network delay
//   return 200; // Simulate a successful login response
// }

Future<Map<String, dynamic>> login(String email, String password) async {
  endpoint = 'login';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'email': email,
    'password': password,
  });
  return response.statusCode == 200 ? json.decode(response.body) : throw Exception('Failed to login');
}

Future<List<Map<String, dynamic>>> getAllPeminjaman() async {
  endpoint = 'peminjaman';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiPeminjaman (String id, String status) async {
  endpoint = 'verifikasi_peminjaman';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  });
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllKendala() async {
  endpoint = 'kendala';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiKendala (String id, String status) async {
  endpoint = 'verifikasi_kendala';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  });
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllJadwal() async {
  endpoint = 'jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiJadwal (String id, String status) async {
  endpoint = 'verifikasi_jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  });
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllKode() async {
  endpoint = 'kode';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiKode (String id, String status) async {
  endpoint = 'verifikasi_kode';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  });
  print(response.body);
  return response.statusCode;
}