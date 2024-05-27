import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/widgets/gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? initScreen = prefs.getInt("initScreen");

      if (initScreen == null) {
        await prefs.setInt("initScreen", 1);
        Get.offAllNamed(RouteName.onboarding);
      } else {
        Get.offAllNamed(RouteName.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      colors: const [primary, Colors.white],
      child: Column(
        children: [
          Expanded(child: Image.asset('assets/icons/icon_app.png')),
          const Text(
            'Ver: 18.1.20',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
