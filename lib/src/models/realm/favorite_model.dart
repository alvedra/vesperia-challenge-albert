import 'package:entrance_test/src/models/product_model.dart';
import 'package:realm/realm.dart';

part 'favorite_model.realm.dart';

@RealmModel()
class _FavoriteItem {
  @PrimaryKey()
  late String id;
  late String name;
  late int price;
  late int discountPrice;
  late List<_FavoriteImage> images;
  late bool? isPrescriptionDrugs;
  late String? description;
  late String? returnTerms;
  late String? ratingAverage;
  late int? ratingCount;
  late int? reviewCount;
}

@RealmModel()
class _FavoriteImage {
  @PrimaryKey()
  late String id;
  late String productId;
  late String? path;
  late String? pathSmall;
  late String? url;
  late String? urlSmall;
  late String? createdAt;
  late String? updatedAt;
}

class FavoriteModel {
  late Realm realm;

  FavoriteModel() {
    var config =
        Configuration.local([FavoriteItem.schema, FavoriteImage.schema]);
    realm = Realm(config);
  }

  void addToFavorite(ProductModel product) {
    realm.write(() {
      final images = product.images!.map((image) => FavoriteImage(
            image.id,
            image.productId,
            path: image.path,
            pathSmall: image.pathSmall,
            url: image.url,
            urlSmall: image.urlSmall,
            createdAt: image.createdAt,
            updatedAt: image.updatedAt,
          ));
      realm.add(FavoriteItem(
        product.id,
        product.name,
        product.price,
        product.discountPrice,
        images: images,
        isPrescriptionDrugs: product.isPrescriptionDrugs,
        description: product.description,
        returnTerms: product.returnTerms,
        ratingAverage: product.ratingAverage,
        ratingCount: product.ratingCount,
        reviewCount: product.reviewCount,
      ));
    });
  }

  bool isProductInFavorite(ProductModel product) {
    var productFound = realm.find<FavoriteItem>(product.id);
    return productFound != null;
  }

  void removeFromFavorite(ProductModel product) {
    final productFound = realm.find<FavoriteItem>(product.id);
    if (productFound != null) {
      realm.write(() {
        realm.delete<FavoriteItem>(productFound);
      });
    }
  }

  void removeAll() {
    realm.write(() {
      realm.deleteAll<FavoriteItem>();
    });
  }

  List<FavoriteItem> getFavoriteList() {
    final itemList = realm.all<FavoriteItem>();
    return itemList.toList();
  }
}
