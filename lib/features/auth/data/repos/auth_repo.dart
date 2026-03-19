import 'package:ecommerce_app/features/auth/data/services/auth_services.dart';

class AuthRepo {
  final AuthService authService;

  AuthRepo({required this.authService});

  Future<String> login(String username, String password) async {
    return await authService.login(username: username, password: password);
  }
}
