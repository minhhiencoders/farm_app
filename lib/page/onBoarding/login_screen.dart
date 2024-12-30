import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/components/input_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/button_widget.dart';
import '../../view_models/auth_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final isObscureProvider = StateProvider<bool>((ref) => false);
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isObscureText = ref.watch(isObscureProvider);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputWidget(
            isEmail: true,
            checkValidate: true,
            hintText: AppLocalizations.of(context)!.hintEmail,
            label: AppLocalizations.of(context)!.email,
            controller: _emailController,
            isSuffix: const Icon(Icons.mail_outline),
          ),
          InputWidget(
            checkValidate: true,
            hintText: AppLocalizations.of(context)!.hintPW,
            label: AppLocalizations.of(context)!.pw,
            isObscureText: !isObscureText,
            controller: _passwordController,
            isSuffix: _buildPasswordToggle(isObscureText),
          ),
          ButtonWidget(
            onTap: _handleLogin,
            title: AppLocalizations.of(context)!.login,
            colorTitle: Colors.white,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordToggle(bool isObscureText) {
    return InkWell(
      onTap: () => ref.read(isObscureProvider.notifier).state = !isObscureText,
      focusNode: FocusNode(skipTraversal: true),
      child: Icon(
        isObscureText
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        size: 22,
      ),
    );
  }

  void _handleLogin() {
    // if (_formKey.currentState?.validate() ?? false) {
    //   KeyboardUtil.hideKeyboard(context);

    // }
    ref
        .read(authNotifierProvider.notifier)
        .authenticationLogin(_emailController.text, _passwordController.text);
  }
}
