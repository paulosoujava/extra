import 'package:bubble/bubble.dart';
import 'package:extra/entity/messages.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/entity/talks.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final Talks talks;

  Chat(this.talks);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _chatController = TextEditingController();
    final List<Message> _messages = widget.talks.message;

    void _handleSubmit(String text) {
      _chatController.clear();
      Message message =
          Message(message: text, dateCreate: DateTime.now().toString());
      setState(() {
        _messages.insert(0, message);
      });
    }

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 10,
          centerTitle: false,
          title: Text(
            "${widget.talks.profile.name}",
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  "assets/images/avatar.png",
                  fit: BoxFit.contain,
                  height: 32,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) {
                    return _dialog((index % 2 == 0) ? true : false,
                        _messages[index].message);
                  },
                  itemCount: _messages.length,
                ),
              ),
              Divider(
                height: 1.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: _chatEnvironment(_chatController, _handleSubmit),
              )
            ],
          ),
        ));
  }

  _chatEnvironment(_chatController, _handleSubmit) {
    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                maxLines: 1,
                maxLength: 150,
                decoration: InputDecoration.collapsed(
                    hintText: "digite uma mensagem ..."),
                controller: _chatController,
                onSubmitted: _handleSubmit,
              ),
            ),
            Container(
              decoration: new BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0))),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (_chatController.text.isNotEmpty)
                      _handleSubmit(_chatController.text);
                  }),
            )
          ],
        ),
      ),
    );
  }

  _today() {
    return Bubble(
      alignment: Alignment.center,
      color: Color.fromARGB(255, 212, 234, 244),
      elevation: 1 * Utils().pixel(context),
      margin: BubbleEdges.only(top: 8.0),
      child: Text('TODAY', style: TextStyle(fontSize: 10)),
    );
  }

  _dialog(bool who, String txt) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    return (who)
        ? Bubble(
            alignment: Alignment.bottomRight,
            margin: BubbleEdges.only(top: 10),
            nip: BubbleNip.rightTop,
            color: Color.fromRGBO(225, 255, 199, 1.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                txt,
                textAlign: TextAlign.right,
              ),
            ),
          )
        : Bubble(
            alignment: Alignment.bottomLeft,
            margin: BubbleEdges.only(top: 10),
            nip: BubbleNip.leftTop,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(txt),
            ),
          );
  }
}
