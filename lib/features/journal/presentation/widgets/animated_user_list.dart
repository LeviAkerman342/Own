import 'package:flutter/material.dart';
import 'package:own/features/journal/data/models/user_model.dart';
import 'user_card.dart';

class AnimatedUserList extends StatefulWidget {
  final List<UserModel> users;

  const AnimatedUserList({super.key, required this.users});

  @override
  State<AnimatedUserList> createState() => _AnimatedUserListState();
}

class _AnimatedUserListState extends State<AnimatedUserList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<Offset>> _slideAnimations = [];
  final List<Animation<double>> _fadeAnimations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // создаём для каждой карточки отдельную анимацию с задержкой
    for (int i = 0; i < widget.users.length; i++) {
      final start = i * 0.1;
      final end = start + 0.6;
      _slideAnimations.add(Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      )));

      _fadeAnimations.add(CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeIn),
      ));
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const ValueKey('userList'),
      padding: const EdgeInsets.all(16),
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        final user = widget.users[index];
        return FadeTransition(
          opacity: _fadeAnimations[index],
          child: SlideTransition(
            position: _slideAnimations[index],
            child: UserCard(user: user),
          ),
        );
      },
    );
  }
}
