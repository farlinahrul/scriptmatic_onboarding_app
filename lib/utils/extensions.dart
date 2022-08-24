import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scriptmatic_onboarding_app/utils/routes.dart' as AppRoute;

enum RouteTransition { slide, dualSlide, fade, material, cupertino, slideUp }

class RouteApp {
  static void backToRoot(context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  static void popUntilRoot(context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  static void backToMain(context) {
    Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
  }

  static void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void popScreen(BuildContext context, [dynamic data]) {
    Navigator.pop(context, data);
  }

  static Future pushScreen(BuildContext context, Widget buildScreen,
      [RouteTransition routeTransition = RouteTransition.slide,
      Widget? fromScreen]) async {
    dynamic data;
    switch (routeTransition) {
      case RouteTransition.slide:
        data = await Navigator.push(
            context, AppRoute.SlideRoute(page: buildScreen));
        break;
      case RouteTransition.fade:
        data = await Navigator.push(
            context, AppRoute.FadeRoute(page: buildScreen));
        break;
      case RouteTransition.material:
        data = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => buildScreen));
        break;
      case RouteTransition.dualSlide:
        data = await Navigator.push(
            context,
            AppRoute.DualSlideRoute(
                enterPage: buildScreen,
                exitPage: fromScreen ?? context.widget));
        break;
      case RouteTransition.cupertino:
        data = await Navigator.push(
            context,
            CupertinoPageRoute(
                fullscreenDialog: true, builder: (context) => buildScreen));
        break;
      case RouteTransition.slideUp:
        data = await Navigator.push(
            context, AppRoute.SlideUpRoute(page: buildScreen));
        break;
    }
    return data;
  }

  static void pushAndRemoveScreen(BuildContext context,
      {required Widget pageRef}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => pageRef),
        (Route<dynamic> route) => false);
  }

  static void pushReplacement(BuildContext context, Widget buildScreen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => buildScreen),
    );
  }
}

String toRupiah(int number) {
  if (number == null) return "-";
  final currencyFormatter = NumberFormat('#,##0', 'ID');
  return currencyFormatter.format(number);
}

String shortCurr(int number) {
  return number < 1000000 ? toRupiah(number) : convCurr(number);
}

String convCurr(int number) {
  final currencyFormatter = NumberFormat.compact(locale: 'ID');
  return currencyFormatter.format(number);
}
