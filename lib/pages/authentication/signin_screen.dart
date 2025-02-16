import 'package:admin_fik_app/pages/authentication/signup_screen.dart';
import 'package:admin_fik_app/customstyle/custom_scaffold.dart';
import 'package:admin_fik_app/customstyle/theme.dart';
import 'package:flutter/material.dart';
import 'package:admin_fik_app/data/api_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:admin_fik_app/pages/password/forget_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  TextEditingController _identifierController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('remember_me') ?? false) {
      _identifierController.text = prefs.getString('identifier') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      rememberPassword = true;
    }
  }

  Future<void> _handleLogin() async {
    if (_formSignInKey.currentState!.validate()) {
      try {
        final response = await login(_identifierController.text, _passwordController.text);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', response['token']);
        if (rememberPassword) {
          prefs.setBool('remember_me', true);
          prefs.setString('identifier', _identifierController.text);
          prefs.setString('password', _passwordController.text);
        } else {
          prefs.remove('remember_me');
          prefs.remove('identifier');
          prefs.remove('password');
        }
        String? fcmToken = prefs.getString('fcm_token');
        print('FCM Token: $fcmToken');
        if (fcmToken != null) {
          print('FCM Token: $fcmToken');
          await saveTokenToServer(fcmToken);
        }
        Navigator.pushReplacementNamed(context, '/home');
      } catch (error) {
      }
    }
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat Datang Kembali',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _identifierController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong Masukkan Email/NIM Anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email', style: TextStyle(fontSize: 14)),
                          hintText: 'Tolong Masukkan Email Anda',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan kata sandi';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Kata Sandi', style: TextStyle(fontSize: 14)),
                          hintText: 'Masukkan kata sandi Anda',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value!;
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                              const Text(
                                'Ingat aku',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                lightColorScheme.primary),
                          ),
                          onPressed: _handleLogin,
                          child: const Text('Masuk', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: Divider(
                      //         thickness: 0.7,
                      //         color: Colors.grey.withOpacity(0.5),
                      //       ),
                      //     ),
                      //     const Padding(
                      //       padding: EdgeInsets.symmetric(
                      //           vertical: 0, horizontal: 10),
                      //       child: Text(
                      //         'Belum punya akun?',
                      //         style: TextStyle(
                      //           color: Colors.black45,
                      //         ),
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (e) => const SignUpScreen()),
                      //         );
                      //       },
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(right: 10.0), // Add padding to the right
                      //         child: Text(
                      //           'Daftar',
                      //           style: TextStyle(
                      //             color: lightColorScheme.primary,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Divider(
                      //         thickness: 0.7,
                      //         color: Colors.grey.withOpacity(0.5),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Color(0xFFFF5833)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }