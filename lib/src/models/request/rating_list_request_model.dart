import 'package:entrance_test/src/models/rating_model.dart';

class RatingListRequestModel {
  RatingListRequestModel({
    required this.productId,
    RatingSort? sort,
    int? limit,
    int? skip,
  })  : _sortBy = SortType.getSortByValue(sort ?? RatingSort.newest),
        _sortOrder = SortType.getSortColumnValue(sort ?? RatingSort.newest),
        _limit = limit ?? 10,
        _skip = skip ?? 0;

  final String productId;
  final String _sortBy;
  final String _sortOrder;
  final int _limit;
  final int _skip;

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'sort_column': _sortBy,
        'sort_order': _sortOrder,
        'limit': _limit,
        'skip': _skip,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
