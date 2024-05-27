import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entrance_test/src/models/realm/favorite_model.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;
  final FavoriteModel _favoriteModel;

  final _name = "".obs;

  String get name => _name.value;

  final _phone = "".obs;

  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;

  String get profilePictureUrl => _profilePictureUrl.value;

  final _isSigningOut = false.obs;
  bool get isSigningOut => _isSigningOut.value;

  final dio = Dio();
  late bool _permissionReady;
  late TargetPlatform? platform;
  late String _localPath;

  ProfileController({
    required UserRepository userRepository,
    required FavoriteModel favoriteModel,
  })  : _userRepository = userRepository,
        _favoriteModel = favoriteModel;

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();

    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;

        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty
            ? "+${localUser.countryCode}${localUser.phone}"
            : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  void handleErrorRequest() async {
    try {
      await onTestUnauthenticatedClick();
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
      }
    }
  }

  onDownloadFileClick() async {
    _permissionReady = await _checkPermission();
    SnackbarWidget.showNeutralSnackbar('Downloading File...');
    if (_permissionReady) {
      await _prepareSaveDir();
      try {
        var savePath = '$_localPath/flutter_tutorial.pdf';
        await dio.download(
          'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf',
          savePath,
        );
        SnackbarWidget.showSuccessSnackbar('File successfully Downloaded');
      } catch (e) {
        // error downloading file
        SnackbarWidget.showFailedSnackbar('Download failed: $e');
      }
    }
  }

  onOpenWebPageClick() async {
    final Uri uri = Uri(
        scheme: 'https',
        host: 'youtube.com',
        path: 'watch',
        queryParameters: {'v': 'lpnKWK-KEYs'});

    try {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } catch (e) {
      SnackbarWidget.showFailedSnackbar('Cannot open webpage: $e');
    }
  }

  void doLogout() async {
    _isSigningOut.value = true;
    Get.defaultDialog(
      title: 'Do you want to Logout?',
      middleText: 'You will be signed out and need to sign in again.',
      onConfirm: () async {
        try {
          await _userRepository.logout();
          _favoriteModel.removeAll();
          Get.offAllNamed(RouteName.login);
        } catch (e) {
          SnackbarWidget.showFailedSnackbar('Failed to logout: $e');
          Get.back();
          _isSigningOut.value = false;
        }
      },
      onCancel: () {
        Get.back();
        _isSigningOut.value = false;
      },
    );
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.manageExternalStorage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.manageExternalStorage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    String directory;
    if (Platform.isIOS) {
      directory = (await getDownloadsDirectory())?.path ??
          (await getTemporaryDirectory()).path;
    } else {
      directory = '/storage/emulated/0/Download/';
      var dirDownloadExists = true;
      dirDownloadExists = await Directory(directory).exists();
      if (!dirDownloadExists) {
        directory = '/storage/emulated/0/Downloads/';
        dirDownloadExists = await Directory(directory).exists();
        if (!dirDownloadExists) {
          directory = (await getTemporaryDirectory()).path;
        }
      }
    }
    return directory;
  }
}
