import 'package:entrance_test/src/constants/words.dart';
import 'package:entrance_test/src/models/product_image_model.dart';
import 'package:entrance_test/src/models/rating_model.dart';
import 'package:entrance_test/src/models/request/rating_list_request_model.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final ProductRepository _productRepository;

  ProductDetailController({required ProductRepository productRepository})
      : _productRepository = productRepository;

  final _id = Get.parameters['id'];

  final _name = ''.obs;
  String get name => _name.value;

  final _price = 0.obs;
  int get price => _price.value;

  final _discountPrice = 0.obs;
  int get discountPrice => _discountPrice.value;

  final _images = Rx<List<ProductImageModel>>([]);
  List<ProductImageModel> get images => _images.value;

  final _description = ''.obs;
  String get description => _description.value;

  final _returnTerms = ''.obs;
  String get returnTerms => _returnTerms.value;

  final _ratingAverage = ''.obs;
  String get ratingAverage => _ratingAverage.value;

  final _ratingCount = 0.obs;
  int get ratingCount => _ratingCount.value;

  final _reviewCount = 0.obs;
  int get reviewCount => _reviewCount.value;

  final _ratings = Rx<List<RatingModel>>([]);
  List<RatingModel> get ratings => _ratings.value;

  final _isLoadingRetrieveProduct = false.obs;
  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  @override
  void onInit() {
    super.onInit();
    if (_id == null) {
      SnackbarWidget.showFailedSnackbar('Id not found');
    } else {
      loadProductDetailFromServer(_id!);
      loadRatingFromServer(_id!);
    }
  }

  void loadProductDetailFromServer(String id) async {
    _isLoadingRetrieveProduct.value = true;
    try {
      final response = await _productRepository.getProductDetail(id);
      if (response.status == 0) {
        final productDetail = response.data;

        _name.value = productDetail.name;
        _price.value = productDetail.price;
        _discountPrice.value = productDetail.discountPrice;
        _images.value = productDetail.images ?? [];
        _images.refresh();
        _description.value = productDetail.description ?? Words.longLorem;
        _returnTerms.value = productDetail.returnTerms ?? Words.longLorem;
        _ratingAverage.value = productDetail.ratingAverage ?? '0';
        _ratingCount.value = productDetail.ratingCount ?? 0;
        _reviewCount.value = productDetail.reviewCount ?? 0;
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveProduct.value = false;
  }

  void loadRatingFromServer(String id) async {
    try {
      final response = await _productRepository.getRatingList(
        RatingListRequestModel(
          productId: _id!,
          limit: 3,
        ),
      );
      if (response.status == 0) {
        _ratings.value = response.data;
        _ratings.refresh();

        print(_ratings.value.toString());
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }
}
