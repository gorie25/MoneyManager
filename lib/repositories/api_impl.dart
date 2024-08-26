import 'package:flutter/material.dart';
import 'package:fluttertest/models/login.dart';
import 'package:fluttertest/models/transcaction.dart';
import 'package:fluttertest/repositories/api.dart';
import 'package:fluttertest/repositories/log.dart';

class ApiImpl implements Api{
Log log;


  //Tạo một ít dữ liệu để dễ thao tác
  List<Transcaction> _data = [
     Transcaction(dateTime: "2024-06-29 15:00:00", title: "abc", content:"xyz", amount: 100),
     Transcaction(dateTime:  "2024-06-29 15:00:00",title: "hyz", content: "ndc", amount:1000),
         Transcaction(dateTime:  "2024-07-29 15:00:00",title: "hyz", content: "ndc", amount:1000),
  ];
  
  ApiImpl( this.log){
  _data.sort((a,b) => b.dateTime.compareTo(a.dateTime));  
}


  Future <void> delay() async{
    await Future.delayed(Duration(seconds: 2));
  }
  @override
  Future<void> addTransaction(Transcaction transcaction) async {
      await delay();
      for(int i = 0; i < _data.length; i++){
        if(_data[i].dateTime ==transcaction.dateTime){
         throw Exception("Transaction already exists");
        } 
        _data.add(transcaction);
          _data.sort((a,b) => b.dateTime.compareTo(a.dateTime));  

        
  }
  }

  @override
  Future<bool> checkLogin(Login login) async {

        delay();
        if(login.username == '1' && login.password == '1'){
          return Future(() => true);
        }
        return Future(() => false);
  }

  @override
  Future<void> deleteTransaction(String dateTime) async {
    await delay();
    for(int i = 0; i < _data.length; i++){
      if(_data[i].dateTime == dateTime){
        _data.removeAt(i);
        return;
      } 
      throw Exception("Transaction not found");
  }}

  @override
  Future<void> editTransaction(Transcaction transcaction) async{
    await delay();
    for(int i = 0; i < _data.length; i++){
      if(_data[i].dateTime == transcaction.dateTime){
        _data[i] = transcaction;
        return;
      }
      throw Exception("Transaction not found");
  }
  }

  @override
  Future<List<String>> getMonth() async{
     await delay();
     Set<String> months = {};
     for(int i = 0; i < _data.length; i++){
       months.add(_data[i].dateTime.substring(0,7)+ "-01 00:00:00");
     }
     return months.toList();
  }

  @override
  Future<double> getTotal() async{
await delay();
    double total = 0;
    for(int i = 0; i < _data.length; i++){
      total += _data[i].amount;
    }
    return Future(() => total);
  }

  @override
  Future<List<Transcaction>> getTransaction(String month) async {
   await delay();
    List<Transcaction> result = [];
    for(int i = 0; i < _data.length; i++){
      if(_data[i].dateTime.substring(0,7) == month.substring(0,7)){
        result.add(_data[i]);
      }
    }
    return Future(() => result);
  }

}
