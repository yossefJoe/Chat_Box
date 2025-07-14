import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';

class NavigationHelper {
  static void goToLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }
  static void goToWelcomeScreen(BuildContext context) {
    context.go(AppRoutes.welcomeScreen);
  }

  static void goToHome(BuildContext context) {
    context.go(AppRoutes.navBarView);
  }

  static void goToPage(BuildContext context, String page) {
    context.go(page);
  }

  static void goToPageWithParams(
      BuildContext context, String page, Map<String, dynamic> params) {
    context.go(page, extra: params);
  }

  static void pop(BuildContext context) {
    context.pop();
  }

  static void push(BuildContext context, String routeName) {
    context.push(routeName);
  }
   static void pushToPageWithParams(
      BuildContext context, String page, Map<String, dynamic> params) {
    context.push(page, extra: params);
  }
}
