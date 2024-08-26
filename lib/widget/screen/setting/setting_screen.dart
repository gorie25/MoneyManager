import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/main_cubit.dart';

class SettingScreen extends StatelessWidget {
  static const String route = "SettingScreen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        var isLightTheme = state.isLightTheme;
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("Light Theme"),
                value: isLightTheme,
                onChanged: (value) {
                  context.read<MainCubit>().setTheme(value ?? true);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
