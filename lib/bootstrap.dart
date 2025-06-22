import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/core/auth_data_source/local/reactive_token_storage.dart'
    show ReactiveTokenStorage;

import 'core/constants/key_constants.dart';
import 'core/injection/injection.dart';
import 'shared/imports/imports.dart';
import 'shared/states/theme_provider/theme_provider.dart';

bootstrap(Widget mainApp) async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initInjection();
    await getIt<ReactiveTokenStorage>().loadToken();
    // Initialize theme provider
    final themeProvider = getIt<ThemeProvider>();
    themeProvider.loadTheme();

    // Initialize language in SharedPreferences if not already set
    final sharedPreferences = getIt<SharedPreferences>();
    if (sharedPreferences.getString(kLanguage) == null) {
      await sharedPreferences.setString(kLanguage, 'en');
    }

    // await FirebaseNotificationImplService.initFirebase(DefaultFirebaseOptions.currentPlatform);
    // FirebaseNotificationImplService firebaseNotificationImplService = FirebaseNotificationImplService();
    // await firebaseNotificationImplService.setUpFirebase("channel_id");
    // printR(await firebaseNotificationImplService.getToken());
  } finally {
    if (kReleaseMode) {
      runApp(mainApp);
    } else {
      runApp(mainApp);
    }
  }
}
