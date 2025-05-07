import 'dart:math';

import '../../features/home/domain/entities/ads_entity.dart';
import '../../features/home/domain/entities/home_entity.dart';
import '../../features/home/domain/entities/days_to_the_final.dart';
import '../../features/home/domain/entities/statistics_entity.dart';
import '../../features/subjects/domain/entities/materials_entity.dart';
import '../../features/subjects/domain/entities/subjects_entity.dart';

List<String> dummyImages = [
  "https://cdn.pixabay.com/photo/2015/04/23/22/00/new-year-background-736885_1280.jpg",
  "https://cdn.pixabay.com/photo/2019/02/04/07/36/new-year-3974099_1280.jpg",
  "https://cdn.pixabay.com/photo/2024/11/01/07/36/new-years-day-9165860_1280.jpg",
  "https://cdn.pixabay.com/photo/2018/12/31/14/17/heart-3905176_1280.jpg"
];

// Mocked Ads Data
final List<AdsEntity> mockedAds = [
  AdsEntity(
    imageUrl: dummyImages[0],
    description: "Annual Computer Engineering Conference - Register Now!",
  ),
  AdsEntity(
    imageUrl: dummyImages[1],
    description: "Scholarship opportunities for top students",
  ),
  AdsEntity(
    imageUrl: dummyImages[2],
    description: "Summer internships at Syrian Software Companies",
  ),
];

// Mocked Statistics Data
final StatisticsEntity mockedStatistics = StatisticsEntity(
  numberOfAttendanceHours: 142.5,
  numberOfAttendanceLectures: 57,
  numberOfDaysToTheFinals: 23,
  numberOfDownloadedMaterials: 13,
);

// Mocked Materials Data
final List<MaterialEntity> mockedMaterials = [
  MaterialEntity(
    id: "comp401",
    title: "Data Structures - Lecture 5",
    fileUrl: "",
    subjectName: "Data Structures",
    professorName: "Dr. Ahmad Al-Masri",
  ),
  MaterialEntity(
    id: "comp402",
    title: "Algorithms Assignment 3",
    fileUrl: "",
    subjectName: "Algorithms",
    professorName: "Dr. Fatima Omar",
  ),
  MaterialEntity(
    id: "comp403",
    title: "Database Systems Slides",
    fileUrl: "",
    subjectName: "Database Systems",
    professorName: "Dr. Khaled Hassan",
  ),
  MaterialEntity(
    id: "comp404",
    title: "Computer Architecture Lab Manual",
    fileUrl: "",
    subjectName: "Computer Architecture",
    professorName: "Dr. Ali Mahmoud",
  ),
];

// Mocked Lecture Remaining Time
final DaysToTheFinals mockedLectureTime = DaysToTheFinals(
  remainingTime: _generateRandomFutureDateTime().toIso8601String(),
);

DateTime _generateRandomFutureDateTime() {
  final random = Random();
  // Generate random hours between 2 and 24
  final hours = 2 + random.nextInt(22); // 22 because 24-2=22
  // Generate random minutes between 0 and 59
  final minutes = random.nextInt(60);
  // Generate random seconds between 0 and 59
  final seconds = random.nextInt(60);
  // Generate random days between 0 and 30
  final days = random.nextInt(30);
  // Get current time and add the random duration
  return DateTime.now().add(Duration(
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  ));
}

// Complete Mocked Home Entity
final HomeEntity mockedHomeData = HomeEntity(
  ads: mockedAds,
  statistics: mockedStatistics,
  materials: mockedMaterials,
  daysToTheFinals: mockedLectureTime,
);

List<SubjectEntity> computerEngineeringSubjects = [
  SubjectEntity(
    id: "CE101",
    title: "Introduction to Programming",
    professorName: "Dr. Ahmad Al-Masri",
    year: 3,
    semester: "First Semester",
    isPassed: true,
    canEnroll: true,
    isMultipleChoice: false,
    doesHaveALab: true,
    imageUrl: dummyImages[2],
  ),
  SubjectEntity(
    id: "CE102",
    title: "Discrete Mathematics",
    professorName: "Dr. Fatima Khalil",
    year: 4,
    semester: "First Semester",
    isPassed: true,
    canEnroll: true,
    isMultipleChoice: true,
    doesHaveALab: false,
    imageUrl: dummyImages[3],
  ),
  SubjectEntity(
    id: "CE201",
    title: "Data Structures",
    professorName: "Dr. Omar Al-Hamid",
    year: 2,
    semester: "First Semester",
    isPassed: true,
    canEnroll: false,
    midTermGrade: 75,
    finalGrade: 82,
    isMultipleChoice: false,
    doesHaveALab: true,
    imageUrl: dummyImages[0],
  ),
  SubjectEntity(
    id: "CE202",
    title: "Computer Organization",
    professorName: "Dr. Yara Suleiman",
    year: 2,
    semester: "Second Semester",
    isPassed: true,
    canEnroll: true,
    isMultipleChoice: true,
    doesHaveALab: true,
    imageUrl: dummyImages[1],
  ),
  SubjectEntity(
    id: "CE301",
    title: "Operating Systems",
    professorName: "Dr. Khaled Al-Ahmad",
    year: 5,
    semester: "First Semester",
    isPassed: true,
    canEnroll: true,
    isMultipleChoice: false,
    doesHaveALab: true,
    imageUrl: dummyImages[3],
  ),
  SubjectEntity(
    id: "CE302",
    title: "Database Systems",
    professorName: "Dr. Lina Al-Hassan",
    year: 4,
    semester: "Second Semester",
    isPassed: true,
    canEnroll: false,
    midTermGrade: 80,
    finalGrade: 85,
    isMultipleChoice: false,
    doesHaveALab: true,
    imageUrl: dummyImages[3],
  ),
  SubjectEntity(
    id: "CE401",
    title: "Computer Networks",
    professorName: "Dr. Ali Al-Sayed",
    year: 1,
    semester: "First Semester",
    isPassed: true,
    canEnroll: true,
    isMultipleChoice: true,
    doesHaveALab: true,
    imageUrl: dummyImages[2],
  ),
  SubjectEntity(
    id: "CE402",
    title: "Artificial Intelligence",
    professorName: "Dr. Hala Ibrahim",
    year: 2,
    semester: "Second Semester",
    isPassed: true,
    canEnroll: true,
    isMultipleChoice: false,
    doesHaveALab: true,
    imageUrl: dummyImages[1],
  ),
  SubjectEntity(
    id: "CE203",
    title: "Algorithms Analysis",
    professorName: "Dr. Mahmoud Al-Khatib",
    year: 1,
    semester: "Second Semester",
    isPassed: true,
    canEnroll: false,
    midTermGrade: 78,
    finalGrade: 84,
    isMultipleChoice: false,
    doesHaveALab: false,
    imageUrl: dummyImages[0],
  ),
  SubjectEntity(
    id: "CE303",
    title: "Software Engineering",
    professorName: "Dr. Rana Al-Hussein",
    year: 1,
    semester: "First Semester",
    isPassed: true,
    canEnroll: true,
    isMultipleChoice: true,
    doesHaveALab: true,
    imageUrl: dummyImages[0],
  ),
  SubjectEntity(
    id: "CE304",
    title: "Computer Graphics",
    professorName: "Dr. Wael Al-Malik",
    year: 13,
    semester: "Second Semester",
    isPassed: true,
    canEnroll: true,
    isMultipleChoice: false,
    doesHaveALab: true,
    imageUrl: dummyImages[3],
  ),
  // SubjectEntity(
  //   id: "CE403",
  //   title: "Information Security",
  //   professorName: "Dr. Samir Al-Asaad",
  //   year: "Fourth Year",
  //   semester: "First Semester",
  //   isPassed:true,
  //   canEnroll: true,
  //   isMultipleChoice: true,
  //   doesHaveALab: false,
  //   imageUrl: "https://example.com/images/security.jpg",
  // ),
  // SubjectEntity(
  //   id: "CE103",
  //   title: "Digital Logic Design",
  //   professorName: "Dr. Nabil Al-Kurdi",
  //   year: "First Year",
  //   semester: "Second Semester",
  //   isPassed:true,
  //   canEnroll: false,
  //   midTermGrade: 70,
  //   finalGrade: 75,
  //   isMultipleChoice: true,
  //   doesHaveALab: true,
  //   imageUrl: "https://example.com/images/digitallogic.jpg",
  // ),
  // SubjectEntity(
  //   id: "CE104",
  //   title: "Calculus I",
  //   professorName: "Dr. Hassan Al-Rifai",
  //   year: "First Year",
  //   semester: "First Semester",
  //   isPassed:true,
  //   canEnroll: false,
  //   midTermGrade: 65,
  //   finalGrade: 72,
  //   isMultipleChoice: true,
  //   doesHaveALab: false,
  //   imageUrl: "https://example.com/images/calculus.jpg",
  // ),
  // SubjectEntity(
  //   id: "CE204",
  //   title: "Computer Architecture",
  //   professorName: "Dr. Rami Al-Halabi",
  //   year: "Second Year",
  //   semester: "Second Semester",
  //   isPassed: false,
  //   canEnroll: true,
  //   isMultipleChoice: false,
  //   doesHaveALab: true,
  //   imageUrl: "https://example.com/images/architecture.jpg",
  // ),
  // SubjectEntity(
  //   id: "CE404",
  //   title: "Distributed Systems",
  //   professorName: "Dr. Leila Al-Atrash",
  //   year: "Fourth Year",
  //   semester: "Second Semester",
  //   isPassed: false,
  //   canEnroll: true,
  //   isMultipleChoice: false,
  //   doesHaveALab: true,
  //   imageUrl: "https://example.com/images/distributed.jpg",
  // ),
  // SubjectEntity(
  //   id: "CE105",
  //   title: "Physics for Computer Engineers",
  //   professorName: "Dr. Fadi Al-Jabban",
  //   year: "First Year",
  //   semester: "Second Semester",
  //   isPassed: true,
  //   canEnroll: false,
  //   midTermGrade: 68,
  //   finalGrade: 74,
  //   isMultipleChoice: true,
  //   doesHaveALab: true,
  //   imageUrl: "https://example.com/images/physics.jpg",
  // ),
  // SubjectEntity(
  //   id: "CE305",
  //   title: "Web Development",
  //   professorName: "Dr. Ziad Al-Khoury",
  //   year: "Third Year",
  //   semester: "Second Semester",
  //   isPassed: false,
  //   canEnroll: true,
  //   isMultipleChoice: false,
  //   doesHaveALab: true,
  //   imageUrl: "https://example.com/images/webdev.jpg",
  // ),
  // SubjectEntity(
  //   id: "CE405",
  //   title: "Cloud Computing",
  //   professorName: "Dr. Mona Al-Hamwi",
  //   year: "Fourth Year",
  //   semester: "First Semester",
  //   isPassed: false,
  //   canEnroll: true,
  //   isMultipleChoice: true,
  //   doesHaveALab: true,
  //   imageUrl: "https://example.com/images/cloud.jpg",
  // ),
  // SubjectEntity(
  //   id: "CE106",
  //   title: "Technical Writing",
  //   professorName: "Dr. Sana Al-Shami",
  //   year: "First Year",
  //   semester: "Second Semester",
  //   isPassed: true,
  //   canEnroll: false,
  //   midTermGrade: 85,
  //   finalGrade: 88,
  //   isMultipleChoice: false,
  //   doesHaveALab: false,
  //   imageUrl: "https://example.com/images/writing.jpg",
  // ),
];
