import 'package:flutter/material.dart';
import 'package:myapp/features/onboarding/widgets/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final pages = [
      const OnboardingPage(
        imageUrl:
            'https://cdn-icons-png.flaticon.com/512/8189/8189783.png',
        title: 'Welcome to Family Notes',
        description:
            'Keep your family organized and connected with shared notes and reminders.',
      ),
      const OnboardingPage(
        imageUrl:
            'https://cdn-icons-png.flaticon.com/512/3313/3313888.png',
        title: 'Share Tasks Easily',
        description:
            'Assign chores, plan meals, or manage events together effortlessly.',
      ),
      const OnboardingPage(
        imageUrl:
            'https://cdn-icons-png.flaticon.com/512/4160/4160750.png',
        title: 'Stay in Sync',
        description:
            'All updates appear instantly for everyone in the family group.',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: pages,
              ),
            ),
            const SizedBox(height: 16),
            SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.indigo,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: () {
                  if (controller.page == pages.length - 1) {
                    // TODO: Navigate to home/login screen
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Next'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
