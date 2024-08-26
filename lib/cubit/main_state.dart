// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'main_cubit.dart';
class MainState {

  final bool isLightTheme;
  final DrawerItem selected;

  MainState.init({
     this.isLightTheme = true ,
     this.selected  = DrawerItem.Home
  });


  MainState({
    required this.isLightTheme,
    required this.selected,
  });

  MainState copyWith({
    bool? isLightTheme,
    DrawerItem? selected,
  }) {
    return MainState(
      isLightTheme: isLightTheme ?? this.isLightTheme,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLightTheme': isLightTheme,
      'selected': selected,
    };
  }

  factory MainState.fromMap(Map<String, dynamic> map) {
    return MainState(
      isLightTheme: map['isLightTheme'] as bool,
      
      selected: map['isLightTheme'] as DrawerItem,
    
    );
  }

  String toJson() => json.encode(toMap());

  factory MainState.fromJson(String source) => MainState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MainState(isLightTheme: $isLightTheme, selected: $selected)';

  @override
  bool operator ==(covariant MainState other) {
    if (identical(this, other)) return true;
  
    return 
      other.isLightTheme == isLightTheme &&
      other.selected == selected;
  }

  @override
  int get hashCode => isLightTheme.hashCode ^ selected.hashCode;
}
