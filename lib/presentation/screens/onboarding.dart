import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_weather/core/ui/widgets/general_button.dart';
import 'package:material_weather/core/ui/widgets/perm_button.dart';
import 'package:material_weather/core/utils/getit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    if (serviceLocator.get<SharedPreferences>().getBool("firstLaunch") ==
        false) {
      context.pushReplacementNamed("home");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Welcome",
              style: GoogleFonts.delius().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 54,
              ),
            ),
            Column(
              children: [
                if (serviceLocator.get<SharedPreferences>().getBool(
                      "firstLaunch",
                    ) ==
                    true)
                  Text(
                    "Please allow location access",
                    style: GoogleFonts.delius().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                if (serviceLocator.get<SharedPreferences>().getBool(
                      "firstLaunch",
                    ) ==
                    true)
                  PermissionButton(
                    onClick: () {
                      if (!serviceLocator.get<SharedPreferences>().getBool(
                        "firstLaunch",
                      )!) {
                        context.pushReplacementNamed("home");
                      }
                      Permission.location.request();
                      serviceLocator.get<SharedPreferences>().setBool(
                        "firstLaunch",
                        false,
                      );
                      setState(() {});
                    },
                  ),
                const SizedBox(height: 0),
                if (serviceLocator.get<SharedPreferences>().getBool(
                      "firstLaunch",
                    ) ==
                    false)
                  GeneralButton(
                    title: "Ready? Lets Begin",
                    onClick: () {
                      context.pushReplacementNamed("home");
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
