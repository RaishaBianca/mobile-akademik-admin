import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http_parser/http_parser.dart';

// const String base_url = 'http://103.147.92.179:25500/api/';
const String base_url = 'https://layananlab.fik.upnvj.ac.id/api/';
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

Future<Map<String, String>> updatePassword(String newPassword) async {
  endpoint = 'user/update/password';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.post(url, body: {
    'password': newPassword,
  }, headers: await _getHeaders());
  if (response.statusCode == 200) {
    return {
      'message': 'Password updated successfully'
    };
  } else {
    throw Exception('Failed to update password');
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
  print(response.body);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> verifikasiPeminjaman(String id, String id_status, String alasanPenolakan, String catatanKejadian, String jamMulai, String jamSelesai, String idRuang) async {
  endpoint = 'peminjaman/verifikasi';
  var url = Uri.parse(base_url + endpoint);
  print(id);
  print(id_status);
  print(alasanPenolakan);
  print(catatanKejadian);
  print(jamMulai);
  print(jamSelesai);
  print(idRuang);

  try {
    final headers = await _getHeaders();
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    
    var response = await http.post(
      url,
      headers: headers,
      body: {
        'id': id,
        'id_status': id_status,
        'alasan_penolakan': alasanPenolakan,
        'catatan_kejadian': catatanKejadian,
        'jam_mulai': jamMulai,
        'jam_selesai': jamSelesai,
        // 'id_ruang': idRuang,
        'ruangan' : idRuang,
      }
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      var errorBody = json.decode(response.body);
      throw Exception('Failed to verify peminjaman: ${response.statusCode}');
    }
  } catch (e) {
    print('Error in verifikasiPeminjaman: $e');
    throw e;
  }
}


Future<List<Map<String, dynamic>>> getAllRuangantersedia(String jamMulai, String jamSelesai, String tglPinjam, String tipeRuang) async {
  endpoint = 'ruangan/status';
  var url = Uri.parse(base_url + endpoint);
  print('data $jamMulai $jamSelesai $tglPinjam $tipeRuang');
  
  var response = await http.post(url, 
    body: {
      'jam_mulai': jamMulai,
      'jam_selesai': jamSelesai,
      'tgl_pinjam': tglPinjam,
      'tipe_ruang': tipeRuang
    }, 
    headers: await _getHeaders()
  );
  print(response.body);

  if (response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
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

Future<List<Map<String, dynamic>>> getStatus({bool isActive = true}) async {
  endpoint = 'status';
  var url = Uri.parse(base_url + endpoint);
  var response = await http.get(url, headers: await _getHeaders());
  print("fetch status");
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to get status data');
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

Future<int> verifikasiKendala(String id, String id_status, String keterangan) async {
  endpoint = 'kendala/verifikasi';
  var url = Uri.parse(base_url + endpoint);
  print(id);
  print(id_status);
  print(keterangan);
  // var response = await http.post(url, body: {
  //   'id': id,
  //   'id_status': id_status,
  //   'keterangan_penyelesaian': keterangan,
  // }, headers: await _getHeaders());
  // print(response.body);
  // return response.statusCode;
  try {
    final headers = await _getHeaders();
    headers['Content-Type'] = 'application/x-www-form-urlencoded';

    var response = await http.post(
        url,
        headers: headers,
        body: {
          'id': id,
          'id_status': id_status,
          'keterangan_penyelesaian': keterangan,
        }
        );
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          return response.statusCode;
        } else {
        var errorBody = json.decode(response.body);
        throw Exception('Failed to verify kendala: ${response.statusCode}');
        }
      } catch (e) {
      print('Error in verifikasiKendala: $e');
      throw e;
      }
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

  if (response.statusCode == 200) {
    print('FCM token saved successfully');
  } else if (response.statusCode == 302 || response.statusCode == 301) {
    // Handle redirect
    final redirectUrl = response.headers['location'];
    if (redirectUrl != null) {
      final redirectResponse = await http.post(
        Uri.parse(redirectUrl),
        headers: await _getHeaders(),
        body: jsonEncode({'fcm_token': token}),
      );

      if (redirectResponse.statusCode == 200) {
        print('FCM token saved successfully after redirect');
      } else {
        print('Failed to save FCM token after redirect');
      }
    } else {
      print('Redirect URL is null');
    }
  } else {
    print('Failed to save FCM token');
  }
}

Future<int> bukaPemakaianJadwal({
  required String idJadwal, 
  required String tglAwal, 
  String? tglUndur, 
  String? jamMulai, 
  String? jamSelesai, 
  String? alasan, 
  required String idRuang,
}) async {
  endpoint = 'buka-pemakaian/jadwal';
  var url = Uri.parse(base_url + endpoint);
  print('Data: $idJadwal $tglAwal $tglUndur $jamMulai $jamSelesai $alasan $idRuang');
  print('url $url');
  try {
    var response = await http.post(
      url, 
      body: {
        'id_jadwal': idJadwal,
        'tgl_awal': tglAwal,
        'tgl_undur': tglUndur ?? '',
        'jam_mulai': jamMulai ?? '',
        'jam_selesai': jamSelesai ?? '',
        'alasan': alasan ?? '',
        'id_ruang': idRuang,
      },
      headers: await _getHeaders()
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Failed to close room usage: ${response.statusCode}');
    }
  } catch (e) {
    print('Error in tutupPemakaianJadwal: $e');
    throw e;
  }
}

Future<int> bukaPemakaianPinjam({required String idPinjam, String? alasan}) async {
  endpoint = 'buka-pemakaian/pinjam';
  var url = Uri.parse(base_url + endpoint);
  print('Data: $idPinjam $alasan');
  try {
    var response = await http.post(
      url, 
      body: {
        'id_pinjam': idPinjam,
        'alasan': alasan ?? '',
      },
      headers: await _getHeaders()
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Failed to close room usage: ${response.statusCode}');
    }
  } catch (e) {
    print('Error in tutupPemakaianPinjam: $e');
    throw e;
  }
}

Future<int> tutupPemakaianRuang({required String idRuang, String? keterangan, required String tglPinjam, String? jamMulai, String? jamSelesai  }) async {
  endpoint = 'tutup-ruangan';
  var url = Uri.parse(base_url + endpoint);
  print("data: $idRuang $keterangan $tglPinjam $jamMulai $jamSelesai");
  try {
    var response = await http.post(
        url,
        body: {
          'id_ruang': idRuang,
          'keterangan': keterangan ?? '',
          'tgl_pinjam': tglPinjam,
          'jam_mulai': jamMulai ?? '',
          'jam_selesai': jamSelesai ?? '',
        },
        headers: await _getHeaders()
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Failed to close room usage: ${response.statusCode}');
    }
  } catch (e) {
    print('Error in tutupRuangan: $e');
    throw e;
  }
}

Future<void> requestPasswordReset(String email) async {
  try {
    final endpoint = 'password/forgot';
    final url = Uri.parse(base_url + endpoint);
    final response = await http.post(
      url,
      body: {'email': email},
      headers: await _getHeaders(),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode != 200) {
      if (responseData['error'] != null) {
        throw responseData['error'];
      } else {
        throw responseData['message'] ?? 'Failed to request password reset';
      }
    }
  } catch (e) {
    throw e.toString();
  }
}

Future<void> verifyResetToken(String email, String token) async {
  try {
    final endpoint = 'password/verify-token';
    final url = Uri.parse(base_url + endpoint);
    print(email);
    print(token);
    final response = await http.post(
      url,
      body: {
        'email': email,
        'token': token,
      },
      headers: await _getHeaders(),
    );
    print(response.body);

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Invalid token');
    }
  } catch (e) {
    throw Exception('Token verification failed: ${e.toString()}');
  }
}

Future<void> resetPassword({
  required String email,
  required String token,
  required String password,
  required String passwordConfirmation,
}) async {
  try {
    final endpoint = 'password/reset';
    final url = Uri.parse(base_url + endpoint);
    final response = await http.post(
      url,
      body: {
        'email': email,
        'token': token,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
      headers: await _getHeaders(),
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to reset password');
    }
  } catch (e) {
    throw Exception('Password reset failed: ${e.toString()}');
  }
}


Future<String> getCalendarPDF(String type) async {
  try {
    endpoint = 'calendar/$type';
    final url = Uri.parse(base_url + endpoint);
    final response = await http.get(
      url,
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('url : ${responseData['url']}');
      return responseData['url'];
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load calendar');
    }
  } catch (e) {
    throw Exception('Error loading calendar: ${e.toString()}');
  }
}
