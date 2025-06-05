// 📦 Package imports:
import 'package:get_it/get_it.dart';
import 'package:test/core/injection/src/grades_injection.dart' show gradesInjection;

// 🌎 Project imports:
import 'src/announcements_injection.dart';
import 'src/auth_injection.dart';
import 'src/general_injection.dart';
import 'src/home_injection.dart';
import 'src/subjects_injection.dart';
import 'src/timetable_injection.dart';

final GetIt getIt = GetIt.instance;

Future<void> initInjection() async {
  await generalInjection();
  await authInjection();
  await homeInjection();
  await subjectsInjection();
  await timetableInjection();
  await announcementsInjection();
  await gradesInjection();
}
