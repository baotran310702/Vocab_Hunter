import 'package:english_learner/presentations/home/home.dart';
import 'package:flutter/material.dart';
import 'package:english_learner/presentations/dictionary_page/dictionary_page.dart';
import 'package:english_learner/presentations/user_profile/user_profile.dart';
import 'package:english_learner/presentations/user_vocabulary/user_vocabulary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pageController = PageController(initialPage: 0);
  int maxCount = 4;
  int _selectedIndex = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomePage(),
    const UserVocabulary(),
    const DictionaryPage(),
    const UserProfile(),
  ];

  /// on item tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: bottomBarPages,
          onPageChanged: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Your Vocab',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Dictionary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          iconSize: 32,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.amber[400],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
