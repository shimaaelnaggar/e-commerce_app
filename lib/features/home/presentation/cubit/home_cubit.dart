import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/data/repos/home_repo.dart';
import 'package:flutter/material.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  Future<void> getProducts() async {
    emit(HomeLoading());
    try {
      final products = await homeRepo.getProducts();
      emit(HomeLoaded(products));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
