import 'package:counter_bloc/pdf.dart';
import 'package:flutter/material.dart';

import 'counter/counter.dart';

/// {@template counter_app}
/// A [MaterialApp] which sets the `home` to [CounterPage].
/// {@endtemplate}
// class CounterApp extends MaterialApp {
/// {@macro counter_app}
// const CounterApp({Key key}) : super(key: key, home: const CounterPage());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new CounterApp(),
    );
  }
}

class CounterApp extends StatelessWidget {
  final PageController pageController = PageController(
    initialPage: 0,
  );

//  출처: https://spiralmoon.tistory.com/entry/Flutter-여러-페이지를-한-화면에서-PageView [Spiral Moon's programming blog]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          CounterPage(),
          PDFPage()
        ],
      ),
    );
  }
}
