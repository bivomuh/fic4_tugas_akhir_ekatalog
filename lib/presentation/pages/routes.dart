import 'package:fic4_flutter_auth/presentation/pages/profile_page.dart';
import 'package:fic4_flutter_auth/presentation/pages/register_page.dart';
import 'package:fic4_flutter_auth/presentation/pages/screen_page.dart';
import 'package:fic4_flutter_auth/presentation/pages/splash_screen.dart';
import 'package:flutter/widgets.dart';

import 'home_page.dart';
import 'info_page.dart';
import 'login_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (_) => const LoginPage(),
  '/register': (_) => const RegisterPage(),
  '/home': (_) => const HomePage(),
  '/': (_) => const SplashScreen(),
  '/info': (_) => InfoPage(),
  '/profile': (_) => const ProfilePage(),
  '/screen': (_) => const ScreenPage(),
};
