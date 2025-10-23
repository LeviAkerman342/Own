import 'package:Own/features/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();

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
              const Text('Создать аккаунт',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
              const SizedBox(height: 12),
              AuthTextField(
                hintText: 'Подтвердите пароль',
                obscureText: true,
                icon: Icons.lock_person_outlined,
                controller: confirmController,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF367DFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Зарегистрироваться',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('У меня уже есть аккаунт'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
