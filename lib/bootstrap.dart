import 'package:flutter/foundation.dart';

import 'core/injection/injection.dart';
import 'shared/imports/imports.dart';
import 'shared/states/theme_provider/theme_provider.dart';

bootstrap(Widget mainApp) async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initInjection();
    // Initialize theme provider
    final themeProvider = getIt<ThemeProvider>();
    themeProvider.loadTheme();
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
