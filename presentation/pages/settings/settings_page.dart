import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/settings_provider.dart';
import '../../../providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("تنظیمات"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("ظاهر برنامه"),
              subtitle: Text(switch (theme.themeMode) {
                ThemeMode.system => "پیروی از تنظیمات گوشی",
                ThemeMode.light => "روشن",
                ThemeMode.dark => "تاریک",
              }),
              trailing: PopupMenuButton<ThemeMode>(
                onSelected: (mode) async {
                  await theme.setTheme(mode);
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: ThemeMode.system,
                    child: Text("پیروی از تنظیمات گوشی"),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.light,
                    child: Text("حالت روشن"),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Text("حالت تاریک"),
                  ),
                ],
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SwitchListTile(
              secondary: const Icon(Icons.notifications),
              title: const Text("اعلان‌ها"),
              subtitle: Text(
                settings.notificationsEnabled ? "فعال" : "غیرفعال",
              ),
              value: settings.notificationsEnabled,
              onChanged: (value) {
                settings.setNotificationsEnabled(value);
              },
            ),
          ),

          _SettingsTile(
            icon: Icons.info_outline,
            title: "درباره برنامه",
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Life Planner",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2026",
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
