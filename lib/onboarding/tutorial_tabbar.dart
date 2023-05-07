import 'package:flutter/material.dart';
import 'tutorial_screen3.dart' as tu3;
import 'tutorial_screen2.dart' as tu2;
import 'tutorial_screen.dart' as tu1;

class TutorialTabbar extends StatefulWidget {
  const TutorialTabbar({Key? key}) : super(key: key);

  @override
  State<TutorialTabbar> createState() => _TutorialTabbarState();
}

class _TutorialTabbarState extends State<TutorialTabbar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          tu1.TutorialScreen(),
          tu2.TutorialScreen2(),
          tu3.TutorialScreen3()
        ],
      ),
    );
  }
}
