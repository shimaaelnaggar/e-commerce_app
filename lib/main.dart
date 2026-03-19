import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/Services/dio_services.dart';
import 'package:ecommerce_app/core/Services/shared_pref.dart';
import 'package:ecommerce_app/core/routing/app_router.dart';
import 'package:ecommerce_app/core/routing/routes.dart';
import 'package:ecommerce_app/features/auth/data/repos/auth_repo.dart';
import 'package:ecommerce_app/features/auth/data/services/auth_services.dart';
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
  DioServices.init();
  final token = SharedPrefsHelper.getString('token');
  runApp(
    BlocProvider<AuthCubit>(
      create: (_) =>
          AuthCubit(Dio(), authRepo: AuthRepo(authService: AuthService())),
      child: MyApp(isLoggedIn: token != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VELORA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: (settings) => AppRouter().generateRoute(settings),
      initialRoute: isLoggedIn ? Routes.home : Routes.splash,
    );
  }
}
