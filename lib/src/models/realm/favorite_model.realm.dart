// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FavoriteItem extends _FavoriteItem
    with RealmEntity, RealmObjectBase, RealmObject {
  FavoriteItem(
    String id,
    String name,
    int price,
    int discountPrice, {
    Iterable<FavoriteImage> images = const [],
    bool? isPrescriptionDrugs,
    String? description,
    String? returnTerms,
    String? ratingAverage,
    int? ratingCount,
    int? reviewCount,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'discountPrice', discountPrice);
    RealmObjectBase.set<RealmList<FavoriteImage>>(
        this, 'images', RealmList<FavoriteImage>(images));
    RealmObjectBase.set(this, 'isPrescriptionDrugs', isPrescriptionDrugs);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'returnTerms', returnTerms);
    RealmObjectBase.set(this, 'ratingAverage', ratingAverage);
    RealmObjectBase.set(this, 'ratingCount', ratingCount);
    RealmObjectBase.set(this, 'reviewCount', reviewCount);
  }

  FavoriteItem._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get price => RealmObjectBase.get<int>(this, 'price') as int;
  @override
  set price(int value) => RealmObjectBase.set(this, 'price', value);

  @override
  int get discountPrice =>
      RealmObjectBase.get<int>(this, 'discountPrice') as int;
  @override
  set discountPrice(int value) =>
      RealmObjectBase.set(this, 'discountPrice', value);

  @override
  RealmList<FavoriteImage> get images =>
      RealmObjectBase.get<FavoriteImage>(this, 'images')
          as RealmList<FavoriteImage>;
  @override
  set images(covariant RealmList<FavoriteImage> value) =>
      throw RealmUnsupportedSetError();

  @override
  bool? get isPrescriptionDrugs =>
      RealmObjectBase.get<bool>(this, 'isPrescriptionDrugs') as bool?;
  @override
  set isPrescriptionDrugs(bool? value) =>
      RealmObjectBase.set(this, 'isPrescriptionDrugs', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String? get returnTerms =>
      RealmObjectBase.get<String>(this, 'returnTerms') as String?;
  @override
  set returnTerms(String? value) =>
      RealmObjectBase.set(this, 'returnTerms', value);

  @override
  String? get ratingAverage =>
      RealmObjectBase.get<String>(this, 'ratingAverage') as String?;
  @override
  set ratingAverage(String? value) =>
      RealmObjectBase.set(this, 'ratingAverage', value);

  @override
  int? get ratingCount => RealmObjectBase.get<int>(this, 'ratingCount') as int?;
  @override
  set ratingCount(int? value) =>
      RealmObjectBase.set(this, 'ratingCount', value);

  @override
  int? get reviewCount => RealmObjectBase.get<int>(this, 'reviewCount') as int?;
  @override
  set reviewCount(int? value) =>
      RealmObjectBase.set(this, 'reviewCount', value);

  @override
  Stream<RealmObjectChanges<FavoriteItem>> get changes =>
      RealmObjectBase.getChanges<FavoriteItem>(this);

  @override
  Stream<RealmObjectChanges<FavoriteItem>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<FavoriteItem>(this, keyPaths);

  @override
  FavoriteItem freeze() => RealmObjectBase.freezeObject<FavoriteItem>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'price': price.toEJson(),
      'discountPrice': discountPrice.toEJson(),
      'images': images.toEJson(),
      'isPrescriptionDrugs': isPrescriptionDrugs.toEJson(),
      'description': description.toEJson(),
      'returnTerms': returnTerms.toEJson(),
      'ratingAverage': ratingAverage.toEJson(),
      'ratingCount': ratingCount.toEJson(),
      'reviewCount': reviewCount.toEJson(),
    };
  }

  static EJsonValue _toEJson(FavoriteItem value) => value.toEJson();
  static FavoriteItem _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'price': EJsonValue price,
        'discountPrice': EJsonValue discountPrice,
        'images': EJsonValue images,
        'isPrescriptionDrugs': EJsonValue isPrescriptionDrugs,
        'description': EJsonValue description,
        'returnTerms': EJsonValue returnTerms,
        'ratingAverage': EJsonValue ratingAverage,
        'ratingCount': EJsonValue ratingCount,
        'reviewCount': EJsonValue reviewCount,
      } =>
        FavoriteItem(
          fromEJson(id),
          fromEJson(name),
          fromEJson(price),
          fromEJson(discountPrice),
          images: fromEJson(images),
          isPrescriptionDrugs: fromEJson(isPrescriptionDrugs),
          description: fromEJson(description),
          returnTerms: fromEJson(returnTerms),
          ratingAverage: fromEJson(ratingAverage),
          ratingCount: fromEJson(ratingCount),
          reviewCount: fromEJson(reviewCount),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FavoriteItem._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, FavoriteItem, 'FavoriteItem', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.int),
      SchemaProperty('discountPrice', RealmPropertyType.int),
      SchemaProperty('images', RealmPropertyType.object,
          linkTarget: 'FavoriteImage',
          collectionType: RealmCollectionType.list),
      SchemaProperty('isPrescriptionDrugs', RealmPropertyType.bool,
          optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('returnTerms', RealmPropertyType.string, optional: true),
      SchemaProperty('ratingAverage', RealmPropertyType.string, optional: true),
      SchemaProperty('ratingCount', RealmPropertyType.int, optional: true),
      SchemaProperty('reviewCount', RealmPropertyType.int, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class FavoriteImage extends _FavoriteImage
    with RealmEntity, RealmObjectBase, RealmObject {
  FavoriteImage(
    String id,
    String productId, {
    String? path,
    String? pathSmall,
    String? url,
    String? urlSmall,
    String? createdAt,
    String? updatedAt,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'productId', productId);
    RealmObjectBase.set(this, 'path', path);
    RealmObjectBase.set(this, 'pathSmall', pathSmall);
    RealmObjectBase.set(this, 'url', url);
    RealmObjectBase.set(this, 'urlSmall', urlSmall);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  FavoriteImage._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get productId =>
      RealmObjectBase.get<String>(this, 'productId') as String;
  @override
  set productId(String value) => RealmObjectBase.set(this, 'productId', value);

  @override
  String? get path => RealmObjectBase.get<String>(this, 'path') as String?;
  @override
  set path(String? value) => RealmObjectBase.set(this, 'path', value);

  @override
  String? get pathSmall =>
      RealmObjectBase.get<String>(this, 'pathSmall') as String?;
  @override
  set pathSmall(String? value) => RealmObjectBase.set(this, 'pathSmall', value);

  @override
  String? get url => RealmObjectBase.get<String>(this, 'url') as String?;
  @override
  set url(String? value) => RealmObjectBase.set(this, 'url', value);

  @override
  String? get urlSmall =>
      RealmObjectBase.get<String>(this, 'urlSmall') as String?;
  @override
  set urlSmall(String? value) => RealmObjectBase.set(this, 'urlSmall', value);

  @override
  String? get createdAt =>
      RealmObjectBase.get<String>(this, 'createdAt') as String?;
  @override
  set createdAt(String? value) => RealmObjectBase.set(this, 'createdAt', value);

  @override
  String? get updatedAt =>
      RealmObjectBase.get<String>(this, 'updatedAt') as String?;
  @override
  set updatedAt(String? value) => RealmObjectBase.set(this, 'updatedAt', value);

  @override
  Stream<RealmObjectChanges<FavoriteImage>> get changes =>
      RealmObjectBase.getChanges<FavoriteImage>(this);

  @override
  Stream<RealmObjectChanges<FavoriteImage>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<FavoriteImage>(this, keyPaths);

  @override
  FavoriteImage freeze() => RealmObjectBase.freezeObject<FavoriteImage>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'productId': productId.toEJson(),
      'path': path.toEJson(),
      'pathSmall': pathSmall.toEJson(),
      'url': url.toEJson(),
      'urlSmall': urlSmall.toEJson(),
      'createdAt': createdAt.toEJson(),
      'updatedAt': updatedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(FavoriteImage value) => value.toEJson();
  static FavoriteImage _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'productId': EJsonValue productId,
        'path': EJsonValue path,
        'pathSmall': EJsonValue pathSmall,
        'url': EJsonValue url,
        'urlSmall': EJsonValue urlSmall,
        'createdAt': EJsonValue createdAt,
        'updatedAt': EJsonValue updatedAt,
      } =>
        FavoriteImage(
          fromEJson(id),
          fromEJson(productId),
          path: fromEJson(path),
          pathSmall: fromEJson(pathSmall),
          url: fromEJson(url),
          urlSmall: fromEJson(urlSmall),
          createdAt: fromEJson(createdAt),
          updatedAt: fromEJson(updatedAt),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FavoriteImage._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, FavoriteImage, 'FavoriteImage', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('productId', RealmPropertyType.string),
      SchemaProperty('path', RealmPropertyType.string, optional: true),
      SchemaProperty('pathSmall', RealmPropertyType.string, optional: true),
      SchemaProperty('url', RealmPropertyType.string, optional: true),
      SchemaProperty('urlSmall', RealmPropertyType.string, optional: true),
      SchemaProperty('createdAt', RealmPropertyType.string, optional: true),
      SchemaProperty('updatedAt', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
