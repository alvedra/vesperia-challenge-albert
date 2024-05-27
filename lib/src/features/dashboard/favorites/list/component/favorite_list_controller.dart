import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/models/realm/favorite_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../models/product_model.dart';
import '../../../../../models/request/product_list_request_model.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class FavoriteListController extends GetxController {
  final FavoriteModel _favoriteModel;

  FavoriteListController({required FavoriteModel favoriteModel})
      : _favoriteModel = favoriteModel;

  final _products = Rx<List<FavoriteItem>>([]);

  List<FavoriteItem> get products => _products.value;

  final _isLoadingRetrieveProduct = false.obs;

  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  final _isLoadingRetrieveMoreProduct = false.obs;

  bool get isLoadingRetrieveMoreProduct => _isLoadingRetrieveMoreProduct.value;

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    getProducts();

    scrollController = ScrollController();
  }

  //first load or after refresh.
  void getProducts() async {
    _isLoadingRetrieveProduct.value = true;

    try {
      final productList = _favoriteModel.getFavoriteList();
      _products.value = productList;
      _products.refresh();
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(error.toString());
    }
    _isLoadingRetrieveProduct.value = false;
  }

  void toProductDetail(FavoriteItem product) async {
    Get.toNamed(RouteName.productDetailById(product.id));
  }
}
