import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:project1/features/home/presentation/manager/app%20cubit/app_cubit.dart';
import 'package:project1/features/home/presentation/views/search.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Stocky'),
            actions: [
              IconButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  },
                  icon: const Icon(IconlyBroken.search)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (index) {
                AppCubit.get(context).changeNav(index);
              },
              iconSize: 25,
              selectedItemColor: Colors.orange,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.home), label: "*"),
                BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.buy), label: "*"),
                BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.heart), label: "*"),
                BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.profile), label: "*"),
              ]),
          body:
              AppCubit.get(context).screen[AppCubit.get(context).currentIndex],
        );
      },
    );
  }
}
