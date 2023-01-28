import '../models/models.dart';
import '../pages/pages.dart';
import 'package:flutter/material.dart' hide Card;

import '../providers/providers.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _controller;

  @override
	void initState() {
    _controller = PageController(initialPage: _currentIndex, keepPage: true);
 		super.initState();
 	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            ExplorePage(),
            TodayPage(),
            SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        currentIndex: _currentIndex,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final provider = Providers.of<CardProvider>(context);
          final card = await Navigator.of(context)
              .pushNamed(Screens.ADD_CARD, arguments: Card.create());
          if (card is Card) provider.save(card);
        },
      ),
    );
  }
}
