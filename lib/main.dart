import 'package:crud_bloc_app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Repo/api_service.dart';
import 'bloc/bloc/user_bloc_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UserBloc(UserService())), // ✅ Global Provider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserScreen(),
      ),
    );
  }
}
