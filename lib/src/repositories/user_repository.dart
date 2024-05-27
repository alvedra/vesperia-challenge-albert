import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/endpoint.dart';
import '../models/response/user_response_model.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;

  UserRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  Future<void> login(
      String phoneNumber, String password, String countryCode) async {
    // //Artificial delay to simulate logging in process
    // await Future.delayed(const Duration(seconds: 2));
    // //Placeholder token. DO NOT call real logout API using this token
    // _local.write(
    //     LocalDataKey.token, "621|DBiUBMfsEtX01tbdu4duNRCNMTt7PV5blr6zxTvq");

    try {
      final responseJson = await _client.post(
        Endpoint.signIn,
        data: {
          'phone_number': phoneNumber,
          'password': password,
          'country_code': countryCode.substring(1)
        },
      );
      if (responseJson.statusCode == 200) {
        String token = responseJson.data['data']['token'];
        await _local.write(LocalDataKey.token, token);
      }
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    // //Artificial delay to simulate logging out process
    // await Future.delayed(const Duration(seconds: 2));
    // await _local.remove(LocalDataKey.token);

    try {
      final responseJson = await _client.post(
        Endpoint.signOut,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      if (responseJson.statusCode == 200) {
        await _local.remove(LocalDataKey.token);
      }
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<UserResponseModel> getUser() async {
    try {
      final responseJson = await _client.get(
        Endpoint.getUser,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      final model = UserResponseModel.fromJson(responseJson.data);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<UserResponseModel> updateUser(UserModel user) async {
    try {
      final formData = FormData.fromMap({
        'name': user.name,
        'email': user.email,
        'gender': user.gender,
        'date_of_birth': user.dateOfBirth,
        'height': user.height,
        'weight': user.weight,
        'profile_picture': user.profilePicture,
        '_method': 'PUT',
      });
      final responseJson = await _client.post(
        Endpoint.updateUser,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
        data: formData,
      );
      final model = UserResponseModel.fromJson(responseJson.data);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  Future<void> testUnauthenticated() async {
    try {
      final realToken = _local.read<String?>(LocalDataKey.token);
      await _local.write(
          LocalDataKey.token, '619|kM5YBY5yM15KEuSmSMaEzlfv0lWs83r4cp4oty2T');
      getUser();
      //401 not caught as exception
      await _local.write(LocalDataKey.token, realToken);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
