import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/core/utils/themes.dart';

import 'Services/api_con.dart';
import 'core/utils/app_routes.dart';
import 'features/home/presentation/manager/app cubit/app_cubit.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: Style.lightTheme,
          themeMode: ThemeMode.light,
          routerConfig: AppRoutes.router,
        ),
      ),
    );
  }
}
