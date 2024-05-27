import 'package:entrance_test/src/models/rating_model.dart';

class RatingListResponseModel {
  RatingListResponseModel(
      {required this.status, required this.message, required this.data});

  final int status;
  final String message;
  final List<RatingModel> data;

  factory RatingListResponseModel.fromJson(Map<String, dynamic> json) =>
      RatingListResponseModel(
        status: json['status'],
        message: json['message'],
        data: List<RatingModel>.from(
            json['data'].map((x) => RatingModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
