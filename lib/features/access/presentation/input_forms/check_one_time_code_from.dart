// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// 🌎 Project imports:
import 'auth_input_keys.dart';

class CheckOneTimeCodeForm {
  static FormGroup formGroup = FormGroup(
    {
      AuthInputKeys.oneTimeCode: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      AuthInputKeys.faculty: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      AuthInputKeys.major: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      AuthInputKeys.majorId: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      AuthInputKeys.facultyId: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
    },
  );

  static String getOneTimeCode() {
    return formGroup.control(AuthInputKeys.oneTimeCode).value ?? '';
  }

  static String getFacultyId() {
    return formGroup.control(AuthInputKeys.facultyId).value ?? '';
  }

  static String getMajorId() {
    return formGroup.control(AuthInputKeys.majorId).value ?? '';
  }

  static String getFaculty() {
    return formGroup.control(AuthInputKeys.faculty).value ?? '';
  }
}
