// 🌎 Project imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart'
    show JsonAssetLoader;
import 'package:flutter/material.dart';

import 'bootstrap.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  bootstrap(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/l10n',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      assetLoader: JsonAssetLoader(),
      child: const MyApp(),
    ),
  );
}
