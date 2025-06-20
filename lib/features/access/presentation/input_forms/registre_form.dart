// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// 🌎 Project imports:
import 'auth_input_keys.dart';

class RegisterForm {
  static FormGroup formGroup = FormGroup(
    {
      AuthInputKeys.studentNumber: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      AuthInputKeys.password: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      AuthInputKeys.confirmPassword: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
    },
    validators: [
      Validators.mustMatch(
        AuthInputKeys.password,
        AuthInputKeys.confirmPassword,
      ),
    ],
  );

  static String getStudentNumber() {
    return formGroup.control(AuthInputKeys.studentNumber).value ?? '';
  }

  static String getPassword() {
    return formGroup.control(AuthInputKeys.password).value ?? '';
  }

  static String getConfirmPassword() {
    return formGroup.control(AuthInputKeys.confirmPassword).value ?? '';
  }
}
