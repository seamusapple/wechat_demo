import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/discover/discover_child_page.dart';
import 'package:wechat_demo/pages/friends/friends_data.dart';

import '../const.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    datas.sort((Friends a, Friends b) {
      return a.indexLetter!.compareTo(b.indexLetter!);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _cellForRow(BuildContext context, int index) {
    if (index < addressBooks.length) {
      final one = addressBooks[index];
      return _FriendLocalCell(imageName: one.imageName, title: one.title);
    }

    final two = datas[index - addressBooks.length];
    if (index - addressBooks.length == 0) {
      return _FriendNetworkCell(imageUrl: two.imageUrl, name: two.name, groupTitle: two.indexLetter,);
    } else {
      final three = datas[index - addressBooks.length - 1];
      if (two.indexLetter == three.indexLetter) {
        return _FriendNetworkCell(imageUrl: two.imageUrl, name: two.name);
      } else {
        return _FriendNetworkCell(imageUrl: two.imageUrl, name: two.name, groupTitle: two.indexLetter,);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text('通讯录', style: TextStyle(color: Colors.black87),),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              print('添加好友');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const DiscoverChildPage(title: '添加好友')));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Image(
                image: AssetImage('images/icon_friends_add.png'),
                width: 30,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: themeColor,
        child: ListView.builder(
            itemCount: addressBooks.length + datas.length,
            itemBuilder: _cellForRow
        ),
      ),
    );
  }
}

class _FriendLocalCell extends StatelessWidget {
  final String imageName;
  final String title;

  const _FriendLocalCell({
    Key? key,
    required this.imageName,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(image: AssetImage(imageName)),
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18),
                  ),
                  height: 53.5,
                  width: screenWidth(context) - 54,
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  color: themeColor,
                  width: screenWidth(context) - 54,
                  height: .5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendNetworkCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? groupTitle;

  const _FriendNetworkCell({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.groupTitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: groupTitle == null ? 0 : 30,
            child: groupTitle == null ? null : Text(groupTitle!, style: TextStyle(fontSize: 20, color: Colors.grey),),
            alignment: Alignment.centerLeft,
            color: themeColor,
            padding: const EdgeInsets.only(left: 10),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(image: NetworkImage(imageUrl)),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text(name, style: const TextStyle(fontSize: 18),),
                        height: 53.5,
                        width: screenWidth(context) - 54,
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        color: themeColor,
                        width: screenWidth(context) - 54,
                        height: .5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
