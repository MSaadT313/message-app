import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:message_app_flutter/themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = context.watch<ThemeProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("تبدیلی"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(25),

        child: Column(

          children: [

            // =====================================================
            // DARK MODE
            // =====================================================

            CupertinoSwitch(

              value: theme.isDarkMode,

              onChanged: (_) {

                context
                    .read<ThemeProvider>()
                    .toggleTheme();
              },
            ),

            const SizedBox(height: 30),

            // =====================================================
            // WALLPAPER SELECTOR
            // =====================================================

            DropdownButton<String?>(

              value: theme.wallpaperKey,

              isExpanded: true,

              items: const [

                DropdownMenuItem(
                  value: null,
                  child: Text("کوئی نہیں"),
                ),

                DropdownMenuItem(
                  value: "generic",
                  child: Text("عام"),
                ),

                DropdownMenuItem(
                  value: "chemistry",
                  child: Text("کیمسٹری"),
                ),

                DropdownMenuItem(
                  value: "math",
                  child: Text("ریاضی"),
                ),

                DropdownMenuItem(
                  value: "philosophy",
                  child: Text("فلسفہ"),
                ),

                DropdownMenuItem(
                  value: "physics",
                  child: Text("طبیعیات"),
                ),
              ],

              onChanged: (value) {

                context
                    .read<ThemeProvider>()
                    .setWallpaper(value);
              },
            ),

            const SizedBox(height: 25),

            // =====================================================
            // PREVIEW
            // =====================================================

            if (theme.wallpaper != null)

              Container(

                height: 220,
                width: double.infinity,

                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(20),

                  image: DecorationImage(

                    image:
                    AssetImage(theme.wallpaper!),

                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}