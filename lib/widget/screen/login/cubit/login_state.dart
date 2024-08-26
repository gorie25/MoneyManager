part of 'login_cubit.dart';
class LoginState {

    final LoadStatus loadStatus;

      LoginState.init({
      this.loadStatus = LoadStatus.Init,
  });
  LoginState({
    required this.loadStatus,
  });
    

  LoginState copyWith({
    LoadStatus? loadStatus,
  }) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loadStatus': loadStatus,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
          loadStatus: map['loadStatus'] as LoadStatus,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginState.fromJson(String source) => LoginState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginState(loadStatus: $loadStatus)';

  @override
  bool operator ==(covariant LoginState other) {
    if (identical(this, other)) return true;
  
    return 
      other.loadStatus == loadStatus;
  }

  @override
  int get hashCode => loadStatus.hashCode;
 }