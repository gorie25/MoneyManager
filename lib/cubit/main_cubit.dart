import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fluttertest/enum/drawer_item.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.init());

  void setSelected(DrawerItem selected) {
    emit(state.copyWith(selected: selected));
  }

  void setTheme(bool isLightTheme) {
    emit(state.copyWith(isLightTheme: isLightTheme));
  }
}