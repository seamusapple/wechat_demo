import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/discover/discover_cell.dart';

import '../const.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Widget _headerCell() {
    return Container(
      color: Colors.white,
      height: 200,
      child: Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(image: AssetImage('images/Hank.png')),
                ),
              ),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: const [
                              Text('Hank', style: TextStyle(fontSize: 28),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('微信号:123455', style: TextStyle(fontSize: 20, color: Colors.grey),),
                              Image(image: AssetImage('images/icon_right.png'), width: 15,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              color: themeColor,
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    children: [
                      _headerCell(),
                      const SizedBox(height: 10,),
                      const DiscoverCell(title: '支付', imageName: 'images/微信 支付.png'),
                      const SizedBox(height: 10,),
                      const DiscoverCell(title: '收藏', imageName: 'images/微信收藏.png'),
                      Row(children: [Container(color: Colors.white, width: 50, height: 0.5,)],),
                      const DiscoverCell(title: '相册', imageName: 'images/微信相册.png'),
                      Row(children: [Container(color: Colors.white, width: 50, height: 0.5,)],),
                      const DiscoverCell(title: '卡包', imageName: 'images/微信卡包.png'),
                      Row(children: [Container(color: Colors.white, width: 50, height: 0.5,)],),
                      const DiscoverCell(title: '表情', imageName: 'images/微信表情.png'),
                      const SizedBox(height: 10,),
                      const DiscoverCell(title: '设置', imageName: 'images/微信设置.png'),
                    ],
                  ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: 25,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Image(
                        image: AssetImage('images/相机.png'),
                      ),
                      onTap: () {
                        print('点击了拍照');
                      },
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}
