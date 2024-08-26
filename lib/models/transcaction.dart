// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transcaction {
  final String dateTime;
  final String title;
  final String content;
  final double amount;
  Transcaction({
    required this.dateTime,
    required this.title,
    required this.content,
    required this.amount,
  });

  Transcaction copyWith({
    String? dateTime,
    String? title,
    String? content,
    double? amount,
  }) {
    return Transcaction(
      dateTime: dateTime ?? this.dateTime,
      title: title ?? this.title,
      content: content ?? this.content,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime,
      'title': title,
      'content': content,
      'amount': amount,
    };
  }

  factory Transcaction.fromMap(Map<String, dynamic> map) {
    return Transcaction(
      dateTime: map['dateTime'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      amount: map['amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transcaction.fromJson(String source) => Transcaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transcaction(dateTime: $dateTime, title: $title, content: $content, amount: $amount)';
  }

  @override
  bool operator ==(covariant Transcaction other) {
    if (identical(this, other)) return true;
  
    return 
      other.dateTime == dateTime &&
      other.title == title &&
      other.content == content &&
      other.amount == amount;
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^
      title.hashCode ^
      content.hashCode ^
      amount.hashCode;
  }
}
