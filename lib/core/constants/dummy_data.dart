import 'dart:math';

import '../../features/home/domain/entities/ads_entity.dart';
import '../../features/home/domain/entities/home_entity.dart';
import '../../features/home/domain/entities/lecture_remaining_time.dart';
import '../../features/home/domain/entities/statistics_entity.dart';
import '../../features/subjects/domain/entities/materials_entity.dart';

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
final LectureRemainingTime mockedLectureTime = LectureRemainingTime(
  remainingTime: _generateRandomFutureDateTime().toIso8601String(),
  lectureName: "Operating Systems - Room 304",
);

DateTime _generateRandomFutureDateTime() {
  final random = Random();
  // Generate random hours between 2 and 24
  final hours = 2 + random.nextInt(22); // 22 because 24-2=22
  // Generate random minutes between 0 and 59
  final minutes = random.nextInt(60);
  // Generate random seconds between 0 and 59
  final seconds = random.nextInt(60);

  // Get current time and add the random duration
  return DateTime.now().add(Duration(
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
  lectureRemainingTime: mockedLectureTime,
);
