import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/model/information.dart';

import '../base/provider/dio_client.dart';
import '../base/provider/dio_exceptions.dart';
import '../configs/contants.dart';
import '../model/auth.dart';
import '../repositories/login_repo/login_repo_imp.dart';
import '../utilities/hive_utils.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginRepoImp _apiService;

  AuthNotifier(this._apiService)
      : super(AuthState(status: AuthStatus.unauthenticated)) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final value = HiveUtils.getData<String>(key: Contant.AUTHEN_TOKEN);
    if (value != null) {
      state = AuthState(status: AuthStatus.authenticated, token: value);
    } else {
      state = AuthState(status: AuthStatus.unauthenticated, token: value);
    }
  }

  Future<void> authenticationLogin(String email, String password) async {
    try {
      state = AuthState(status: AuthStatus.loading);
      await _apiService.getInformation(email, password).then(
        (information) async {
          if (information.authToken?.isNotEmpty ?? false) {
            state = AuthState(
              status: AuthStatus.authenticated,
              token: information.authToken, // Use actual token from API
            );
            HiveUtils.saveData(key: Contant.AUTHEN_TOKEN, value: information.authToken);
            HiveUtils.saveData<Information>(key: Contant.INFORMATION, value: information);
          }
        },
      ).onError(
        (DioException error, stackTrace) {
          final errorMessage = DioExceptions.fromDioError(error);
          state = state = AuthState(
              status: AuthStatus.error, errorMessage: errorMessage.toString());
        },
      );
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      state = state = AuthState(
          status: AuthStatus.error, errorMessage: errorMessage.toString());
    }
  }

  Future<void> logout() async {
    await HiveUtils.closeAllBoxes().whenComplete(
      () {
        state = AuthState(status: AuthStatus.unauthenticated);
      },
    );
  }
}

final apiServiceProvider = Provider<LoginRepoImp>((ref) {
  return LoginRepoImp(DioClient(Dio()));
});
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(apiServiceProvider));
});
