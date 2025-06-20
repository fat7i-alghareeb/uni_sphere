// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// 🌎 Project imports:
import 'auth_input_keys.dart';

class LoginForm {
  static FormGroup formGroup = FormGroup({
    AuthInputKeys.studentNumber: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  static String getStudentNumber() {
    return formGroup.control(AuthInputKeys.studentNumber).value ?? '';
  }

  static String getPassword() {
    return formGroup.control(AuthInputKeys.password).value ?? '';
  }
}
