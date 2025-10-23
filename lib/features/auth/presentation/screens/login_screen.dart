import 'package:Own/core/router/domain/app_routes.dart';
import 'package:Own/features/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 42,
                backgroundColor: Colors.white,
                child: Icon(Icons.savings, size: 40, color: Color(0xFF367DFF)),
              ),
              const SizedBox(height: 24),
              const Text(
                'СВОИ',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Добро пожаловать!',
                  style: TextStyle(fontSize: 16, color: Colors.black54)),

              const SizedBox(height: 24),
              AuthTextField(
                hintText: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
                controller: emailController,
              ),
              const SizedBox(height: 12),
              AuthTextField(
                hintText: 'Пароль',
                obscureText: true,
                icon: Icons.lock_outline,
                controller: passwordController,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Забыли пароль?'),
                ),
              ),

              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF367DFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Войти в аккаунт',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),

              const SizedBox(height: 16),
              const Text('или', style: TextStyle(color: Colors.black45)),
              const SizedBox(height: 12),

              _SocialButton(
                text: 'Продолжить с Google',
                icon: Icons.g_mobiledata,
                onTap: () {},
              ),
              const SizedBox(height: 8),
              _SocialButton(
                text: 'Войти с Apple ID',
                icon: Icons.apple,
                onTap: () {},
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.push(AppRoutes.register),
                child: const Text('У меня нет аккаунта'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
      ),
      icon: Icon(icon, color: Colors.black87),
      label: Text(text, style: const TextStyle(color: Colors.black87)),
    );
  }
}
