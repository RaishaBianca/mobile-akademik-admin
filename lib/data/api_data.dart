import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http_parser/http_parser.dart';

final String base_url = 'https://b9fe-103-147-92-253.ngrok-free.app/api/';
late String endpoint;
late SharedPreferences prefs;

Future<void> initializePreferences() async {
  prefs = await SharedPreferences.getInstance();
}

Future<String?> getAccessToken() async {
  await initializePreferences();
  return prefs.getString('access_token');
}

Future<Map<String, String>> _getHeaders() async {
  final accessToken = await getAccessToken();

  if (base_url.contains('ngrok')) {
    return {
      'Authorization' : 'Bearer $accessToken',
      'ngrok-skip-browser-warning': '69420',
    };
  }
  return {
    'Authorization' : 'Bearer $accessToken',
  };
}

Future<Map<String, dynamic>> login(String identifier, String password) async {
  endpoint = 'login';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'identifier': identifier,
    'password': password,
    'role': 'admin,admin_fakultas,admin_kelas,super_admin',
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<Map<String, dynamic>?> fetchUserData() async {
  endpoint = 'user';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  if (accessToken != null) {
    try {
      final response = await http.get(
        Uri.parse(base_url + endpoint),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return userData;
      } else {
        print('Failed to load user data');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  return null;
}

Future<void> updateProfile(String name, String email, File image) async {
  const String endpoint = 'user/update';
  final String url = base_url + endpoint;
  final headers = await _getHeaders();

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..fields['nama'] = name
      ..fields['email'] = email;

    if (image.path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      ));
    }
    print(name);
    print(email);

    var response = await request.send().timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      print('Profile updated successfully');
    } else {
      print('Failed to update profile: ${response.statusCode}');
      print('Response body: ${await response.stream.bytesToString()}');
      throw Exception('Failed to update profile');
    }
  } catch (e) {
    print('Error updating profile: $e');
    throw Exception('Error updating profile');
  }
}

Future<List<Map<String, dynamic>>> getAllPeminjaman() async {
  endpoint = 'peminjaman';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url,
      headers: await _getHeaders()
  );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getPeminjamanLab() async {
  endpoint = 'peminjaman/lab';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url,
      headers: await _getHeaders()
  );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getPeminjamanKelas() async {
  endpoint = 'peminjaman/kelas';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url,
      headers: await _getHeaders()
  );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Map<String, dynamic>> getPeminjamanCount() async {
  endpoint = 'peminjaman/count';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Map<String, dynamic>> getKendalaCount() async {
  endpoint = 'kendala/count';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiPeminjaman(String id, String status, String alasanPenolakan, String jamMulai, String jamSelesai, String idRuang) async {
  endpoint = 'peminjaman/verifikasi';
  var url = Uri.parse(base_url + endpoint);
  print(id);
  print(status);
  print(alasanPenolakan);
  print(jamMulai);
  print(jamSelesai);
  print(idRuang);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
    'alasan_penolakan': alasanPenolakan,
    'jam_mulai': jamMulai,
    'jam_selesai': jamSelesai,
    'id_ruang': idRuang,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllKendala() async {
  endpoint = 'kendala';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getKendalaLab() async {
  endpoint = 'kendala/lab';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getKendalaKelas() async {
  endpoint = 'kendala/kelas';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiKendala(String id, String status, String keterangan) async {
  endpoint = 'kendala/verifikasi';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
    'keterangan_penyelesaian': keterangan,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllJadwal() async {
  endpoint = 'jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    print(data);
    print(data.length);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiJadwal(String id, String status) async {
  endpoint = 'verifikasi_jadwal';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List<Map<String, dynamic>>> getAllKode() async {
  endpoint = 'kode';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiKode(String id, String status) async {
  endpoint = 'verifikasi_kode';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'id': id,
    'status': status,
  }, headers: await _getHeaders());
  print(response.body);
  return response.statusCode;
}

Future<List> getRuang(String tipe) async {
  endpoint = 'ruangan';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'tipe_ruang': tipe,
  }, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  return responseBody;
}

Future<List> getPeminjamanStatistik(String room) async {
  endpoint = 'peminjaman/statistik?tipe=$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  // print(response.body);
  var responseBody = json.decode(response.body);
  return responseBody['data'];
}

Future<List> getKendalaStatistik(String room) async {
  endpoint = 'kendala/statistik?tipe=$room';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  var responseBody = json.decode(response.body);
  // print(responseBody['data']);
  return responseBody['data'];
}

Future<void> saveTokenToServer(String? token) async {
  if (token == null) return;
  endpoint = 'save-fcm-token';
  var url = Uri.parse(base_url + endpoint);

  print('Saving FCM token to server');
  print('FCM Token: $token');

  final response = await http.post(url, body: {
  'fcm_token' : token,
  }, headers: await _getHeaders());
}