import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization_test/locales_model.dart';

class LocalizationProvider extends ChangeNotifier {
  LocaleModel _locale = LocaleModel(const Locale('en', 'IN'), "English");

  LocaleModel get locale => _locale;

  void setLocale(LocaleModel locale) {
    if (!AppLocalizations.supportedLocales.contains(locale.locale)) return;
    _locale = locale;
    notifyListeners();
  }
}
