import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:ghiras/Page/specialist/CalendarScreen.dart';
import 'package:ghiras/Page/specialist/ReportScreen.dart';
import 'package:ghiras/Page/specialist/SpecialistHome.dart';
import 'package:ghiras/Page/specialist/managementOrder.dart';
import 'package:ghiras/Page/specialist/profile.dart';
import 'package:ghiras/Page/user/Camera.dart';
import 'package:ghiras/Page/user/HomeUser.dart';
import 'package:ghiras/Page/user/Leafbot.dart';
import 'package:ghiras/Page/user/OrderUser.dart';
import 'package:ghiras/Page/user/ProfileUser.dart';
import 'package:ghiras/widgets/extensions.dart';
import '../enum/Usertype.dart';
import '../widgets/assets.dart';
import 'admin/home.dart';
import 'admin/mewa.dart';
import 'admin/profile.dart';
import 'admin/specialist.dart';
import 'admin/users.dart';
import 'mewa/Pending.dart';
import 'mewa/Users.dart';
import 'mewa/account.dart';
import 'mewa/home.dart';
import 'mewa/profile.dart';

class TabBarItem {
  final String icon;
  final Widget page;

  TabBarItem(this.icon, this.page);
}

class HomePage extends StatefulWidget {
  final Object? userType;
  int? currentIndex;

  HomePage({super.key, this.userType, this.currentIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TabBarItem> tabItems = [];
  PageController _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: widget.currentIndex!);
    super.initState();
    switch (widget.userType) {
      case Usertype.admin:
        tabItems = [];
        tabItems.add(TabBarItem(Assets.shared.profile, const Profile()));
        tabItems.add(TabBarItem(Assets.shared.mewa, const mewa()));
        tabItems.add(TabBarItem(Assets.shared.home, const HomeAdmin()));
        tabItems.add(TabBarItem(Assets.shared.person, const users()));
        tabItems.add(TabBarItem(Assets.shared.users, const specialist_users()));
        break;
      case Usertype.mewa:
        tabItems = [];
        tabItems.add(TabBarItem(Assets.shared.profile, const profile()));
        tabItems.add(TabBarItem(Assets.shared.personAdd, const account()));
        tabItems.add(TabBarItem(Assets.shared.home, const HomeMewa()));
        tabItems.add(TabBarItem(Assets.shared.personPending, const Pending()));
        tabItems.add(TabBarItem(Assets.shared.users, const Users()));
        break;
      case Usertype.specialist:
        tabItems = [];
        tabItems.add(TabBarItem(Assets.shared.profile, const specialistProfile()));
        tabItems.add(TabBarItem(Assets.shared.appointment, const CalendarScreen()));
        tabItems.add(TabBarItem(Assets.shared.home, const SpecialistHome()));
        tabItems.add(TabBarItem(Assets.shared.requests, const managementOrder()));
        tabItems.add(TabBarItem(Assets.shared.reports, const ReportScreen()));
        break;
      case Usertype.user:
        tabItems = [];
        tabItems.add(TabBarItem(Assets.shared.profile, const ProfileUser()));
        tabItems.add(TabBarItem(Assets.shared.users, const Order()));
        tabItems.add(TabBarItem(Assets.shared.home, const HomeUser()));
        tabItems.add(TabBarItem(Assets.shared.rebot,  const Leafbot()));
        tabItems.add(TabBarItem(Assets.shared.camera,  const Camera()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: widget.currentIndex!,
        length: tabItems.length,
        child: Scaffold(
            body: PageView(
              controller: _pageController,
              children: _getChildrenTabBar(),
              onPageChanged: (index) {
                setState(() {
                  widget.currentIndex = index;
                });
              },
            ),
            bottomNavigationBar: SnakeNavigationBar.color(
              selectedItemColor: "#D1DFC8".toHexa(),
              elevation: 5,
              shadowColor: Colors.black,
              backgroundColor: Colors.white,
              behaviour: SnakeBarBehaviour.floating,
              snakeShape: SnakeShape.circle,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),
              padding: const EdgeInsets.all(10),
              snakeViewColor: Colors.white,
              unselectedItemColor: Colors.white,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              currentIndex: widget.currentIndex!,
              onTap: (index) {
                setState(() {
                  widget.currentIndex = index;
                });
                _pageController.animateToPage(widget.currentIndex!,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              items: _renderTaps(),
            )));
  }

  List<BottomNavigationBarItem> _renderTaps() {
    List<BottomNavigationBarItem> items = [];
    for (var i = 0; i < tabItems.length; i++) {
      BottomNavigationBarItem obj = BottomNavigationBarItem(
          icon: Image.asset(
        tabItems[i].icon,
        color:
            widget.currentIndex == i ? "#365133".toHexa() : "#D1DFC8".toHexa(),
      ));
      items.add(obj);
    }
    return items;
  }

  List<Widget> _getChildrenTabBar() {
    List<Widget> items = [];
    for (var item in tabItems) {
      items.add(item.page);
    }
    return items;
  }
}
