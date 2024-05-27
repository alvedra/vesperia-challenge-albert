import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/models/realm/favorite_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../models/product_model.dart';
import '../../../../../models/request/product_list_request_model.dart';
import '../../../../../repositories/product_repository.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class ProductListController extends GetxController {
  final ProductRepository _productRepository;
  final FavoriteModel _favoriteModel;

  ProductListController(
      {required ProductRepository productRepository,
      required FavoriteModel favoriteModel})
      : _productRepository = productRepository,
        _favoriteModel = favoriteModel;

  final _products = Rx<List<ProductModel>>([]);

  List<ProductModel> get products => _products.value;

  final _isLoadingRetrieveProduct = false.obs;

  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  final _isLoadingRetrieveMoreProduct = false.obs;

  bool get isLoadingRetrieveMoreProduct => _isLoadingRetrieveMoreProduct.value;

  final _isLoadingRetrieveCategory = false.obs;

  bool get isLoadingRetrieveCategory => _isLoadingRetrieveCategory.value;

  final _canFilterCategory = true.obs;

  bool get canFilterCategory => _canFilterCategory.value;

  final _isLastPageProduct = false.obs;

  //The number of product retrieved each time a call is made to server
  final _limit = 10;

  //The number which shows how many product already loaded to the device,
  //thus giving the command to ignore the first x number of data when retrieving
  int _skip = 0;

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    getProducts();

    scrollController = ScrollController()..addListener(getMoreProducts);
  }

  //first load or after refresh.
  void getProducts() async {
    _isLoadingRetrieveProduct.value = true;
    _skip = 0;
    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));

      // Check if products is in the favorite;
      final productListWithFavorites = productList.data
          .map((product) =>
              product..isFavorite = _favoriteModel.isProductInFavorite(product))
          .toList();

      _products.value = productListWithFavorites;
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveProduct.value = false;
  }

  void getMoreProducts() async {
    if (_isLastPageProduct.value || _isLoadingRetrieveMoreProduct.value) return;

    _isLoadingRetrieveMoreProduct.value = true;

    if (scrollController.position.extentAfter < 300) {
      try {
        final productList =
            await _productRepository.getProductList(ProductListRequestModel(
          limit: _limit,
          skip: _skip,
        ));

        // Check if products is in the favorite;
        final productListWithFavorites = productList.data
            .map((product) => product
              ..isFavorite = _favoriteModel.isProductInFavorite(product))
            .toList();

        _products.value.addAll(productListWithFavorites);
        _products.refresh();
        _isLastPageProduct.value = productList.data.length < _limit;
        _skip = products.length;
      } catch (error) {
        SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
      }
    }

    _isLoadingRetrieveMoreProduct.value = false;
  }

  void toProductDetail(ProductModel product) async {
    Get.toNamed(RouteName.productDetailById(product.id));
  }

  void setFavorite(ProductModel product) {
    if (!product.isFavorite) {
      product.isFavorite = true;
      _favoriteModel.addToFavorite(product);
      SnackbarWidget.showSuccessSnackbar('Added to Favorite');
    } else {
      product.isFavorite = false;
      _favoriteModel.removeFromFavorite(product);
      SnackbarWidget.showSuccessSnackbar('Removed From Favorite');
    }
  }
}
