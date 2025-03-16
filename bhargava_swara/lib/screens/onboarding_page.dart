import '../home_screen_c.dart';
import 'package:flutter/material.dart';

class OnboardingPageModel {
  final String title;
  final String description;
  final String image;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.image,
    this.bgColor = Colors.blue,
    this.textColor = Colors.white,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: "Bhargava Swara",
      description: "Analysis and Synthesis of Indian Classical Music",
      image: "../../assets/images/bhargava_swara_logo.jpg",
      bgColor: Colors.deepPurple,
    ),
    OnboardingPageModel(
      title: "Learn by Analyzing",
      description: "Understand music by breaking it down note by note.",
      image: "assets/images/music_analysis_logo.jpg",
      bgColor: Colors.blueAccent,
    ),
    OnboardingPageModel(
      title: "Create Your Own Music",
      description: "Have fun experimenting and composing new melodies.",
      image: "assets/images/music_synthesis_logo.jpg",
      bgColor: Colors.teal,
    ),
    OnboardingPageModel(
      title: "Follow & Explore",
      description: "Follow creators and discover amazing compositions.",
      image: "assets/images/follow_us_logo.png",
      bgColor: Colors.orangeAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(item.image),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  item.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pages.map((item) {
                  int index = pages.indexOf(item);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _currentPage == index ? 20 : 6,
                    height: 6,
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  );
                }).toList(),
              ),

              // Navigation Buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_currentPage == pages.length - 1) {
                          // Handle finish action
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut);
                        }
                      },
                      child: Text(
                        _currentPage == pages.length - 1 ? "Finish" : "Next",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
