import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {

  Locale? locale;

  AppLocalization(this.locale);


  static AppLocalization? of(context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationDelegate();

  late Map<String, String> _localizationsStrings;

  Future<bool> load() async {

    String jsonString = await rootBundle.loadString("assets/languages/lang-${locale!.languageCode}.json");

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizationsStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;

  }

  translate(String key) {
    return _localizationsStrings[key];
  }

}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {

  _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ["ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    // TODO: implement load
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    // TODO: implement shouldReload
    return false;
  }

}