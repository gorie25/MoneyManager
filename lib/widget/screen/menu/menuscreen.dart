  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:fluttertest/cubit/main_cubit.dart';
  import 'package:fluttertest/enum/drawer_item.dart';

  class MenuScreen extends StatelessWidget {
    static const String route = "MenuScreen";

    @override
    Widget build(BuildContext context) {
      return Page(route: route);
    }
  }

  class Page extends StatelessWidget {
    const Page({
      super.key,
      required this.route,
    });

    final String route;

    @override
    Widget build(BuildContext context) {
      return BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Material(
            child: Container(
                child: Column(
              children: [
                ListTile(
                  title: Text("Home"),
                  trailing: //state.selected == DrawerItem.Home
                      Icon(Icons.home),
                  
                  onTap: () =>
                      context.read<MainCubit>().setSelected(DrawerItem.Home),
                ),
                ListTile(
                  title: Text("Setting"),
                  trailing:// state.selected != DrawerItem.Setting
                      Icon(Icons.settings),
                      
                  onTap: () =>
                      context.read<MainCubit>().setSelected(DrawerItem.Setting),
                )
              ],
            )),
          );
        },
      );
    }
  }
