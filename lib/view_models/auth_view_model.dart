import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/model/information.dart';

import '../base/custom-exception.dart';
import '../base/provider/api_provider_imp.dart';
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
    await HiveUtils.getValue<String?>(
            Contant.AUTHENTICATION, Contant.AUTHEN_TOKEN)
        .then(
      (value) {
        if (value != null) {
          state = AuthState(status: AuthStatus.authenticated, token: value);
        } else {
          state = AuthState(status: AuthStatus.unauthenticated, token: value);
        }
      },
    );
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
            await HiveUtils.putValue<String?>(Contant.AUTHENTICATION,
                Contant.AUTHEN_TOKEN, information.authToken);
            await HiveUtils.putValue<Information?>(
                Contant.INFORMATION_LIST, Contant.INFORMATION, information);
          }
        },
      ).onError(
        (error, stackTrace) {
          state = state = AuthState(
              status: AuthStatus.error, errorMessage: error.toString());
        },
      );
    } on ECException catch (e) {
      state = state =
          AuthState(status: AuthStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    await HiveUtils.closeAll().whenComplete(
      () {
        state = AuthState(status: AuthStatus.unauthenticated);
      },
    );
  }
}

final apiServiceProvider = Provider<LoginRepoImp>((ref) {
  return LoginRepoImp(ApiProviderImp());
});
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(apiServiceProvider));
});
