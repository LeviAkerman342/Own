import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/core/theme/model/color_collection.dart';
import 'package:own/features/auth/widgets/auth_button.dart';
import 'package:own/features/auth/widgets/auth_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                "Вход",
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
              const SizedBox(height: 32),
              AuthButton(
                text: 'Войти',
                onPressed: () {
                  context.go(AppRoutes.main);
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.push(AppRoutes.register);
                  },
                  child: const Text("Нет аккаунта? Зарегистрироваться"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
