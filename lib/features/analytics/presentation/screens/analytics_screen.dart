import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int selectedCategory = 0;
  bool isLoading = true;

  final categories = ["Все", "Работа", "Учёба", "Спорт"];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BACK BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.3),
            ),

            // TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Аналитика",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

            const SizedBox(height: 20),

            // CATEGORY FILTER
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (_, index) {
                  final isSelected = index == selectedCategory;
                  final label = categories[index];

                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.3),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemCount: categories.length,
              ),
            ),

            const SizedBox(height: 20),

            // CONTENT
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: isLoading ? _buildSkeletonList() : _buildAnalyticsList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (_, i) {
        return Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(16),
              ),
            )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .fade(begin: 0.3, end: 0.6)
            .scale(begin: const Offset(1, 1), end: const Offset(1.02, 1.02));
      },
    );
  }

  Widget _buildAnalyticsList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, i) {
        return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Категория",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Название заметки",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.bar_chart, color: Colors.white, size: 30),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 300.ms, delay: (i * 80).ms)
            .slideY(begin: 0.3);
      },
    );
  }
}
