import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/core/theme/model/color_collection.dart';
import 'package:own/features/auth/widgets/auth_button.dart';
import 'package:own/features/auth/widgets/auth_header.dart';
import 'package:own/features/auth/widgets/auth_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // имитация API
    setState(() => _isLoading = false);

    if (!mounted) return;
    context.go(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollection.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  const AuthHeader(
                    title: 'Добро пожаловать 👋',
                    subtitle: 'Войдите в свой аккаунт, чтобы продолжить',
                  ),

                  const SizedBox(height: 8),
                 

                  /// Email
                  AuthTextField(
                    controller: _emailController,
                    hintText: 'E-mail',
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите e-mail';
                      }
                      if (!value.contains('@')) {
                        return 'Неверный формат e-mail';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  /// Пароль
                  AuthTextField(
                    controller: _passwordController,
                    hintText: 'Пароль',
                    icon: Icons.lock_outline,
                    obscureText: !_isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите пароль';
                      }
                      if (value.length < 6) {
                        return 'Минимум 6 символов';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: ColorCollection.gray700,
                      ),
                      onPressed: () {
                        setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  /// Кнопка входа
                  AuthButton(
                    text: 'Войти',
                    isLoading: _isLoading,
                    onPressed: _login,
                  ),
                  const SizedBox(height: 20),

                  /// Регистрация
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Нет аккаунта?',
                        style: TextStyle(color: ColorCollection.gray700),
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRoutes.register),
                        child: const Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                            color: ColorCollection.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
