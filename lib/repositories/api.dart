
import 'package:fluttertest/models/login.dart';
import 'package:fluttertest/models/transcaction.dart';

abstract class Api{
  Future<bool> checkLogin(Login login);
  Future<double>getTotal();
  Future<List<String>>getMonth();
  Future<List< Transcaction >>getTransaction(String month);  
  Future<void>addTransaction(Transcaction transcaction);
  Future<void>deleteTransaction(String dateTime);
  Future<void>editTransaction(Transcaction transcaction);
}