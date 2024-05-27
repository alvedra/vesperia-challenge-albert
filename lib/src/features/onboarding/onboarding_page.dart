import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/widgets/dot_indicators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/onboard_content.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingPage> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 14,
              child: PageView.builder(
                controller: _pageController,
                itemCount: demoData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                  illustration: demoData[index]["illustration"],
                  title: demoData[index]["title"],
                  text: demoData[index]["text"],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                demoData.length,
                (index) => DotIndicator(isActive: index == currentPage),
              ),
            ),
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RouteName.login);
                    },
                    child: Text(
                        (currentPage != demoData.length - 1 ? "Skip" : "Finish")
                            .toUpperCase()),
                  ),
                ),
                currentPage != demoData.length - 1
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentPage++;
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  currentPage,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primary),
                          child: Text(
                            "Next".toUpperCase(),
                            style: const TextStyle(color: white),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> demoData = [
  {
    "illustration": "assets/images/onboarding_1.svg",
    "title": "All your favorites",
    "text":
        "Order from the best local restaurants \nwith easy, on-demand delivery.",
  },
  {
    "illustration": "assets/images/onboarding_2.svg",
    "title": "Free delivery offers",
    "text":
        "Free delivery for new customers via Apple Pay\nand others payment methods.",
  },
  {
    "illustration": "assets/images/onboarding_3.svg",
    "title": "Choose your food",
    "text":
        "Easily find your type of food craving and\nyou’ll get delivery in wide range.",
  },
];
