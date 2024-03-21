// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:health_care_app/pages/home_screen.dart';
// import 'package:health_care_app/services/auth_services.dart';


// class AuthNotifier extends StateNotifier<bool> {
//   final AuthServices _authServices;
//   AuthNotifier(this._authServices) : super(false);

//   login(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       state = true;
//       await _authServices.loginUser(email: email, password: password).then((value) {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => const  HomeScreen()));
//       });
//       state = false;
//     } catch (e) {
//       state = false;
//     }
//   }
// }
