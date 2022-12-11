import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'features/feature_weather/presentation/bloc/home_bloc.dart';
import 'locator.dart';

void main() async {
  //! Dependency injection with get_it - init locator
  await setup();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => locator<HomeBloc>(),
          ),
        ],
        child: const MainWrapper(),
      ),
    ),
  );
}
