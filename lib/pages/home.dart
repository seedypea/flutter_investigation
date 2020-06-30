import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:investigation/locale/localisations.dart';
import 'package:investigation/themes/font_icons.dart' as FontIcon;
import 'package:investigation/pages/camera.dart';
import 'package:investigation/pages/settings.dart';
import 'package:investigation/pages/user_list.dart';

/// HomePage
class HomePage extends StatefulWidget {

  static const String route = '/home';

  // ctr
  const HomePage({
    Key key
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin<HomePage> {

  AnimationController _hideBottomNavigationBar;
  int _currentIndex = 0;

  List<PrimaryNavigation> navigationItems() {

    return <PrimaryNavigation>[
      // dashboard
      PrimaryNavigation(0, Localisations.of(context).dashboardTitle, FontIcon.Icons.dashboard_outline, UserListPage()),
      // community
      PrimaryNavigation(1, Localisations.of(context).communityTitle, FontIcon.Icons.community_outline, CameraPage()),
      // settings
      PrimaryNavigation(2, Localisations.of(context).settingsTitle, FontIcon.Icons.settings_outline, SettingsPage()),
    ];

  }

  Widget bottomNav() {

    List<BottomNavigationBarItem> navItems = List<BottomNavigationBarItem>();

    navigationItems().forEach(
      (navItem) { 
        navItems.add(
          BottomNavigationBarItem(
            icon: Icon(navItem.icon), 
            title: Text(navItem.title)
          )
        ); 
      }
    );

    // BottomNavigationBar default has different font sizes for (un)selected
    // https://api.flutter.dev/flutter/material/BottomNavigationBar/BottomNavigationBar.html
    final double fontSize = 12;

    return BottomNavigationBar(
      selectedFontSize: fontSize,
      unselectedFontSize: fontSize,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).accentColor,
      items: navItems,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },      
    );

  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            _hideBottomNavigationBar.forward();
            break;
          case ScrollDirection.reverse:
            _hideBottomNavigationBar.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();

    _hideBottomNavigationBar = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }  

  @override
  void dispose() {
    _hideBottomNavigationBar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: navigationItems()[_currentIndex].view,
        bottomNavigationBar: ClipRect(
          child: SizeTransition(
            sizeFactor: _hideBottomNavigationBar, 
            axisAlignment: -1.0, 
            child: bottomNav()
          )
        )
      )
    );

  }  

}

class PrimaryView {

  // ctr
  const PrimaryView(this.index, this.view);

  // properties

  final int index;
  final Widget view;  

}

class PrimaryNavigation {

  // ctr
  const PrimaryNavigation(this.index, this.title, this.icon, this.view);

  // properties

  final int index;
  final String title;
  final IconData icon;
  final Widget view;

}