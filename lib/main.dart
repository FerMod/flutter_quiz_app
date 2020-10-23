import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_localizations.dart';
import 'data/app_options.dart';
import 'model_binding.dart';
import 'screens/home_page.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: AppOptions(
        themeMode: ThemeMode.system,
        locale: null,
        platform: defaultTargetPlatform,
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            // localizationsDelegates: [
            //   const AppLocalizationsDelegate(),
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            // ],
            // supportedLocales: Global.supportedLocales.values,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: AppOptions.of(context).locale,
            localeResolutionCallback: (locale, supportedLocales) {
              deviceLocale = locale;
              return locale;
            },
            themeMode: AppOptions.of(context).themeMode,
            darkTheme: ThemeData.dark(),
            home: HomePage(),
          );
        },
      ),
    );
    /* MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('es'),
      ],
      
      home: ModelBinding<AppOptions>(
        initialModel: const AppOptions(),
        child: HomePageTest(),
      ),
    ); */
  }
}
