import 'package:entrance_test/src/models/user_model.dart';
import 'package:get/get.dart';

class RatingModel {
  RatingModel({
    required this.id,
    required this.createdAt,
    required this.review,
    required this.rating,
    required this.user,
  });

  final String id;
  final String createdAt;
  final String review;
  final int rating;
  final UserModel? user;

  final _isFavorite = false.obs;
  bool get isFavorite => _isFavorite.value;
  set isFavorite(bool newValue) => _isFavorite.value = newValue;

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        id: json['id'],
        createdAt: json['created_at'],
        review: json['review'],
        rating: json['rating'],
        user: UserModel.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'review': review,
        'rating': rating,
        'user': user?.toJson()
      };
}

enum RatingSort {
  newest,
  ratingAscending,
  ratingDescending,
}

extension SortExtension on RatingSort {
  String get name {
    switch (this) {
      case RatingSort.newest:
        return 'Newest';
      case RatingSort.ratingAscending:
        return 'Rating: Low to High';
      case RatingSort.ratingDescending:
        return 'Rating: High to Low';
      default:
        return 'Newest';
    }
  }
}

class SortType {
  static String getSortByValue(RatingSort sort) {
    switch (sort) {
      case RatingSort.newest:
        return 'created_at';
      case RatingSort.ratingAscending:
        return 'rating';
      case RatingSort.ratingDescending:
        return 'rating';
      default:
        return 'id';
    }
  }

  static String getSortColumnValue(RatingSort sort) {
    switch (sort) {
      case RatingSort.newest:
        return 'desc';
      case RatingSort.ratingAscending:
        return 'asc';
      case RatingSort.ratingDescending:
        return 'desc';
      default:
        return 'asc';
    }
  }
}
