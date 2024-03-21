import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_care_app/services/auth_services.dart';

import '../pages/home_view.dart';

class AuthNotifier extends StateNotifier<bool> {
  final AuthServices _authServices;
  AuthNotifier(this._authServices) : super(false);

  login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      state = true;
      await _authServices.login(email: email, password: password).then((value) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeView()));
      });
      state = false;
    } catch (e) {
      state = false;
    }
  }
}
