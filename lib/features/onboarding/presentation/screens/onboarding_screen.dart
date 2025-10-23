import 'package:Own/features/auth/presentation/screens/login_screen.dart';
import 'package:Own/features/onboarding/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(viewportFraction: 0.88);
  double _currentPage = 0.0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/onb1.png',
      'title': 'ВСЯ СЕМЬЯ В КУРСЕ',
      'desc':
          'Простой учёт общих расходов\nПриватные комнаты для группы\nНаглядная аналитика и бюджет\nФото чеков и быстрых вводов',
      'btn': 'Начать контролировать',
    },
    {
      'image': 'assets/images/onb2.png',
      'title': 'ПРИВАТНЫЕ КОМНАТЫ ДЛЯ ВСЕХ',
      'desc':
          'Создайте группы для семьи и друзей\nОтдельный учёт для общих трат\nТолько по приглашению и с общим доступом',
      'btn': 'Продолжить',
    },
    {
      'image': 'assets/images/onb3.png',
      'title': 'ЯСНАЯ АНАЛИТИКА И БЮДЖЕТ',
      'desc':
          'Узнайте, куда уходят деньги\nСтавьте цели и следите за прогрессом\nПолучайте умные отчёты',
      'btn': 'Начать пользоваться',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0;
      });
    });
  }

  void _onNextPressed() {
    if (_currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    } else {
       Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                final scale =
                    (1 - ((_currentPage - index).abs() * 0.1)).clamp(0.9, 1.0);
                final opacity =
                    (1 - ((_currentPage - index).abs() * 0.4)).clamp(0.0, 1.0);

                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity,
                        child: child,
                      ),
                    );
                  },
                  child: OnboardingPage(
                    imageAsset: pages[index]['image']!,
                    title: pages[index]['title']!,
                    description: pages[index]['desc']!,
                    buttonText: pages[index]['btn']!,
                    onPressed: _onNextPressed,
                  ),
                );
              },
            ),
            Positioned(
              bottom: 30,
              child: SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.white38,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
