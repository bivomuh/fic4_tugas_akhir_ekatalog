import 'package:fic4_flutter_auth/bloc/login/login_bloc.dart';
import 'package:fic4_flutter_auth/bloc/register/register_bloc.dart';
import 'package:fic4_flutter_auth/data/models/request/login_model.dart';
import 'package:fic4_flutter_auth/data/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

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
    super.initState();
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
      resizeToAvoidBottomInset: false, // Prev
      body: Stack(
        children: [
          //! Judul
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 275,
              decoration: BoxDecoration(color: kGreenColor.withOpacity(0.9)),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Icon(
                    Icons.dashboard,
                    color: kWhiteColor,
                    size: 30,
                  ),
                  Text(
                    'PLATZI',
                    style: whiteTextStyle.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 5,
                      shadows: [
                        Shadow(
                          offset: const Offset(0.5, 0.5),
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // !Background
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 700,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: kBlackColor,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: kWhiteColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(28))),
            ),
          ),
          //! Content: Main
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 180),
                // Login Text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Login',
                        style: greenTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: bold,
                          shadows: [
                            Shadow(
                              offset: const Offset(0.5, 0.5),
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(height: 20),

                //! Textfield for Email
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                  controller: emailController,
                ),
                const SizedBox(height: 18),
                //! Textfield for Name
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 24),

                // !Login Button
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Login gagal: Email atau password salah'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (state is LoginLoaded) {
                      emailController!.clear();
                      passwordController!.clear();

                      // Navigasi
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.blueAccent,
                          content: Text('Success Login!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushNamed(context, '/screen');
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
                          password: passwordController!.text,
                        );
                        context
                            .read<LoginBloc>()
                            .add(DoLoginEvent(loginModel: requestModel));

                        // final requestModel = LoginModel(
                        //     email: emailController!.text,
                        //     password: passwordController!.text);

                        // context
                        //     .read<LoginBloc>()
                        //     .add(DoLoginEvent(loginModel: requestModel));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shadowColor: Colors.grey.withOpacity(0.4),
                          backgroundColor: kGreenColor.withOpacity(0.7)),
                      child: Text(
                        'Login',
                        style: whiteTextStyle.copyWith(
                            fontWeight: bold, fontSize: 16, letterSpacing: 1),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text('Belum punya akun? Daftar disini',
                      style: greyTextStyle.copyWith(
                          decoration: TextDecoration.underline)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
