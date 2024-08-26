// Một noti bar để hiển thị thông báo cho nhiều phần trong project

import 'package:flutter/material.dart';

SnackBar notiBar(String message, bool isError) {
  return SnackBar(
    content: Text(message), backgroundColor: isError ? Colors.red : Colors.green,
  );
}