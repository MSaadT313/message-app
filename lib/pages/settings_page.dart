import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message_app_flutter/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Provider.of<ThemeProvider>(context).globalBgPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
        title: Text("تبدیلی"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("اندھیرا", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.inversePrimary)),
                  CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                      onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("چیٹ وال پیپر", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.inversePrimary)),
                  const SizedBox(height: 16),
                  DropdownButton<String?>(
                    value: Provider.of<ThemeProvider>(context).currentWallpaperKey,
                    isExpanded: true,
                    dropdownColor: Theme.of(context).colorScheme.surface,
                    items: const [
                      DropdownMenuItem(value: null, child: Text("کوئی نہیں")),
                      DropdownMenuItem(value: "generic", child: Text("عام")),
                      DropdownMenuItem(value: "chemistry", child: Text("کیمسٹری")),
                      DropdownMenuItem(value: "math", child: Text("ریاضی")),
                      DropdownMenuItem(value: "philosophy", child: Text("فلسفہ")),
                      DropdownMenuItem(value: "physics", child: Text("طبیعیات")),
                    ],
                    onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).setWallpaperKey(value),
                  ),
                  if (Provider.of<ThemeProvider>(context).currentWallpaper != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                        image: DecorationImage(
                          image: AssetImage(Provider.of<ThemeProvider>(context).currentWallpaper!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
