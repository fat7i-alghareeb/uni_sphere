import 'dart:math';

import '../../features/announcements/domain/entities/news_entity.dart';
import '../../features/grades/domain/entities/grade_entity.dart';
import '../../features/grades/domain/entities/grades_response_entity.dart';
import '../../features/home/domain/entities/ads_entity.dart';
import '../../features/home/domain/entities/days_to_the_final.dart';
import '../../features/home/domain/entities/home_entity.dart';
import '../../features/home/domain/entities/statistics_entity.dart';
import '../../features/subjects/domain/entities/materials_entity.dart';
import '../../features/subjects/domain/entities/subject_details_entity.dart';
import '../../features/subjects/domain/entities/subject_entity.dart';

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
  // materials: mockedMaterials,
  daysToTheFinals: mockedLectureTime,
);

List<SubjectEntity> computerEngineeringSubjects = [
  SubjectEntity(
    id: "CE101",
    title: "Introduction to Programming",
    professorName: "Dr. Ahmad Al-Masri",
    year: 3,
    semester: 1,
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
    semester: 1,
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
    semester: 1,
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
    semester: 2,
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
    semester: 1,
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
    semester: 2,
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
    semester: 1,
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
    semester: 2,
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
    semester: 2,
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
    semester: 1,
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
    semester: 2,
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
List<SubjectDetailsEntity> computerEngineeringSubjectsDetails = [
  SubjectDetailsEntity(
    id: "CE101",
    title: "Introduction to Programming",
    professorIntro:
        "Dr. Ahmad Al-Masri is a professor with 15 years of experience...",
    professorName: "Dr. Ahmad Al-Masri",
    subjectDescription: "Fundamental programming concepts using Python...",
    semester: "First Semester",
    isPassed: true,
    midTermGrade: 25, // 25/30 (83%)
    finalGrade: 60, // 60/70 (86%) - Total: 85
    canEnroll: true,
    doesHaveALab: true,
    isMultipleChoice: false,
    materials: [
      MaterialEntity(
          title: "Python Basics Textbook",
          fileUrl: "http://example.com/python101.pdf",
          type: MaterialType.pdf),
      MaterialEntity(
          title: "Lecture 1: Introduction",
          fileUrl: "http://example.com/lecture1.mp4",
          type: MaterialType.video),
    ],
    imageUrl: dummyImages[2],
  ),
  SubjectDetailsEntity(
    id: "CE102",
    title: "Discrete Mathematics",
    professorIntro: "Dr. Fatima Khalil specializes in discrete mathematics...",
    professorName: "Dr. Fatima Khalil",
    subjectDescription: "Fundamental discrete structures...",
    semester: "First Semester",
    isPassed: true,
    midTermGrade: 18, // 18/30 (60%)
    finalGrade: 42, // 42/70 (60%) - Total: 60 (minimum pass)
    canEnroll: true,
    doesHaveALab: false,
    isMultipleChoice: true,
    materials: [
      MaterialEntity(
          title: "Discrete Math Textbook",
          fileUrl: "http://example.com/discrete-math.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[3],
  ),
  SubjectDetailsEntity(
    id: "CE201",
    title: "Data Structures",
    professorIntro: "Dr. Omar Al-Hamid is an expert in algorithms...",
    professorName: "Dr. Omar Al-Hamid",
    subjectDescription: "Study of fundamental data structures...",
    semester: "First Semester",
    isPassed: false, // Failed
    midTermGrade: 12, // 12/30 (40%)
    finalGrade: 40, // 40/70 (57%) - Total: 52
    canEnroll: false,
    doesHaveALab: true,
    isMultipleChoice: false,
    materials: [
      MaterialEntity(
          title: "Data Structures Handbook",
          fileUrl: "http://example.com/ds-handbook.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[0],
  ),
  SubjectDetailsEntity(
    id: "CE202",
    title: "Computer Organization",
    professorIntro: "Dr. Yara Suleiman has extensive experience...",
    professorName: "Dr. Yara Suleiman",
    subjectDescription: "Introduction to computer organization...",
    semester: "Second Semester",
    isPassed: false, // Failed - no grades
    midTermGrade: null,
    finalGrade: null,
    canEnroll: true,
    doesHaveALab: true,
    isMultipleChoice: true,
    materials: [
      MaterialEntity(
          title: "Computer Architecture PDF",
          fileUrl: "http://example.com/comp-arch.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[1],
  ),
  SubjectDetailsEntity(
    id: "CE301",
    title: "Operating Systems",
    professorIntro: "Dr. Khaled Al-Ahmad is a systems programming expert...",
    professorName: "Dr. Khaled Al-Ahmad",
    subjectDescription: "Operating system concepts...",
    semester: "First Semester",
    isPassed: true,
    midTermGrade: 24, // 24/30 (80%)
    finalGrade: 55, // 55/70 (79%) - Total: 79
    canEnroll: true,
    doesHaveALab: true,
    isMultipleChoice: false,
    materials: [
      MaterialEntity(
          title: "OS Concepts Slides",
          fileUrl: "http://example.com/os-slides.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[3],
  ),
  SubjectDetailsEntity(
    id: "CE302",
    title: "Database Systems",
    professorIntro: "Dr. Lina Al-Hassan is a database specialist...",
    professorName: "Dr. Lina Al-Hassan",
    subjectDescription: "Introduction to database systems...",
    semester: "Second Semester",
    isPassed: false, // Failed
    midTermGrade: 20, // 20/30 (67%)
    finalGrade: 38, // 38/70 (54%) - Total: 58
    canEnroll: false,
    doesHaveALab: true,
    isMultipleChoice: false,
    materials: [
      MaterialEntity(
          title: "Database Design Textbook",
          fileUrl: "http://example.com/db-design.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[3],
  ),
  SubjectDetailsEntity(
    id: "CE401",
    title: "Computer Networks",
    professorIntro: "Dr. Ali Al-Sayed has worked as a network engineer...",
    professorName: "Dr. Ali Al-Sayed",
    subjectDescription: "Fundamentals of computer networking...",
    semester: "First Semester",
    isPassed: true,
    midTermGrade: 22, // 22/30 (73%)
    finalGrade: 45, // 45/70 (64%) - Total: 67
    canEnroll: true,
    doesHaveALab: true,
    isMultipleChoice: true,
    materials: [
      MaterialEntity(
          title: "Networking Basics",
          fileUrl: "http://example.com/networking-basics.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[2],
  ),
  SubjectDetailsEntity(
    id: "CE402",
    title: "Artificial Intelligence",
    professorIntro: "Dr. Hala Ibrahim is a machine learning researcher...",
    professorName: "Dr. Hala Ibrahim",
    subjectDescription: "Introduction to AI concepts...",
    semester: "Second Semester",
    isPassed: false, // Failed - only midterm
    midTermGrade: 15, // 15/30 (50%)
    finalGrade: null, // Missed final exam
    canEnroll: true,
    doesHaveALab: true,
    isMultipleChoice: false,
    materials: [
      MaterialEntity(
          title: "AI Fundamentals",
          fileUrl: "http://example.com/ai-fundamentals.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[1],
  ),
  SubjectDetailsEntity(
    id: "CE203",
    title: "Algorithms Analysis",
    professorIntro: "Dr. Mahmoud Al-Khatib is an algorithms expert...",
    professorName: "Dr. Mahmoud Al-Khatib",
    subjectDescription: "Analysis of algorithms...",
    semester: "Second Semester",
    isPassed: true,
    midTermGrade: 10, // 10/30 (33%)
    finalGrade: 55, // 55/70 (79%) - Total: 65 (passed despite weak midterm)
    canEnroll: false,
    doesHaveALab: false,
    isMultipleChoice: false,
    materials: [
      MaterialEntity(
          title: "Algorithm Design Manual",
          fileUrl: "http://example.com/algo-manual.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[0],
  ),
  SubjectDetailsEntity(
    id: "CE303",
    title: "Software Engineering",
    professorIntro: "Dr. Rana Al-Hussein has industry experience...",
    professorName: "Dr. Rana Al-Hussein",
    subjectDescription: "Software development lifecycle...",
    semester: "First Semester",
    isPassed: false, // Failed
    midTermGrade: 8, // 8/30 (27%)
    finalGrade: 30, // 30/70 (43%) - Total: 38
    canEnroll: true,
    doesHaveALab: true,
    isMultipleChoice: true,
    materials: [
      MaterialEntity(
          title: "Software Engineering Principles",
          fileUrl: "http://example.com/se-principles.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[0],
  ),
  SubjectDetailsEntity(
    id: "CE304",
    title: "Computer Graphics",
    professorIntro: "Dr. Wael Al-Malik is a computer graphics specialist...",
    professorName: "Dr. Wael Al-Malik",
    subjectDescription: "Fundamentals of computer graphics...",
    semester: "Second Semester",
    isPassed: true,
    midTermGrade: 20, // 20/30 (67%)
    finalGrade: 45, // 45/70 (64%) - Total: 65
    canEnroll: true,
    doesHaveALab: true,
    isMultipleChoice: false,
    materials: [
      MaterialEntity(
          title: "OpenGL Programming Guide",
          fileUrl: "http://example.com/opengl-guide.pdf",
          type: MaterialType.pdf),
    ],
    imageUrl: dummyImages[3],
  ),
];
final List<NewsEntity> fullAnnouncements = [
  NewsEntity(
    id: '124  ',
    title: 'Midterm Exam Schedule - Computer Engineering Department',
    description:
        'The Computer Engineering Department is announcing the official midterm exam schedule for the Spring 2025 semester. All exams will take place between May 20th and May 31st in various halls across the main campus building. First-year students should note that their Programming Fundamentals exam will be held on May 20th at 9:00 AM in Hall A. Second-year students will have their Data Structures exam on May 22nd at 11:00 AM in Hall B. Third-year students should prepare for their Computer Networks exam scheduled for May 25th at 2:00 PM in Lab 3. Final year students will take their Database Systems exam on May 28th at 10:00 AM in Hall C. Each exam will last exactly 2 hours with no extensions allowed. Students must bring their university ID cards for verification - no exceptions will be made for those who forget their IDs. Electronic devices including phones, smartwatches, and calculators are strictly prohibited in exam halls. The department has arranged special study sessions with teaching assistants every evening from 5-7 PM in the library annex building during the exam period. Students with special needs should contact the department office at least 3 days before their scheduled exams to arrange necessary accommodations. The complete exam schedule with room assignments for all courses is available on the university portal and posted on the department notice board. Good luck to all students in your exams!',
    image: [
      dummyImages[0],
      dummyImages[1],
      dummyImages[2],
      dummyImages[3],
    ],
    createdAt: '2025-5-17 10:32 pm',
  ),
  NewsEntity(
    id: '522',
    title: 'Advanced Artificial Intelligence Workshop Series',
    description:
        'The Computer Engineering Department in collaboration with the Aleppo Tech Society is proud to announce a comprehensive workshop series on Artificial Intelligence and Machine Learning applications. This three-day intensive program will run from May 27th to May 29th in Hall 4 of the central campus. Each day will focus on different aspects of AI technology: Day 1 covers fundamental machine learning concepts and Python implementations, Day 2 explores neural networks and deep learning frameworks, while Day 3 features real-world case studies and project implementations. We are honored to have Dr. Ahmed Hassan, senior AI researcher at TechCorp, as our keynote speaker for the opening session. The workshop includes hands-on coding sessions where participants will work on actual datasets to build predictive models. Limited seats are available, so interested students should register through the university portal by May 25th. There is no participation fee for Aleppo University students, but registration is mandatory. Participants who attend all three sessions will receive a certificate of completion. Bring your laptops with Python 3.8 or higher installed for the practical sessions. Coffee breaks and light refreshments will be provided during intermissions. For any questions, please contact the Computer Engineering office or visit our AI workshop information desk in the main building lobby.',
    image: [
      dummyImages[1],
      dummyImages[2],
      dummyImages[3],
    ],
    createdAt: '2025-5-16 09:15 pm',
  ),
  NewsEntity(
    id: '323',
    title: 'Library Extended Hours During Examination Period',
    description:
        'To accommodate students during the upcoming examination period, the central university library will extend its operating hours from May 15th through June 5th. The library will now remain open daily from 7:00 AM until 11:00 PM, including weekends. Additional study spaces have been arranged in the adjacent Building 3, where classrooms 301-310 will be available as quiet study areas from 6:00 PM onwards. The computer lab in the engineering wing will also extend its hours until midnight exclusively for computer engineering students working on projects. Please note that the extended hours apply only to study areas - library services like book checkout and research assistance will maintain normal hours until 7:00 PM. Security personnel will be present during all extended hours, and students must show their ID cards when entering after 8:00 PM. The library café will offer discounted coffee and snacks during exam weeks. Group study rooms can be reserved in advance at the circulation desk. The library has acquired 50 additional copies of frequently referenced textbooks which will be available for 2-hour in-library use only. Noise levels must be kept to a minimum during extended hours, and any disruptive behavior will result in immediate expulsion from the premises. We wish all students success in their upcoming examinations.',
    image: [
      dummyImages[2],
      dummyImages[3],
      dummyImages[0],
      dummyImages[1],
    ],
    createdAt: '2025-5-15 03:45 pm',
  ),
  NewsEntity(
    id: '23',
    title: 'Library Extended Hours During Examination Period',
    description:
        'To accommodate students during the upcoming examination period, the central university library will extend its operating hours from May 15th through June 5th. The library will now remain open daily from 7:00 AM until 11:00 PM, including weekends. Additional study spaces have been arranged in the adjacent Building 3, where classrooms 301-310 will be available as quiet study areas from 6:00 PM onwards. The computer lab in the engineering wing will also extend its hours until midnight exclusively for computer engineering students working on projects. Please note that the extended hours apply only to study areas - library services like book checkout and research assistance will maintain normal hours until 7:00 PM. Security personnel will be present during all extended hours, and students must show their ID cards when entering after 8:00 PM. The library café will offer discounted coffee and snacks during exam weeks. Group study rooms can be reserved in advance at the circulation desk. The library has acquired 50 additional copies of frequently referenced textbooks which will be available for 2-hour in-library use only. Noise levels must be kept to a minimum during extended hours, and any disruptive behavior will result in immediate expulsion from the premises. We wish all students success in their upcoming examinations.',
    image: [
      dummyImages[3],
      dummyImages[0],
      dummyImages[1],
      dummyImages[2],
    ],
    createdAt: '2025-5-15 03:45 pm',
  ),
  NewsEntity(
    id: '13',
    title: 'Library Extended Hours During Examination Period',
    description:
        'To accommodate students during the upcoming examination period, the central university library will extend its operating hours from May 15th through June 5th. The library will now remain open daily from 7:00 AM until 11:00 PM, including weekends. Additional study spaces have been arranged in the adjacent Building 3, where classrooms 301-310 will be available as quiet study areas from 6:00 PM onwards. The computer lab in the engineering wing will also extend its hours until midnight exclusively for computer engineering students working on projects. Please note that the extended hours apply only to study areas - library services like book checkout and research assistance will maintain normal hours until 7:00 PM. Security personnel will be present during all extended hours, and students must show their ID cards when entering after 8:00 PM. The library café will offer discounted coffee and snacks during exam weeks. Group study rooms can be reserved in advance at the circulation desk. The library has acquired 50 additional copies of frequently referenced textbooks which will be available for 2-hour in-library use only. Noise levels must be kept to a minimum during extended hours, and any disruptive behavior will result in immediate expulsion from the premises. We wish all students success in their upcoming examinations.',
    image: [
      dummyImages[3],
      dummyImages[0],
      dummyImages[1],
      dummyImages[2],
    ],
    createdAt: '2025-5-15 03:45 pm',
  ),
  NewsEntity(
    id: '34',
    title: 'Library Extended Hours During Examination Period',
    description:
        'To accommodate students during the upcoming examination period, the central university library will extend its operating hours from May 15th through June 5th. The library will now remain open daily from 7:00 AM until 11:00 PM, including weekends. Additional study spaces have been arranged in the adjacent Building 3, where classrooms 301-310 will be available as quiet study areas from 6:00 PM onwards. The computer lab in the engineering wing will also extend its hours until midnight exclusively for computer engineering students working on projects. Please note that the extended hours apply only to study areas - library services like book checkout and research assistance will maintain normal hours until 7:00 PM. Security personnel will be present during all extended hours, and students must show their ID cards when entering after 8:00 PM. The library café will offer discounted coffee and snacks during exam weeks. Group study rooms can be reserved in advance at the circulation desk. The library has acquired 50 additional copies of frequently referenced textbooks which will be available for 2-hour in-library use only. Noise levels must be kept to a minimum during extended hours, and any disruptive behavior will result in immediate expulsion from the premises. We wish all students success in their upcoming examinations.',
    image: [
      dummyImages[1],
      dummyImages[2],
      dummyImages[3],
      dummyImages[0],
    ],
    createdAt: '2025-5-15 03:45 pm',
  ),
  NewsEntity(
    id: '93',
    title: 'Library Extended Hours During Examination Period',
    description:
        'To accommodate students during the upcoming examination period, the central university library will extend its operating hours from May 15th through June 5th. The library will now remain open daily from 7:00 AM until 11:00 PM, including weekends. Additional study spaces have been arranged in the adjacent Building 3, where classrooms 301-310 will be available as quiet study areas from 6:00 PM onwards. The computer lab in the engineering wing will also extend its hours until midnight exclusively for computer engineering students working on projects. Please note that the extended hours apply only to study areas - library services like book checkout and research assistance will maintain normal hours until 7:00 PM. Security personnel will be present during all extended hours, and students must show their ID cards when entering after 8:00 PM. The library café will offer discounted coffee and snacks during exam weeks. Group study rooms can be reserved in advance at the circulation desk. The library has acquired 50 additional copies of frequently referenced textbooks which will be available for 2-hour in-library use only. Noise levels must be kept to a minimum during extended hours, and any disruptive behavior will result in immediate expulsion from the premises. We wish all students success in their upcoming examinations.',
    image: [
      dummyImages[2],
      dummyImages[3],
      dummyImages[0],
      dummyImages[1],
    ],
    createdAt: '2025-5-15 03:45 pm',
  ),
  NewsEntity(
    id: '10',
    title: 'Library Extended Hours During Examination Period',
    description:
        'To accommodate students during the upcoming examination period, the central university library will extend its operating hours from May 15th through June 5th. The library will now remain open daily from 7:00 AM until 11:00 PM, including weekends. Additional study spaces have been arranged in the adjacent Building 3, where classrooms 301-310 will be available as quiet study areas from 6:00 PM onwards. The computer lab in the engineering wing will also extend its hours until midnight exclusively for computer engineering students working on projects. Please note that the extended hours apply only to study areas - library services like book checkout and research assistance will maintain normal hours until 7:00 PM. Security personnel will be present during all extended hours, and students must show their ID cards when entering after 8:00 PM. The library café will offer discounted coffee and snacks during exam weeks. Group study rooms can be reserved in advance at the circulation desk. The library has acquired 50 additional copies of frequently referenced textbooks which will be available for 2-hour in-library use only. Noise levels must be kept to a minimum during extended hours, and any disruptive behavior will result in immediate expulsion from the premises. We wish all students success in their upcoming examinations.',
    image: [
      dummyImages[3],
      dummyImages[0],
      dummyImages[1],
      dummyImages[2],
    ],
    createdAt: '2025-5-15 03:45 pm',
  ),
];

final List<NewsEntity> shortAnnouncements = [
  NewsEntity(
    id: '4',
    title: 'Lecture Postponement',
    description:
        'The Programming lecture has been postponed to the scheduled time.',
    image: null,
    createdAt: '2025-5-17 08:20 pm',
  ),
  NewsEntity(
    id: '5',
    title: 'Lab Cancellation',
    description: 'The Programming lab has been cancelled.',
    image: null,
    createdAt: '2025-5-16 11:10 am',
  ),
  NewsEntity(
    id: '6',
    title: 'Library Maintenance',
    description:
        'The central library will be closed tomorrow for maintenance work. The central library will be closed tomorrow for maintenance work. ',
    image: null,
    createdAt: '2025-5-15 04:30 pm',
  ),
  NewsEntity(
    id: '7',
    title: 'Student Meeting',
    description:
        'There will be a meeting for all 3rd year students next Wednesday at 11:00 AM.',
    image: null,
    createdAt: '2025-5-14 09:00 pm',
  ),
  NewsEntity(
    id: '8',
    title: 'Course Registration',
    description:
        'The deadline for course registration has been extended until Friday.',
    image: null,
    createdAt: '2025-5-13 02:15 pm',
  ),
];
final GradesResponseEntity mockedGradesResponse = GradesResponseEntity(
  grades: mockedGrades,
  numberOfPassedSubjects: 5,
  numberOfFailedSubjects: 2,
  averageGrade: 75.0,
);
final List<GradeEntity> mockedGrades = [
  GradeEntity(
    subjectName: 'Programming Fundamentals',
    subjectYear: 1,
    subjectSemester: 1,
    midTermGrade: 22,
    finalTermGrade: 58,
    isPassed: true, // Total: 80 (Pass)
  ),
  GradeEntity(
    subjectName: 'Discrete Mathematics',
    subjectYear: 1,
    subjectSemester: 2,
    midTermGrade: 18,
    finalTermGrade: 39,
    isPassed: false, // Total: 57 (Pass)
  ),
  GradeEntity(
    subjectName: 'Data Structures',
    subjectYear: 2,
    subjectSemester: 1,
    midTermGrade: 25,
    finalTermGrade: 33,
    isPassed: false, // Total: 53 ()
  ),
  GradeEntity(
    subjectName: 'Computer Organization',
    subjectYear: 2,
    subjectSemester: 2,
    midTermGrade: 21,
    finalTermGrade: 52,
    isPassed: true, // Total: 73 (Good)
  ),
  GradeEntity(
    subjectName: 'Advanced Calculus',
    subjectYear: 3,
    subjectSemester: 1,
    midTermGrade: 15,
    finalTermGrade: 42,
    isPassed: false, // Total: 57 (Fail)
  ),
  GradeEntity(
    subjectName: 'Operating Systems',
    subjectYear: 3,
    subjectSemester: 1,
    midTermGrade: 27,
    finalTermGrade: 56,
    isPassed: true, // Total: 83 (Very Good)
  ),
  GradeEntity(
    subjectName: 'Artificial Intelligence',
    subjectYear: 4,
    subjectSemester: 2,
    midTermGrade: 24,
    finalTermGrade: 65,
    isPassed: true, // Total: 89 (Excellent)
  ),
  GradeEntity(
    subjectName: 'Computer Networks',
    subjectYear: 4,
    subjectSemester: 2,
    midTermGrade: 19,
    finalTermGrade: 59,
    isPassed: true, // Total: 78 (Good)
  ),
  GradeEntity(  
    subjectName: 'Database Systems',
    subjectYear: 4,
    subjectSemester: 2,
    midTermGrade: 20,
    finalTermGrade: 47,
    isPassed:
        false, // Total: 67 (Pass) - but marked as failed for demonstration
  ),
];
