// big thanks to -> https://github.com/pajrialzukri

import 'package:fic4_flutter_auth/bloc/login/login_bloc.dart';
import 'package:fic4_flutter_auth/bloc/product/create_product/create_product_bloc.dart';
import 'package:fic4_flutter_auth/bloc/product/delete_product/delete_product_bloc.dart';
import 'package:fic4_flutter_auth/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:fic4_flutter_auth/bloc/product/update_product/update_product_bloc.dart';
import 'package:fic4_flutter_auth/bloc/profile/profile_bloc.dart';
import 'package:fic4_flutter_auth/data/datasources/auth_datasources.dart';
import 'package:fic4_flutter_auth/data/datasources/product_datasources.dart';
import 'package:fic4_flutter_auth/data/shared/theme.dart';
import 'package:fic4_flutter_auth/presentation/pages/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => CreateProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => GetAllProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => UpdateProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => DeleteProductBloc(ProductDatasources()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: kMainColor,
          ),
          useMaterial3: true,
        ),
        routes: appRoutes,
        initialRoute: '/',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
