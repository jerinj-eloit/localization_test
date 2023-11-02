# localization_test

A Flutter project to demonstrate basics of flutter_localizations package.

### Locales
- Locale('hi') - Hindi
- Locale('ml') - Malayalam
- Locale('en', 'IN') - English(India)
- Locale('ro') - Romanian
- Locale('zh') - Generic Chinese
- Locale('th') - Thai

### Run

- `flutter pub get`
- `flutter run`

### Add more locales

- Add locale to `supportedLocales` in **lib/l10n/l10n.dart**
- Create a new file 'app_NEW-LOCALE-NAME.arb' and add key value pairs for your strings

    Example for Hindi 'hi' locale :

    ``````
    {
        "flutterDemoHomepage": "फ़्लटर स्थानीयकरण डेमो पेज",
        "dummy": "आपके द्वारा उपभोग की जाने वाली जानकारी की आलोचना करना महत्वपूर्ण है, खासकर ऑनलाइन।"
    }
    ```````

- Add new LocaleModel to `locales` list in **lib/main.dart**
- Rerun the app.