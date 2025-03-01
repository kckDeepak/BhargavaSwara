import 'dart:math';
import 'package:flutter/material.dart';
import 'raga_recognition_screen.dart';
import 'compose_music_screen.dart';
import 'learn_ragas_screen.dart';
import 'collaborate_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bhargava Swara'),
        backgroundColor: Colors.deepOrange,
      ),
      body: const Center(
        child: FloatingPentagonMenu(),
      ),
    );
  }
}

/// This widget builds a menu with a musical note icon at the center and five
/// animated, levitating buttons arranged along the vertices of a pentagon.
class FloatingPentagonMenu extends StatelessWidget {
  const FloatingPentagonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Overall size of the menu area.
    const double size = 350;
    final double center = size / 2;
    // Radius to position each button.
    final double orbitRadius = size * 0.38;

    // Data for the five buttons.
    final List<_PentagonButtonData> buttons = [
      _PentagonButtonData(
        title: 'Real-Time Raga Recognition',
        icon: Icons.mic,
        screen: const RagaRecognitionScreen(),
      ),
      _PentagonButtonData(
        title: 'Compose New Music',
        icon: Icons.create,
        screen: const ComposeMusicScreen(),
      ),
      _PentagonButtonData(
        title: 'Learn Ragas',
        icon: Icons.school,
        screen: LearnRagasScreen(),
      ),
      _PentagonButtonData(
        title: 'Collaborate with Others',
        icon: Icons.group,
        screen: const CollaborateScreen(),
      ),
      _PentagonButtonData(
        title: 'Profile & History',
        icon: Icons.person,
        screen: const ProfileScreen(),
      ),
    ];

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center musical note icon.
          const Icon(Icons.music_note, size: 64, color: Colors.deepOrange),
          // Place each button along the pentagon's vertices.
          ...List.generate(5, (index) {
            // Calculate the position using polar coordinates.
            double angle = (-pi / 2) + (2 * pi * index / 5);
            double x = center + orbitRadius * cos(angle) - 30; // Adjust for button size.
            double y = center + orbitRadius * sin(angle) - 30;
            return Positioned(
              left: x,
              top: y,
              child: AnimatedFloatingButton(
                icon: buttons[index].icon,
                title: buttons[index].title,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => buttons[index].screen,
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Data class for each button in the menu.
class _PentagonButtonData {
  final String title;
  final IconData icon;
  final Widget screen;

  _PentagonButtonData({
    required this.title,
    required this.icon,
    required this.screen,
  });
}

/// A custom widget that shows an animated floating button with a pulse effect
/// on tap and a continuous levitating (floating) effect.
class AnimatedFloatingButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AnimatedFloatingButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _levitateController;
  late Animation<double> _levitateAnimation;

  @override
  void initState() {
    super.initState();
    // Pulse animation when the button is tapped.
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );
    _pulseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulseController.reverse();
      }
    });

    // Levitating effect: a subtle up and down motion.
    _levitateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _levitateAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _levitateController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _levitateController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _pulseController.forward();
    // Delay navigation slightly to allow the pulse animation to play.
    Future.delayed(const Duration(milliseconds: 150), widget.onTap);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _levitateAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _levitateAnimation.value),
            child: child,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _pulseAnimation,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.deepOrange,
                onPressed: _handleTap,
                child: Icon(widget.icon, color: Colors.white),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 80,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
