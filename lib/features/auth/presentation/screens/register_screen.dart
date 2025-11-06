import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/core/theme/model/color_collection.dart';
import 'package:own/features/auth/widgets/auth_text_field.dart';
import 'package:own/features/auth/widgets/register_button.dart';

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
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Иконка и надпись
                    Column(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1F3558),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.savings_outlined,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "СВОИ",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                            color: Color(0xFF1F3558),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Присоединяйся к сообществу!",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    /// E-mail
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
                          color: const Color.fromARGB(255, 232, 230, 230),
                        ),
                        onPressed: () => setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Подтверждение пароля
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

                    /// Кнопка регистрации
                    SizedBox(
                      height: 48,

                      child: _isLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                // color: Colors.white,
                              ),
                            )
                          : RegisterButton(
                              text: 'Создать аккаунт',
                              onPressed: () {
                                _isLoading ? null : _register;
                              },
                            ),
                    ),

                    const SizedBox(height: 20),

                    /// Или
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "или",
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// Google
                    _buildSocialButton(
                      icon: Icons.g_mobiledata_rounded,
                      text: "Продолжить с Google",
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),

                    /// Apple
                    _buildSocialButton(
                      icon: Icons.apple,
                      text: "Продолжить с Apple ID",
                      onTap: () {},
                    ),

                    const SizedBox(height: 16),

                    /// Уже есть аккаунт
                    Center(
                      child: GestureDetector(
                        onTap: () => context.go(AppRoutes.login),
                        child: const Text(
                          "Уже есть аккаунт? Войти",
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.black, size: 24),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.grey, width: 0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
