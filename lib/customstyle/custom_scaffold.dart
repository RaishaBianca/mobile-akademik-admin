// import 'package:flutter/material.dart';
//
// class CustomScaffold extends StatelessWidget {
//   const CustomScaffold({super.key, this.child});
// final Widget? child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Image.asset("assets/images/bg1.png",
//             fit: BoxFit.cover,
//             height: double.infinity,
//             width: double.infinity,
//             alignment: Alignment.center,
//           ),
//           SafeArea(
//             child: child!,
//             // child: Center(
//             //   child: Text(
//             //     "Welcome to ClassLeap",
//             //     style: TextStyle(
//             //       fontSize: 24,
//             //       fontWeight: FontWeight.bold,
//             //       color: Colors.white,
//             //     ),
//             //   ),
//             // ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg1.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Column(
            children: [
              AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: SafeArea(
                  child: child!,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}