class AppUrl {
  static const baseUrlDevelopment = 'https://192.168.1.125:5001/';

  static const _auth = "Auth";
  //! ************** Auth *************** //
  static const _student = "StudentAuth";
  static const login = '$_student/Login';
  static const register = '$_student/Register';
  static const checkOneTimeCode = '$_student/CheckOneTimeCode';
  // static const resetPassword = '$_student/ResetPassword';
  static const refreshToken = '$_auth/RefreshToken';
  // static const createAccount = '$_student/Create';
  //! ************** End Auth ***************//
  //! ************** Info ***************//
  static const _info = "Info";
  static const getFaculties = '$_info/GetFaculties';
  static const getMajors = '$_info/GetMajors';
  static const getHomePageInfo = '$_info/GetHomePageInfo';
  //! ************** Ent Info ***************//
  //! ************** Subject ***************//
  static const _subject = "Subject";
  static const getMySubjectsByYear = '$_subject/Student/GetMyMajorSubjects';
  static const getMySubjects = '$_subject/Student/MySubjects';
  static String getSubjectById(String id) => '$_subject/$id';
  //! ************** End Subject ***************//
  //! ************** Schedule ***************//
  static const _schedule = "Schedule";
  static const getMySchedule = '$_schedule/Student/GetMySchedule';
  static const getScheduleByMonth = '$_schedule/Student/GetScheduleByMonth';
  //! ************** End Schedule ***************//
  //! ************** Announcement ***************//
  static const _announcement = "Announcements";
  static const getStudentAnnouncements =
      '$_announcement/Student/GetMyAnnouncements';
  static const getFacultyAnnouncements =
      '$_announcement/Student/GetFacultyAnnouncements';
  //! ************** End Announcement ***************//
  //! ************** Grades ***************//
  static const _grades = "Grades";
  static const getMyGrades = '$_grades/GetMyGrades';
  //! ************** End Grades ***************//
  static const contactUs = '';

  static const forgetPassword = '';

  static const confirmForgetPassword = '';
  AppUrl._();
}
