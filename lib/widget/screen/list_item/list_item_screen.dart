import 'dart:js_interop_unsafe';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/main_cubit.dart';
import 'package:fluttertest/enum/drawer_item.dart';
import 'package:fluttertest/enum/load_status.dart';
import 'package:fluttertest/enum/screen_size.dart';
import 'package:fluttertest/enum/ultis.dart';
import 'package:fluttertest/repositories/api.dart';
import 'package:fluttertest/widget/commonwidget/noti_bar.dart';
import 'package:fluttertest/widget/screen/add_edit/add_editscreen.dart';
import 'package:fluttertest/widget/screen/detail/detailscreen.dart';
import 'package:fluttertest/widget/screen/list_item/list_item_cubit.dart';
import 'package:fluttertest/widget/screen/menu/menuscreen.dart';
import 'package:fluttertest/widget/screen/setting/setting_screen.dart';

// list_item_cubit.dart and list_item_screen.dart
// import 'ffi_stub.dart'
//     if (dart.library.ffi) 'dart:ffi';
class ListItemScreen extends StatelessWidget {
  static const String route = "ListItemScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListItemCubit(context.read<Api>())..loadData(0),
      child: Page(),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Money Manager"),
          ),
          body: Body(),
          drawer: state.screenSize == ScreenSize.Large
              ? null
              : Drawer(child: MenuScreen()),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  var cubit = context.read<ListItemCubit>();
                  Navigator.of(context).pushNamed(AddEditScreen.route, arguments: {
                    'cubit': cubit,
                    'isAddMode': true
                  });
                },
                child: Icon(Icons.add),
              ),
        );
      },
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (contextMain, stateMain) {
        return BlocConsumer<ListItemCubit, ListItemState>(
          listener: (context, state) {
            if (state.loadStatus == LoadStatus.Error)
              ScaffoldMessenger.of(context)
                  .showSnackBar(notiBar("Login Error", true));
          },
          builder: (context, state) {
            var screenSize =
                calculateScreenSize(MediaQuery.sizeOf(context).width);
            context.read<ListItemCubit>().setScreenSize(screenSize);
            return state.loadStatus == LoadStatus.Loading
                ? Center(child: CircularProgressIndicator())
                : stateMain.selected == DrawerItem.Setting &&
                        state.screenSize != ScreenSize.Large
                    ? SettingScreen()
                    : switch (state.screenSize) {
                        ScreenSize.Small => ListItemPage(),
                        ScreenSize.Medium => ListItemEditPage(),
                        _ => ListItemEditMenuPage()
                      };
          },
        );
      },
    );
  }
}

class ListItemPage extends StatelessWidget {
  const ListItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        var cubit = context.read<ListItemCubit>();
        return Container(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(child: Text("Total: ${state.total}")),
                  state.months.length > 0 &&
                          state.selectedMonth == 0 &&
                          state.selectedMonth < state.months.length
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            cubit.loadData(state.selectedMonth - 1);
                          },
                          icon: Icon(Icons.navigate_before),
                        ),
                  state.months.length > 0 &&
                          state.selectedMonth >= 0 &&
                          state.selectedMonth < state.months.length
                      ? Text(
                          "${state.months[state.selectedMonth].substring(0, 7)}")
                      : Container(),
                  state.months.length > 0 &&
                          state.selectedMonth >= 0 &&
                          state.selectedMonth == state.months.length
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            cubit.loadData(state.selectedMonth + 1);
                          },
                          icon: Icon(Icons.navigate_next),
                        ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var item = state.trans[index];
                  var cubit = context.read<ListItfluemCubit>();
                  return Card(
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: ListTile(
                      leading: item.amount > 0
                          ? Icon(Icons.add, color: Colors.green)
                          : Icon(Icons.remove, color: Colors.red),
                      title: Row(
                        children: [
                          Expanded(child: Text("${item.title}")),
                          Text("${item.amount}")
                        ],
                      ),
                      subtitle: Text(item.content),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cubit.deleteItem(item.dateTime);
                        },
                      ),
                      onTap: () {
                        cubit.setSelectedIndex(index);
                        if (state.screenSize == ScreenSize.Small)
                          Navigator.of(context).pushNamed(DetailScreen.route,
                              arguments: {'cubit': cubit});
                      },
                    ),
                  );
                },
                itemCount: state.trans.length,
              ),
            ),
          ],
        ));
      },
    );
  }
}

class ListItemEditPage extends StatelessWidget {
  const ListItemEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ListItemPage()),
        Expanded(child: DetailScreen()),
      ],
    );
  }
}

class ListItemEditMenuPage extends StatelessWidget {
  const ListItemEditMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return state.selected == DrawerItem.Home
            ? Row(
                children: [
                  Expanded(child: MenuScreen()),
                  Expanded(child: ListItemPage()),
                  Expanded(child: DetailScreen()),
                ],
              )
            : Row(
                children: [
                  Expanded(child: MenuScreen()),
                  Expanded(
                    child: SettingScreen(),
                    flex: 2,
                  ),
                ],
              );
      },
    );
  }
}
