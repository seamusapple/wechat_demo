import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/chat/chat.dart';
import 'package:wechat_demo/pages/const.dart';

class SearchPage extends StatefulWidget {
  final List<Chat> datas;

  const SearchPage({Key? key, required this.datas}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Chat> _models = [];

  String _searchKey = '';

  _searchText(String text) {
    if (text.length == 0) {
      _models.clear();
      setState(() {});
    } else {
      _models.clear();
      for (int i = 0; i < widget.datas.length; i++) {
        if (widget.datas[i].name.toLowerCase().contains(text)) {
          _models.add(widget.datas[i]);
        }
      }
      setState(() {});
    }
  }

  Widget _title(String text) {
    final normalStyle = TextStyle(color: Colors.black87);
    final highlightedStyle = TextStyle(color: Colors.green);

    List<TextSpan> list = [];
    List<String> strings = text.split(_searchKey);
    for (int i = 0; i < strings.length; i++) {
      final one = strings[i];
      if (one.isNotEmpty) {
        list.add(TextSpan(text: one, style: normalStyle));
      }
      if (i < strings.length - 1) {
        list.add(TextSpan(text: _searchKey, style: highlightedStyle));
      }
    }

    return RichText(text: TextSpan(children: list));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
      title: _title(_models[index].name),
      subtitle: Container(
        child: Text(
          _models[index].message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_models[index].imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(onChanged: (String text) {
            _searchKey = text;
            _searchText(text);
          }),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener(
                onNotification: (ScrollNotification note) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  return true;
                },
                child: ListView.builder(
                  itemCount: _models.length,
                  itemBuilder: _itemBuilder,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;

  _onChanged(String text) {
    widget.onChanged(text);
    if (text.length > 0) {
      _showClear = true;
      setState(() {});
    } else {
      _showClear = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: screenWidth(context) - 50,
                  height: 44,
                  margin: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    children: [
                      const Image(
                        image: AssetImage('images/?????????b.png'),
                        width: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onChanged: _onChanged,
                          cursorColor: Colors.green,
                          decoration: InputDecoration.collapsed(hintText: '??????'),
                        ),
                      ),
                      _showClear
                          ? GestureDetector(
                              onTap: () {
                                _controller.clear();
                                _onChanged('');
                              },
                              child: const Icon(
                                Icons.cancel,
                                size: 20,
                                color: Colors.grey,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text('??????',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
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
