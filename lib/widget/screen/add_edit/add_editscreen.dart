import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/enum/screen_size.dart';
import 'package:fluttertest/enum/ultis.dart';
import 'package:fluttertest/models/transcaction.dart';
import 'package:fluttertest/widget/screen/list_item/list_item_cubit.dart';
import 'package:fluttertest/widget/screen/list_item/list_item_screen.dart';

class AddEditScreen extends StatelessWidget {
  static const String route = "AddEditScreen";
  final bool isAddMode;
  final ScreenSize oldScreenSize;
  ScreenSize newScreenSize = ScreenSize.Small;
  AddEditScreen(this.isAddMode, this.oldScreenSize);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAddMode ? "Add" : "Edit"),
      ),
      body: BlocBuilder<ListItemCubit, ListItemState>(
        builder: (context, state) {
          var _title = TextEditingController(text: "");
          var _content = TextEditingController(text: "");
          var _amount = TextEditingController(text: "");
          var _cubit = context.read<ListItemCubit>();

          if (isAddMode == false) {
            _title.text = state.trans[state.selectedIdx].title;
            _content.text = state.trans[state.selectedIdx].content;
            _amount.text = state.trans[state.selectedIdx].amount.toString();
          }
          newScreenSize = calculateScreenSize(MediaQuery.sizeOf(context).width);
          return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(controller: _title),
                  SizedBox(height: 16),
                  TextField(controller: _content),
                  SizedBox(height: 16),
                  TextField(controller: _amount),
                  SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        if (!isAddMode) {
                          _cubit.editItem(Transcaction(
                              dateTime: state.trans[state.selectedIdx].dateTime,
                              title: _title.text,
                              content: _content.text,
                              amount: double.parse(_amount.text)));
                          pop(context);
                        } else {
                          _cubit.addItem(Transcaction(
                              dateTime: DateTime.now().toString().substring(0,19),
                              title: _title.text,
                              content: _content.text,
                              amount: double.parse(_amount.text)));
                              pop(context);
                        }
                      },
                      child: Text("Save")),
                ],
              ));
        },
      ),
    );
  }

  void pop(BuildContext context) {
    if (oldScreenSize == newScreenSize)
      Navigator.of(context).pop();
    else
      Navigator.of(context).popUntil(ModalRoute.withName(ListItemScreen.route));
  }
}
