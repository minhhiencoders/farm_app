import '../configs/contants.dart';

class AuthState {
  final AuthStatus status;
  final String? token;
  final String? errorMessage;

  AuthState({required this.status, this.token, this.errorMessage});
}
