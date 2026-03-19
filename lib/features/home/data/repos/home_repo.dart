import 'package:ecommerce_app/features/home/data/services/home_services.dart';

import '../models/product_model.dart';

class HomeRepo {
  final HomeService homeService;

  HomeRepo({required this.homeService});

  Future<List<ProductModel>> getProducts() async {
    final productsJson = await homeService.fetchProducts();
    return productsJson.map((e) => ProductModel.fromJson(e)).toList();
  }
}
