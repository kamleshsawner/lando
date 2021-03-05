import 'package:flutter/material.dart';

@immutable
class MyFireBaseMessage {
  final String title;
  final String body;

  const MyFireBaseMessage({
    @required this.title,
    @required this.body,
  });
}