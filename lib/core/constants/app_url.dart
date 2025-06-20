class AppUrl {
  static String getAllSubjects = '';

  static String getSubjectById = '';

  static const baseUrlDevelopment = 'https://194.168.1.125:5001/';

  static const _api = "Mobile";
  static const _auth = "Auth";
  //! ************** Auth *************** //
  static const _student = "$_api/Student";
  static const login = '$_student/Login';
  static const register = '$_student/Register';
  static const checkOneTimeCode = '$_student/CheckOneTimeCode';
  // static const resetPassword = '$_student/ResetPassword';
  static const refreshToken = '$_auth/RefreshToken';
  // static const createAccount = '$_student/Create';
  //! ************** End Auth ***************//
  //! ************** Info ***************//
  static const _info = "$_api/Info";
  static const getFaculties = '$_info/GetFaculties';
  static const getMajors = '$_info/GetMajors';
  //! ************** Ent Info ***************//

  static const getProfile = '';
  static const modifyProfile = '';
  static const getMyProfile = '';
  static const getAllNotification = '';

  static const contactUs = '';

  static const forgetPassword = '';

  static const confirmForgetPassword = '';
  AppUrl._();
}
