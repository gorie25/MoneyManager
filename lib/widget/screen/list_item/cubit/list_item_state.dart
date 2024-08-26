// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../list_item_cubit.dart';

//import 'dart:convert';

class ListItemState {
  final List<Transcaction> trans;
  final List<String> months;
  final int selectedIdx;
  final int selectedMonth;
  final double total;
  final LoadStatus loadStatus;
  final ScreenSize screenSize;
  ListItemState({
      required this.trans,
      required this.months,
      required this.selectedIdx,
      required this.selectedMonth,
      required this.total,
      required this.loadStatus,
      required this.screenSize,
    });
  
  ListItemState.init({
    this.trans = const [],
    this.months = const [],
    this.selectedIdx = -1,
    this.selectedMonth = 0,
    this.total = 0,
    this.loadStatus = LoadStatus.Init,
    this.screenSize= ScreenSize.Small
  });


  ListItemState copyWith({
    List<Transcaction>? trans,
    List<String>? months,
    int? selectedIdx,
    int? selectedMonth,
    double? total,
    LoadStatus? loadStatus,
    ScreenSize? screenSize,
  }) {
    return ListItemState(
      trans: trans ?? this.trans,
      months: months ?? this.months,
      selectedIdx: selectedIdx ?? this.selectedIdx,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      total: total ?? this.total,
      loadStatus: loadStatus ?? this.loadStatus,
      screenSize: screenSize ?? this.screenSize,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trans': trans.map((x) => x.toMap()).toList(),
      'months': months,
      'selectedIdx': selectedIdx,
      'selectedMonth': selectedMonth,
      'total': total,
      'loadStatus': loadStatus,
      'screenSize': screenSize,
    };
  }

  factory ListItemState.fromMap(Map<String, dynamic> map) {
    return ListItemState(
       trans: map['trans'] as List<Transcaction>,
       months: map['months'] as List<String>,
      selectedIdx: map['selectedIdx'] as int,
      selectedMonth: map['selectedMonth'] as int,
      total: map['total'] as double,
      loadStatus: map['loadStatus'] as LoadStatus,
      screenSize: map['screenSize'] as ScreenSize,  );
  }

  String toJson() => json.encode(toMap());

  factory ListItemState.fromJson(String source) => ListItemState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ListItemState(trans: $trans, months: $months, selectedIdx: $selectedIdx, selectedMonth: $selectedMonth, total: $total, loadStatus: $loadStatus, screenSize: $screenSize)';
  }

  @override
  bool operator ==(covariant ListItemState other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.trans, trans) &&
      listEquals(other.months, months) &&
      other.selectedIdx == selectedIdx &&
      other.selectedMonth == selectedMonth &&
      other.total == total &&
      other.loadStatus == loadStatus &&
      other.screenSize == screenSize;
  }

  @override
  int get hashCode {
    return trans.hashCode ^
      months.hashCode ^
      selectedIdx.hashCode ^
      selectedMonth.hashCode ^
      total.hashCode ^
      loadStatus.hashCode ^
      screenSize.hashCode;
  }
}
