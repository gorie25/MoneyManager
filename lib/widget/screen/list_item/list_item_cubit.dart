import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertest/enum/load_status.dart';
import 'package:fluttertest/enum/screen_size.dart';
import 'package:fluttertest/models/transcaction.dart';
import 'package:fluttertest/repositories/api.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
// list_item_cubit.dart and list_item_screen.dart
part 'cubit/list_item_state.dart';

class ListItemCubit extends Cubit<ListItemState> {
  Api api;
  ListItemCubit(this.api) : super(ListItemState.init());

  loadData(int monthIdx) async {
    emit(state.copyWith(
        loadStatus: LoadStatus.Loading, selectedMonth: monthIdx));
    try {
      var months = await api.getMonth();
      emit(state.copyWith(months: months));
      var total = await api.getTotal();

      emit(state.copyWith(total: total));

      List<Transcaction> trans = months.isEmpty
          ? []
          : await api.getTransaction(
              state.months[state.selectedMonth],
            );
      emit(state.copyWith(trans: trans, loadStatus: LoadStatus.Done));
    } catch (ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }

  Future<void> deleteItem(String dateTime) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    try {
      await api.deleteTransaction(dateTime);
      await loadData(state.selectedMonth);
    } catch (ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }

  
  }
    Future<void> addItem(Transcaction transcaction) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    try {
      await api.addTransaction(transcaction);
      await loadData(state.selectedMonth);
    } catch (ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }

  
  }
    Future<void> editItem(Transcaction transcaction) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    try {
      await api.editTransaction(transcaction);
      await loadData(state.selectedMonth);
    } catch (ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }

  
  }

void  setScreenSize(ScreenSize screenSize)
  {
     emit(state.copyWith(screenSize: screenSize));
  }

  void  setSelectedIndex(int selectedIdx)
  {
     emit(state.copyWith(selectedIdx: selectedIdx));
  }
}

