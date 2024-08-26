//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/widget/screen/add_edit/add_editscreen.dart';
import 'package:fluttertest/widget/screen/detail/detailscreen.dart';
import 'package:fluttertest/widget/screen/list_item/list_item_cubit.dart';
import 'package:fluttertest/widget/screen/list_item/list_item_screen.dart';
import 'package:fluttertest/widget/screen/login/loginscreen.dart';
import 'package:fluttertest/widget/screen/menu/menuscreen.dart';

Route<dynamic>? mainRoute(RouteSettings settings) {
  switch (settings.name) {
    // case LoginScreen.route:
    //   return MaterialPageRoute(builder: (context) => LoginScreen());
    // case MenuScreen.route:
    //   return MaterialPageRoute(builder: (context) => MenuScreen());
    case ListItemScreen.route:
      return MaterialPageRoute(builder: (context) => ListItemScreen(), settings: RouteSettings(name: ListItemScreen.route));
    case DetailScreen.route:

      // Truyền Item từ ListItemScreen qua DetailScreen
      var cubit = (settings.arguments as Map<String, dynamic>)['cubit']
          as ListItemCubit;
      return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
                value: cubit,
                child: Scaffold(
                    appBar: AppBar(
                      title: Text("Detail"),
                    ),
                    body: DetailScreen()),
              ));
    //Truyền Item 
   case AddEditScreen.route:
  var cubit = (settings.arguments as Map<String, dynamic>) ['cubit'] as ListItemCubit;
  var isAddMode = (settings.arguments as Map<String, dynamic>)['isAddMode'] as bool; // Sửa 'issAddMode' thành 'isAddMode'
  return MaterialPageRoute(
    builder: (context) => BlocProvider.value(
      value: cubit,
      child: AddEditScreen(isAddMode, cubit.state.screenSize),
    ),
  );
      // case AddEditScreen.route:
      // return MaterialPageRoute(builder: (context) => AddEditScreen(is));
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
