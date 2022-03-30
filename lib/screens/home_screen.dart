// import 'package:chronos_health/screens/dashboard_screen.dart';
// import 'package:chronos_health/screens/doctor_screen/doctor_dashboard.dart';
// import 'package:chronos_health/screens/doctor_screen/doctor_search.dart';
// import 'package:chronos_health/screens/doctor_screen/record_vitals_screen.dart';
// import 'package:chronos_health/screens/medication_screen.dart';
// import 'package:chronos_health/screens/schedule_screen.dart';
// import 'package:chronos_health/screens/search_screen.dart';
// import 'package:chronos_health/utils/colors.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   static const TextStyle optionStyle = TextStyle(
//     fontSize: 30,
//     fontWeight: FontWeight.bold,
//   );
//   static List<Widget> _widgetOptions = <Widget> [
//     DashBoardScreen(),
//     SearchScreen(),
//     ScheduleScreen(),
//     MedicationScreen()
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         unselectedItemColor: secondaryColor,
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search_outlined),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today_outlined),
//             label: 'Schedule',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.medication_outlined),
//             label: 'Medication',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: primaryColor,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
