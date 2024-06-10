import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/age_prediction_bloc.dart';
import 'repositories/agify_repository.dart';
import 'screens/age_prediction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agify Demo NEON',
      home: BlocProvider(
        create: (_) => AgePredictionBloc(AgifyRepository()),
        child: const AgePredictionScreen(),
      ),
    );
  }
}