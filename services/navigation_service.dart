import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class NavigationService {
  NavigationService._();

  static final NavigationService instance =
      NavigationService._();

  final navigatorKey =
      GlobalKey<NavigatorState>();

  final PersistentTabController tabController =
      PersistentTabController();

  void openDashboard() {
    tabController.jumpToTab(0);
  }

  void openCalendar() {
    tabController.jumpToTab(1);
  }

  void openReminders() {
    tabController.jumpToTab(2);
  }

  void openTasks() {
    tabController.jumpToTab(3);
  }

  void openFinance() {
    tabController.jumpToTab(4);
  }
}