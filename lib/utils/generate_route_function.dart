// import 'package:flutter/cupertino.dart';
// import 'package:settings_page/models/course_model.dart';
// import 'package:settings_page/utils/routes.dart';
// import 'package:settings_page/views/screens/course_info_screen/course_info_screen.dart';
// import 'package:settings_page/views/screens/main_screen/main_screen.dart';
// import 'package:settings_page/views/screens/profile_screen.dart';
//
// Route<dynamic> _generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case RouteNames.todoScreen:
//       return CupertinoPageRoute(
//         builder: (BuildContext context) => const TodoScreen(),
//       );
//     case RouteNames.admin:
//       return CupertinoPageRoute(
//         builder: (BuildContext context) => AdminPage(),
//       );
//     case RouteNames.courseInfo:
//       return CupertinoPageRoute(
//         builder: (BuildContext context) =>
//             CourseInfoScreen(course: settings.arguments as Course),
//       );
//     case RouteNames.mainScreen:
//       return CupertinoPageRoute(
//         builder: (BuildContext context) => MainScreen(),
//       );
//     case RouteNames.profileScreen:
//       return CupertinoPageRoute(
//         builder: (BuildContext context) => ProfileScreen(),
//       );
//     case RouteNames.onboarding:
//       return CupertinoPageRoute(
//         builder: (BuildContext context) => Onboarding(),
//       );
//     case RouteNames.resultScreen:
//       return CupertinoPageRoute(
//         builder: (BuildContext context) => ResultsScreen(),
//       );
//     case RouteNames.settingsScreen:
//       return CupertinoPageRoute(
//         builder: (BuildContext context) => SettingsScreen(),
//       );
//     default:
//       return CupertinoPageRoute(
//         builder: (BuildContext context) => HomeScreen(),
//       );
//   }
// }