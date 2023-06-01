import 'package:fic4_flutter_auth/bloc/login/login_bloc.dart';
import 'package:fic4_flutter_auth/bloc/register/register_bloc.dart';
import 'package:fic4_flutter_auth/data/localsources/auth_local_storage.dart';
import 'package:fic4_flutter_auth/data/models/request/login_model.dart';
import 'package:fic4_flutter_auth/presentation/pages/home_page.dart';
import 'package:fic4_flutter_auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isLogin();
    Future.delayed(const Duration(seconds: 2));
    super.initState();
  }

  void isLogin() async {
    final isTokenExist = await AuthLocalStorage().isTokenExist();
    if (isTokenExist) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("bivoo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoaded) {
                  emailController!.clear();
                  passwordController!.clear();

                  // Navigasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.blueAccent,
                      content: Text('Success Login!'),
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                }
              },
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () {
                    final requestModel = LoginModel(
                        email: emailController!.text,
                        password: passwordController!.text);

                    context
                        .read<LoginBloc>()
                        .add(DoLoginEvent(loginModel: requestModel));
                  },
                  child: const Text('Login'),
                );
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ));
              },
              child: const Text('Belum punya akun? Daftar disini',
                  style: TextStyle(decoration: TextDecoration.underline)),
            )
          ],
        ),
      ),
    );
  }
}
