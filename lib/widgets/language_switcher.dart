import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../app.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: Localizations.localeOf(context),
      onChanged: (locale) {
        if (locale != null) {
          MyApp.setLocale(context, locale);
        }
      },
      items:
          S.delegate.supportedLocales.map((locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: Text(locale.languageCode),
            );
          }).toList(),
    );
  }
}
