import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../services/navigation_service.dart';

import '../pages/dashboard/dashboard_page.dart';
import '../pages/calendar/calendar_page.dart';
import '../pages/reminders/reminders_page.dart';
import '../pages/tasks/tasks_page.dart';
import '../pages/finance/finance_page.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PersistentTabView(
      controller: NavigationService.instance.tabController,

      tabs: [
        PersistentTabConfig(
          screen: const DashboardPage(),
          item: ItemConfig(icon: Icon(Icons.home_rounded), title: "خانه"),
        ),

        PersistentTabConfig(
          screen: const CalendarPage(),
          item: ItemConfig(
            icon: const Icon(Icons.calendar_month),
            title: "تقویم",
          ),
        ),

        PersistentTabConfig(
          screen: const RemindersPage(),
          item: ItemConfig(
            icon: const Icon(Icons.notifications),
            title: "یادآوری",
          ),
        ),

        PersistentTabConfig(
          screen: const TasksPage(),
          item: ItemConfig(icon: const Icon(Icons.task_alt), title: "برنامه"),
        ),

        PersistentTabConfig(
          screen: const FinancePage(),
          item: ItemConfig(
            icon: const Icon(Icons.wallet),
            title: "مالی",
            // activeForegroundColor: theme.colorScheme.primary,
            // inactiveForegroundColor: Colors.grey,
          ),
        ),
      ],

      navBarBuilder: (navBarConfig) {
        final colorScheme = Theme.of(context).colorScheme;
        return Theme(
          data: theme,
          child: Style4BottomNavBar(
            navBarConfig: navBarConfig,

            navBarDecoration: NavBarDecoration(
              color: colorScheme.surface,

              borderRadius: BorderRadius.circular(24),

              border: Border.all(color: colorScheme.outline.withOpacity(.08)),

              boxShadow: theme.brightness == Brightness.light
                  ? const [
                      BoxShadow(
                        color: Color(0x11000000),
                        blurRadius: 15,
                        offset: Offset(0, -2),
                      ),
                    ]
                  : [],
            ),
          ),
        );
      },

      backgroundColor: theme.scaffoldBackgroundColor,

      handleAndroidBackButtonPress: true,
      stateManagement: true,
      resizeToAvoidBottomInset: true,
    );
  }
}
