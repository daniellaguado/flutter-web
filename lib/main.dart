import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:website/src/my_web_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(ProviderScope(
      child: MaterialApp(
    title: "basic website",
    home: MyPageWeb(),
    debugShowCheckedModeBanner: false,
  )));
}
