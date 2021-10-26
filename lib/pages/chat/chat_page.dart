import 'dart:convert';

import 'package:flutter/material.dart';
import '../const.dart';
import 'package:http/http.dart' as http;
import 'chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin<ChatPage> {
  late AnimationController _controller;

  List<Chat> _chatList = [];
  bool _cancelConnect = false;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // getData();
    getData().then((List<Chat>? value) {
      if (!_cancelConnect) {
        setState(() {
          _chatList = value!;
        });
      }
    }).catchError((onError) {
      print(onError);
    }).whenComplete(() {
      print('完成');
    }).timeout(Duration(milliseconds: 1000)).catchError((timeoutError) {
      _cancelConnect = true;
      print('timeoutErrot: ${timeoutError}');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<Chat>?> getData() async {
    _cancelConnect = false;
    var response = await http
        .get(Uri.parse('http://rap2api.taobao.org/app/mock/data/2113476'));
    if (response.statusCode == 200) {
      final responseMap = json.decode(response.body);
      List<Chat> chatList = responseMap['chatlist'].map<Chat>((item) {
        return Chat.fromMap(item);
      }).toList();
      return chatList;
    } else {
      throw Exception('statusCode: ${response.statusCode}');
    }
  }

  PopupMenuItem _buildMenuItem(String imageName, String title) {
    return PopupMenuItem(
      value: {
        'imageName': imageName,
        'title': title,
      },
      child: Row(
        children: [
          Image(
            image: AssetImage(imageName),
            width: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text(
          '微信',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 25,
              child: PopupMenuButton(
                color: Colors.red,
                onSelected: (item) {
                  print(item);
                },
                onCanceled: () {
                  print('inCanceled');
                },
                offset: const Offset(0, 60),
                child: const Image(
                  image: AssetImage('images/圆加.png'),
                  width: 25,
                  height: 25,
                ),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem>[
                    _buildMenuItem('images/发起群聊.png', '发起群聊'),
                    _buildMenuItem('images/添加朋友.png', '添加朋友'),
                    _buildMenuItem('images/扫一扫1.png', '扫一扫'),
                    _buildMenuItem('images/收付款.png', '收付款'),
                  ];
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: _chatList.length == 0
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _chatList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_chatList[index].name),
                    subtitle: Container(
                      height: 20,
                      width: 20,
                      child: Text(
                        _chatList[index].message,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_chatList[index].imageUrl),
                    ),
                  );
                },
              ),
      ),
      // FutureBuilder(
      //   future: getData(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.hasError) {
      //         return Center(child: Text('Error:${snapshot.error}'),);
      //       } else {
      //         return ListView(
      //           children: snapshot.data.map<Widget>((item) {
      //             return ListTile(
      //               title: Text(item.name),
      //               subtitle: Container(
      //                 height: 20,
      //                 width: 20,
      //                 child: Text(
      //                   item.message,
      //                   overflow: TextOverflow.ellipsis,
      //                 ),
      //               ),
      //               leading: CircleAvatar(
      //                 backgroundImage: NetworkImage(item.imageUrl),
      //               ),
      //             );
      //           }).toList(),
      //         );
      //       }
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
