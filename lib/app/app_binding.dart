import 'package:ansicolor/ansicolor.dart';
import 'package:dio/dio.dart' as DioLib;
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';
import 'package:get/get.dart' as GetX;
import 'package:get_storage/get_storage.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../src/constants/endpoint.dart';

class AppBinding extends GetX.Bindings {
  @override
  void dependencies() {
    GetX.Get.put<GetStorage>(GetStorage());

    GetX.Get.put<DioLib.Dio>(
      DioLib.Dio(
        DioLib.BaseOptions(
          baseUrl: Endpoint.baseUrl,
          connectTimeout: const Duration(minutes: 1),
          followRedirects: false,
        ),
      )..interceptors.addAll([
          TalkerDioLogger(
            settings: TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
              printResponseMessage: true,
              // Blue http requests logs in console
              requestPen: AnsiPen()..blue(),
              // Green http responses logs in console
              responsePen: AnsiPen()..green(),
              // Error http logs in console
              errorPen: AnsiPen()..red(),
            ),
          ),
          DioLib.InterceptorsWrapper(
            onError: (error, handler) async {
              if (error.response?.statusCode == 401) {
                GetStorage local = GetX.Get.find<GetStorage>();
                if (local.hasData(LocalDataKey.token)) {
                  await local.remove(LocalDataKey.token);
                }
                SnackbarWidget.showFailedSnackbar(
                    NetworkingUtil.errorMessage(error));
                GetX.Get.offAllNamed(RouteName.login);
              }
              handler.next(error);
            },
          ),
        ]),
      permanent: true,
    );
  }
}
