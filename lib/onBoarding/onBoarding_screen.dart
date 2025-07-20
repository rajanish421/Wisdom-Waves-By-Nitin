import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/features/publics/screens/home_screen.dart';
import 'onBoarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() => isLastPage = index == 2);
              },
              children: const [
                OnboardPage(
                  imagePath: 'assets/images/1.jpg',
                  title: 'Learn Smarter, Not Harder',
                  subtitle: 'Master every concept at your own pace — from anywhere, anytime.',
                ),
                OnboardPage(
                  imagePath: 'assets/images/2.png',
                  title: 'See Your Growth in Real-Time',
                  subtitle: 'Analyze your strengths, fix weak points, and keep leveling up.',
                ),
                OnboardPage(
                  imagePath: 'assets/images/3.png',
                  title: 'Mentors Who Truly Care',
                  subtitle: "Wisdom begins with action --- Let's get started!",
                ),
              ],
            ),
            // Bottom controls
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: Color(0xFF1E3A8A),
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeScreen()),
                          );
                        },
                        child: const Text("Skip"),
                      ),

                      // Next / Get Started
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonPrimaryColor
                        ),
                        onPressed: () {
                          if (isLastPage) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                          } else {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(isLastPage ? "Get Started" : "Next"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
