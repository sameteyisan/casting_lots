import 'package:casting_lots/lang/en_us.dart';
import 'package:casting_lots/lang/tr_tr.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations {
  static final LocalizationService _instance = LocalizationService._internal();

  factory LocalizationService() {
    return _instance;
  }

  LocalizationService._internal();
  Locale locale = Locale('en', 'US');
  
  final fallbackLocale = Locale('en', 'US');

  final langs = [
    'English',
    'Türkçe',
  ];

  final flags = [
    '🇺🇸',
    '🇹🇷',
  ];

  final locales = [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'tr_TR': trTR,
      };

  Future<Locale> changeLocale(String lang) async {
    final _locale = _getLocaleFromLanguage(lang);
    await Get.updateLocale(_locale);
    locale = _locale;
    return locale;
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}
