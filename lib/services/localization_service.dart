import 'package:apptest/lang/en_US.dart';
import 'package:apptest/lang/pt_PT.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../lang/pa_IN.dart';

class LocalizationService extends Translations {
  // Default locale
  static final locale = Locale('pt', 'PT');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('pt', 'PT');

  // Supported languages
  // Needs to be same order with locales
  static final langs = ['English','Portugues',  'Hindi', 'Malayalam', 'Marathi', 'Punjabi'];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('pt', 'PT'),
    Locale('hi', 'IN'),
    
  ];

  static final codes = ['en','pt', 'hi', 'ml', 'mr', 'pa'];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // lang/hi_IN.dart'ar_AE': arAE, // lang/ar_AE.dart
        'pt_PT': ptPT, // lang/hi_IN.dart'ar_AE': arAE, // lang/ar_AE.dart
        'pa_IN': paIN, // lang/hi_IN.dart'ar_AE': arAE, // lang/ar_AE.dart
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);

    final box = GetStorage();
    box.write('lng', lang);

    Get.updateLocale(locale);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }

  String getLanguageCode(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return codes[i];
    }
    return 'pt';
  }

  Locale getCurrentLocale() {
    final box = GetStorage();
    Locale defaultLocale;

    if (box.read('lng') != null) {
      final locale =
          LocalizationService().getLocaleFromLanguage(box.read('lng'));

      defaultLocale = locale;
    } else {
      defaultLocale = Locale(
        'pt',
        'PT',
      );
    }

    return defaultLocale;
  }

  String getCurrentLang() {
    final box = GetStorage();

    return box.read('lng') != null ? box.read('lng') : "Portugues";
  }
}
