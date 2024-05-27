import 'package:dio/dio.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/models/user_model.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../utils/date_util.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class EditProfileController extends GetxController {
  final UserRepository _userRepository;

  EditProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final GlobalKey<FormState> formFieldKey = GlobalKey();

  final etFullName = TextEditingController();
  final etPhoneNumber = TextEditingController();
  final etEmail = TextEditingController();
  final etHeight = TextEditingController();
  final etWeight = TextEditingController();
  final etBirthDate = TextEditingController();

  final _countryCode = "".obs;

  String get countryCode => _countryCode.value;

  final _gender = ''.obs;

  String get gender => _gender.value;

  final _profilePictureUrlOrPath = ''.obs;

  String get profilePictureUrlOrPath => _profilePictureUrlOrPath.value;

  final _isLoadPictureFromPath = false.obs;

  bool get isLoadPictureFromPath => _isLoadPictureFromPath.value;

  final _isGenderFemale = false.obs;

  bool get isGenderFemale => _isGenderFemale.value;

  DateTime birthDate = DateTime.now();

  late final String _id;

  final _isUpdatingProfile = false.obs;
  bool get isUpdatingProfile => _isUpdatingProfile.value;

  List<TextInputFormatter>? numberInputFormatters = [
    FilteringTextInputFormatter.allow(
      // only allow numbers (0 – 9) and deny 0 as prefix
      RegExp(r'^(0|[1-9][0-9]*)$'),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;
        _id = localUser.id;
        etFullName.text = localUser.name;
        etPhoneNumber.text = localUser.phone;
        etEmail.text = localUser.email ?? '';
        etHeight.text = localUser.height?.toString() ?? '';
        etWeight.text = localUser.weight?.toString() ?? '';

        _countryCode.value = localUser.countryCode;

        _profilePictureUrlOrPath.value = localUser.profilePicture ?? '';
        _isLoadPictureFromPath.value = false;

        _gender.value = localUser.gender ?? '';
        if (gender.isNullOrEmpty || gender == 'laki_laki') {
          onChangeGender(false);
        } else {
          onChangeGender(true);
        }

        etBirthDate.text = '';
        if (localUser.dateOfBirth.isNullOrEmpty == false) {
          birthDate =
              DateUtil.getDateFromShortServerFormat(localUser.dateOfBirth!);
          etBirthDate.text = DateUtil.getBirthDate(birthDate);
        }
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      error.printError();
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  void changeImage() async {
    //TODO: Implement change profile image
  }

  void onChangeGender(bool isFemale) {
    if (isFemale) {
      _gender.value = 'perempuan';
    } else {
      _gender.value = 'laki_laki';
    }
    _isGenderFemale.value = isFemale;
  }

  void onChangeBirthDate(DateTime dateTime) {
    birthDate = dateTime;
    etBirthDate.text = DateUtil.getBirthDate(birthDate);
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'The field is required';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'The field is required';
    }

    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!isValid) {
      return 'Email is not valid';
    }

    return null;
  }

  String? heightAndWeightValidator(value) {
    if (value == null || value.isEmpty) {
      return 'The field is required';
    }
    if (int.parse(value) <= 0) {
      return 'Must be > 0';
    }
    return null;
  }

  void saveData() {
    _isUpdatingProfile.value = true;
    if (!formFieldKey.currentState!.validate()) {
      _isUpdatingProfile.value = false;
      return;
    }
    try {
      _isUpdatingProfile.value = true;
      _userRepository.updateUser(
        UserModel(
          id: _id,
          name: etFullName.text,
          phone: etPhoneNumber.text,
          countryCode: countryCode,
          email: etEmail.text,
          gender: gender,
          height: int.parse(etHeight.text),
          weight: int.parse(etWeight.text),
          dateOfBirth: DateUtil.getShortServerFormatDateString(birthDate),
        ),
      );
      SnackbarWidget.showSuccessSnackbar('Profile is Updated.');
      Get.offNamed(RouteName.dashboard);
    } on DioException catch (e) {
      if (e.response != null) {
        String? error = e.response?.data['message'];
        SnackbarWidget.showFailedSnackbar('Failed to Sign in: $error');
      } else {
        SnackbarWidget.showFailedSnackbar('Something is wrong.');
      }
      _isUpdatingProfile.value = false;
    }
  }
}
