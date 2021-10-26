import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/chat/chat_page.dart';
import 'package:wechat_demo/pages/friends/friends_page.dart';
import 'package:wechat_demo/pages/mine/mine_page.dart';
import 'discover/discover_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _currentIndex = 0;
  final _pageController = PageController(initialPage: 0);

  void _onTap(int index) {
    _currentIndex = index;
    setState(() {});
    _pageController.jumpToPage(index);
  }

  List<BottomNavigationBarItem> navigationBarItemArray = [
    const BottomNavigationBarItem(
        icon: Image(width: 20, height: 20, image: AssetImage('images/tabbar_chat.png'),),
        activeIcon: Image(width: 20, height: 20, image: AssetImage('images/tabbar_chat_hl.png'),),
        label: '微信'
    ),
    const BottomNavigationBarItem(
        icon: Image(width: 20, height: 20, image: AssetImage('images/tabbar_friends.png'),),
        activeIcon: Image(width: 20, height: 20, image: AssetImage('images/tabbar_friends_hl.png'),),
        label: '通讯录'
    ),
    const BottomNavigationBarItem(
        icon: Image(width: 20, height: 20, image: AssetImage('images/tabbar_discover.png'),),
        activeIcon: Image(width: 20, height: 20, image: AssetImage('images/tabbar_discover_hl.png'),),
        label: '发现'
    ),
    const BottomNavigationBarItem(
        icon: Image(width: 20, height: 20, image: AssetImage('images/tabbar_mine.png'),),
        activeIcon: Image(width: 20, height: 20, image: AssetImage('images/tabbar_mine_hl.png'),),
        label: '我'
    )
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageArray = [
      const ChatPage(),
      const FriendsPage(),
      const DiscoverPage(),
      const MinePage()
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.green,
        currentIndex: _currentIndex,
        selectedFontSize: 12.0,
        onTap: _onTap,
        items: navigationBarItemArray,
      ),
      body: PageView(
        // onPageChanged: (int index) {
        //   setState(() {
        //     _currentIndex = index;
        //   });
        // },
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: pageArray,
      ),
    );
  }
}
