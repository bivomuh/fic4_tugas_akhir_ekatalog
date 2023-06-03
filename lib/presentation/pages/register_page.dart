import 'package:fic4_flutter_auth/bloc/register/register_bloc.dart';
import 'package:fic4_flutter_auth/data/models/request/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/shared/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenColor,
      resizeToAvoidBottomInset: false, // Prev
      body: Stack(children: [
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
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 180),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Register',
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
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
                controller: nameController,
              ),
              const SizedBox(height: 18),
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
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterLoaded) {
                    nameController!.clear();
                    emailController!.clear();
                    passwordController!.clear();

                    // Navigasi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.amber,
                        content: Text(
                            'Success Register with id : ${state.model.id}'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    onPressed: () {
                      final requestModel = RegisterModel(
                          name: nameController!.text,
                          email: emailController!.text,
                          password: passwordController!.text);

                      context
                          .read<RegisterBloc>()
                          .add(SaveRegisterEvent(request: requestModel));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shadowColor: Colors.grey.withOpacity(0.4),
                        backgroundColor: kGreenColor.withOpacity(0.7)),
                    child: Text(
                      'Register',
                      style: whiteTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16, letterSpacing: 1),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text('Sudah punya akun? Masuk disini',
                    style: greyTextStyle.copyWith(
                        decoration: TextDecoration.underline)),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
