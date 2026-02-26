import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/helpers/shared_pref.dart';
import 'package:flutter/material.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.dio) : super(AuthInitial());
  final Dio dio;
  Future<void> login(String name, String password) async {
    emit(AuthLoading());

    try {
      final response = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {'username': name, 'password': password},
        options: Options(contentType: Headers.jsonContentType),
      );

      final token = response.data["accessToken"];
      if (token == null) {
        emit(AuthFailure("Invalid response from server"));
        return;
      }

      await SharedPrefsHelper.setString('token', token);

      emit(AuthSuccess(token));
    } on DioException catch (e) {
      emit(AuthFailure(e.response?.data["message"] ?? "Login failed"));
    }
  }
}
