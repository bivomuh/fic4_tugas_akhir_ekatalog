import 'package:fic4_flutter_auth/bloc/register/register_bloc.dart';
import 'package:fic4_flutter_auth/data/models/request/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(
        title: const Text("bivoo"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Name"),
              controller: nameController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Email"),
              controller: emailController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final requestModel = RegisterModel(
                    name: nameController!.text,
                    email: emailController!.text,
                    password: passwordController!.text);

                context
                    .read<RegisterBloc>()
                    .add(SaveRegisterEvent(request: requestModel));
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
