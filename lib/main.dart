import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/Services/store_repo.dart';
import 'package:project1/core/utils/themes.dart';
import 'package:project1/features/home/presentation/manager/cubit/search_cubit.dart';
import 'package:project1/features/home/presentation/manager/cubit/store_cubit.dart';

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
          BlocProvider(create: (context) => StoreCubit(ProductRepo())),
          BlocProvider(create: (context) => SearchCubit())
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
