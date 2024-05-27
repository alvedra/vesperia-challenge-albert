import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final GlobalKey<FormState> formFieldKey = GlobalKey();

  final etPhone = TextEditingController();
  final etPassword = TextEditingController();

  final _obscurePassword = true.obs;
  bool get obscurePassword => _obscurePassword.value;

  final _isSigningIn = false.obs;
  bool get isSigningIn => _isSigningIn.value;

  final _countryCode = '+62'.obs;
  String get countryCode => _countryCode.value;

  List<TextInputFormatter>? numberInputFormatters = [
    FilteringTextInputFormatter.allow(
      // only allow numbers (0 – 9) and deny 0 as prefix
      RegExp(r'^(0|[1-9][0-9]*)$'),
    ),
  ];

  void doLogin() async {
    _isSigningIn.value = true;
    if (!formFieldKey.currentState!.validate()) {
      _isSigningIn.value = false;
      return;
    }

    // if (etPhone.text != '85173254399' || etPassword.text != '12345678') {
    //   SnackbarWidget.showFailedSnackbar('Email atau password salah');
    //   _isSigningIn.value = false;
    //   return;
    // }

    try {
      await _userRepository.login(
          etPhone.text, etPassword.text, _countryCode.value);
      Get.offAllNamed(RouteName.dashboard);
    } on DioException catch (e) {
      if (e.response != null) {
        String? error = e.response?.data['message'];
        SnackbarWidget.showFailedSnackbar('Failed to Sign in: $error');
      } else {
        SnackbarWidget.showFailedSnackbar('Something is wrong.');
      }
      _isSigningIn.value = false;
    }
  }

  void togglePassword() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  String? phoneNumberValidator(value) {
    if (value == null || value.isEmpty) {
      return 'The field is required';
    }
    if (value.length < 8) {
      return 'Phone number cannot be less than 8 digits';
    }
    if (value.length > 16) {
      return 'Phone number cannot be more than 16 digits';
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'The field is required';
    }
    if (value.length < 8) {
      return 'Password cannot be less than 8 characters';
    }
    return null;
  }

  void changeCountryCode(CountryCode countryCode) {
    _countryCode.value = countryCode.dialCode!;
  }
}
