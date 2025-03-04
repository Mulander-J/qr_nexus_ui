import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../app.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              S.of(context).lang,
              key: ValueKey<String>(Localizations.localeOf(context).languageCode),
            ),
          ),
          content: SizedBox(
            width: double.minPositive,
            child: ListView(
              shrinkWrap: true,
              children: S.delegate.supportedLocales.map((locale) {
                return ListTile(
                  title: Text(_getLanguageName(locale)),
                  textColor: locale == Localizations.localeOf(context)
                      ? Theme.of(context).colorScheme.primary
                      : null,
                  onTap: () async {
                    MyApp.setLocale(context, locale);
                    await Future.delayed(const Duration(milliseconds: 300));
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'zh':
        return '中文';
      case 'en':
        return 'English';
      default:
        return locale.languageCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _showLanguageDialog(context),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Text(
          _getLanguageName(Localizations.localeOf(context)),
          key: ValueKey<String>(Localizations.localeOf(context).languageCode),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
