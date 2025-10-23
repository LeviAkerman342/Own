import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/theme/model/color_collection.dart';
import 'package:own/features/auth/widgets/auth_button.dart';
import 'package:own/features/auth/widgets/auth_text_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollection.textDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Регистрация",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              AuthTextField(hint: 'Email', controller: emailController),
              const SizedBox(height: 16),
              AuthTextField(
                hint: 'Пароль',
                obscure: true,
                controller: passwordController,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                hint: 'Подтвердите пароль',
                obscure: true,
                controller: confirmController,
              ),
              const SizedBox(height: 32),
              AuthButton(
                text: 'Зарегистрироваться',
                onPressed: () {
                  // context.go(AppRoutes.main);
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Уже есть аккаунт? Войти"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
