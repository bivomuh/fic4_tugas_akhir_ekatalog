import 'package:fic4_flutter_auth/data/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      if (token != null) {
        Navigator.pushNamed(context, '/screen');
      } else {
        Navigator.pushNamed(context, '/login');
      }
    });

    return Scaffold(
      // backgroundColor: kPrimaryColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 60, 180, 142),
              Color.fromARGB(255, 13, 165, 207)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            const SizedBox(width: 5),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dashboard, size: 35, color: kWhiteColor),
                  const SizedBox(width: 5),
                  Text('PLATZI store fake app',
                      style: whiteTextStyle.copyWith(
                          fontSize: 28, fontWeight: bold)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Created with ',
                        style: whiteTextStyle.copyWith(
                            fontSize: 10, fontWeight: regular)),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.all_inclusive_rounded,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 2),
                    Text('by Bivo Muhandeza',
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
