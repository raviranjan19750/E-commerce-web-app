import 'dart:collection';

import 'package:flutter/cupertino.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>>{

  final NavStack<String> _navigationStack = NavStack<String>();

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    final screen = route.settings.name;
    _navigationStack.push(screen);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
  }

  NavStack<String> get navStack => _navigationStack;
}

class NavStack<T> implements _NavStack<T> {

  final ListQueue<T> _navs = ListQueue();
  @override
  // TODO: implement clear
  void get clear => _navs.clear();

  @override
  List<T> fetchAll() {
    final _tmp = <T>[];
    for (var i = 0; i < _navs.length; i++) {
      _tmp.add(_navs.elementAt(i));
    }
    return _tmp;
  }

  @override
  void pop() {
    _navs.removeLast();
  }

  @override
  void push(T val) {
    _navs.addLast(val);
  }

  @override
  T top() {
    return _navs.last;
  }

}

abstract class _NavStack<T> {
  void push(T val) {}
  void pop() {}
  T top();
  List<T> fetchAll();
  void get clear {}
}