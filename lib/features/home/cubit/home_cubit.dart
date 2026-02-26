import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/home/models/product_model.dart';
import 'package:flutter/material.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final Dio _dio = Dio(BaseOptions(baseUrl: "https://dummyjson.com/"));

  Future<void> getProducts() async {
    emit(HomeLoading());

    try {
      final response = await _dio.get("products");

      final List productsJson = response.data["products"];

      final products = productsJson
          .map((e) => ProductModel.fromJson(e))
          .toList();

      emit(HomeLoaded(products));
    } on DioException catch (e) {
      emit(
        HomeFailure(e.response?.data["message"] ?? "Failed to load products"),
      );
    } catch (e) {
      // print(e.toString());
      emit(HomeFailure(e.toString()));
    }
  }
}
