import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart' show Status;
import 'package:test/features/access/presentation/ui/screens/login_screen.dart'
    show LoginScreen;

import '../features/access/presentation/ui/screens/check_one_time_code_screen.dart'
    show CheckOneTimeCodeScreen;
import '../features/access/presentation/ui/screens/choose_access_method_screen.dart'
    show ChooseAccessMethodScreen;
import '../features/access/presentation/ui/screens/register_screen.dart';
import '../features/announcements/presentation/ui/screens/news_details_screen.dart';
import '../features/grades/presentation/ui/screens/grades_screen.dart';
import '../features/root/presentation/ui/screen/root_screen.dart';
import '../features/settings/presentation/ui/screens/language_selection_screen.dart'
    show LanguageSelectionScreen;
import '../features/subjects/presentation/ui/screens/choose_years_screen.dart';
import '../features/subjects/presentation/ui/screens/subject_details_screen.dart';
import '../features/subjects/presentation/ui/screens/year_subjects.dart';
import '../shared/imports/imports.dart';
import '../shared/states/app_manager_bloc/app_manager_bloc.dart';
import '../shared/utils/helper/colored_print.dart';

typedef BeamerBuilder = dynamic Function(BuildContext, BeamState, Object?);

class RefreshStream extends ChangeNotifier {
  RefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class BRouterConfig {
  late final AppManagerBloc appManagerBloc;
  late final BeamerDelegate router;

  BRouterConfig({required this.appManagerBloc}) {
    router = BeamerDelegate(
      initialPath: ChooseAccessMethodScreen.pagePath,
      updateListenable: RefreshStream(appManagerBloc.stream),
      routeListener: (routerInfo, routerDelegate) {
        printG("route: ${routerInfo.uri}");
        printC(appManagerBloc.state.status);

        // final bool isUpdateAvailable = appManagerBloc.state.expired == true;
        // final bool isInUpdate =
        //     routerInfo.uri.path == UpdateAvailable.routePath;
        // if (isInUpdate && isUpdateAvailable) {
        //   return;
        // }
        // if (isUpdateAvailable) {
        //   routerDelegate.beamToNamed(UpdateAvailable.routePath);
        // }
        if (appManagerBloc.state.status == Status.authenticated &&
            !routerInfo.uri.path.contains(RootScreen.pagePath)) {
          routerDelegate.beamToNamed(RootScreen.pagePath);
        } else if (appManagerBloc.state.status == Status.unauthenticated &&
            !routerInfo.uri.path.contains(ChooseAccessMethodScreen.pagePath)) {
          routerDelegate.beamToNamed(ChooseAccessMethodScreen.pagePath);
        }
      },
      locationBuilder: RoutesLocationBuilder(
        routes: {
          //! -------------- Access ---------------- !//
          '/choose_access_method': ChooseAccessMethodScreen.pageBuilder,
          '/choose_access_method/login': LoginScreen.pageBuilder,
          '/choose_access_method/check_one_time_code':
              CheckOneTimeCodeScreen.pageBuilder,
          '/choose_access_method/check_one_time_code/register':
              RegisterScreen.pageBuilder,

          //! -------------- End Access ---------------- !//

          '/root': RootScreen.pageBuilder,
          //! -------------- Subjects ---------------- !//
          "/root/choose_years_screen": ChooseYearsScreen.pageBuilder,
          "/root/subject_details": SubjectDetailsScreen.pageBuilder,
          "/root/choose_years_screen/year_subjects": YearSubjects.pageBuilder,
          "/root/choose_years_screen/year_subjects/subject_details":
              SubjectDetailsScreen.pageBuilder,
          //! -------------- Announcements ---------------- !//
          "/root/news_details": NewsDetailsScreen.pageBuilder,
          //! -------------- Settings ---------------- !//
          "/root/language_selection": LanguageSelectionScreen.pageBuilder,
          "/root/grades_screen": GradesScreen.pageBuilder,
        },
      ).call,
    );
  }
}
