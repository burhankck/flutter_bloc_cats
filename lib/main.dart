import 'package:bloc_cats/cat_bloc/bloc_cats_view.dart';
import 'package:bloc_cats/cat_bloc/cats_cubit.dart';
import 'package:bloc_cats/cat_bloc/repository/cat.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Bloc Cats',
        home: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => CatsCubit(SampleCatsRepository()),
          ),
        ], child: BlocCatsView()));
  }
}
