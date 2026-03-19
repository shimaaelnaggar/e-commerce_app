import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/Services/dio_services.dart';
import 'package:ecommerce_app/core/constants/api_constants.dart';

class HomeService {
  Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await DioServices.getData(
        endpoint: ApiConstants.productsEndpoint,
      );
      return response.data["products"];
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to load products");
    }
  }
}
