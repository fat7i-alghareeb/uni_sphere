// 📦 Package imports:

// 🌎 Project imports:

// import 'package:jwt_decoder/jwt_decoder.dart';

import '../../core/auth_data_source/local/auth_local.dart';
import '../../core/injection/injection.dart';
import '../../core/models/auth_token_dio.dart' show AuthTokenModel;
import '../entities/user.dart';
import '../utils/helper/colored_print.dart';

bool isTokenAboutToExpire(String token, {int bufferTimeInSeconds = 900}) {
  try {
    // Decode the token
    // DateTime expirationDate = JwtDecoder.getExpirationDate(token);
    DateTime expirationDate = DateTime.now();
    printK("expirationDate:     $expirationDate");

    // Get the current time
    DateTime now = DateTime.now();
    printK("currentTime:     $now");

    // Add buffer time (default: 15 minutes)
    DateTime bufferTime =
        expirationDate.subtract(Duration(seconds: bufferTimeInSeconds));

    // Check if the token is about to expire
    bool shouldRefresh = now.isAfter(bufferTime);
    if (shouldRefresh) {
      printW("Should Refresh Token");
    }
    return shouldRefresh;
  } catch (e) {
    // Handle invalid token
    printR('Error decoding token: $e');
    return true; // Treat invalid token as expired
  }
}

Future<void> updateStorageToken(
  AuthTokenModel token,
) async {
  final user = getIt<AuthLocal>().getUser()!;
  User user2 = User(
    id: user.id,
    accessToken: token.accessToken,
    refreshToken: token.refreshToken ?? user.refreshToken,
    firstName: user.firstName,
    deviceToken: user.deviceToken,
    lastName: user.lastName,
    fatherName: user.fatherName,
    enrollmentStatusName: user.enrollmentStatusName,
    majorName: user.majorName,
    studentNumber: user.studentNumber,
    year: user.year,
  );
  await getIt<AuthLocal>().setUser(user2);
}
