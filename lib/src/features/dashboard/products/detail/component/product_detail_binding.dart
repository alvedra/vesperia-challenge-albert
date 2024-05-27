import 'package:dio/dio.dart';
import 'package:entrance_test/src/features/dashboard/products/detail/component/product_detail_controller.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(ProductDetailController(
      productRepository: Get.find<ProductRepository>(),
    ));
  }
}
