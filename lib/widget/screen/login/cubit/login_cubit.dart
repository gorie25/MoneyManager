import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fluttertest/enum/load_status.dart';
import 'package:fluttertest/models/login.dart';
import 'package:fluttertest/repositories/api.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final Api api;
  LoginCubit(this.api) : super(LoginState.init());
  Future<void> checkLogin(Login login)
  async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));  // trạng thái ban đầu loading
    var result = await  api.checkLogin(login);
     if(result)
     {
          emit(state.copyWith(loadStatus: LoadStatus.Done)); // trạng thái sau khi load xong

     }else{
          emit(state.copyWith(loadStatus: LoadStatus.Error)); // trạng thái  khi load fail
     }
  }

}
