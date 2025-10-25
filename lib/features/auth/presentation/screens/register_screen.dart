import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/core/theme/model/color_collection.dart';
import 'package:own/features/auth/widgets/auth_button.dart';
import 'package:own/features/auth/widgets/auth_header.dart';
import 'package:own/features/auth/widgets/auth_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // имитация API
    setState(() => _isLoading = false);

    if (!mounted) return;
    context.go(AppRoutes.login);
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ColorCollection.gray800,
                      ),
                      onPressed: () => context.go(AppRoutes.login),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const AuthHeader(
                    title: 'Создай аккаунт',
                    subtitle: 'Присоединяйся к сообществу!',
                    center: true,
                  ),

                  const SizedBox(height: 8),
                 
                  const SizedBox(height: 40),

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
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Подтвердите пароль',
                    icon: Icons.lock_person_outlined,
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Пароли не совпадают';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),

                  AuthButton(
                    text: 'Зарегистрироваться',
                    isLoading: _isLoading,
                    onPressed: _register,
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Уже есть аккаунт?',
                        style: TextStyle(color: ColorCollection.gray700),
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRoutes.login),
                        child: const Text(
                          'Войти',
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
