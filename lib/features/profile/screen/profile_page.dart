import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:own/features/profile/bloc/profile_bloc.dart';
import 'package:own/features/profile/domain/repositories/profile_repository_impl.dart';
import '../widgets/profile_header.dart';
import '../widgets/subscription_card.dart';
import '../widgets/settings_section.dart';
import '../widgets/sign_out_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(ProfileRepositoryImpl()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFF),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Профиль / Настройки',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSignedOut) context.go('/login');
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // ProfileHeader(user: user),
                    const SizedBox(height: 24),
                    SubscriptionCard(user: user),
                    const SizedBox(height: 32),
                    SettingsSection(
                      isDarkMode: user.isDarkModeEnabled,
                      onDarkModeChanged: (v) =>
                          context.read<ProfileCubit>().toggleDarkMode(v),
                    ),
                    const SizedBox(height: 40),
                    SignOutButton(
                      onPressed: () => context.read<ProfileCubit>().signOut(),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }
            return const Center(child: Text('Ошибка загрузки'));
          },
        ),
      ),
    );
  }
}
