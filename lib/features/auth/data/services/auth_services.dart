import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/Services/dio_services.dart';
import 'package:ecommerce_app/core/constants/api_constants.dart';

class AuthService {
  Future<String> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await DioServices.dio.post(
        ApiConstants.loginEndpoint,
        data: {'username': username, 'password': password},
      );

      final token = response.data["accessToken"];
      if (token == null) throw Exception("Invalid response from server");
      return token;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Login failed");
    }
  }
}
