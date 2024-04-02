import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/material.dart';
import 'model/MessageModel.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  static const kDefault = 15.0;
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final apiKey = 'AIzaSyC38wegJI4lw29sRvt9NcZwyqOX3X5Qgls';
  final messages = [MessageModel(true, 'Hi')];
  bool isAiTyping = false;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ChatGPT in Flutter'),
          leading: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage('Google_Icon.png'),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) => messages[index].isBot
                      ? botCard(index: index)
                      : userCard(index: index),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefault,
                    vertical: kDefault / 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(kDefault),
                      topLeft: Radius.circular(kDefault),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.23),
                        offset: const Offset(kDefault / 1.2, .5),
                        blurRadius: kDefault,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.12),
                      borderRadius: BorderRadius.circular(kDefault),
                    ),
                    child: TextFormField(
                      controller: messageController,
                      autofocus: true,
                      decoration: InputDecoration(
                        suffixIcon: isAiTyping
                            ? Transform.scale(
                                scale: 0.4,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 7,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    sendMessage();
                                  }
                                },
                                child: const Icon(Icons.send,
                                    size: kDefault * 1.6, color: Colors.blue),
                              ),
                        hintText: 'Enter question here',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.send,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter some question' : null,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Padding userCard({required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefault,
        vertical: kDefault,
      ),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(
                  left: kDefault / 2, right: kDefault * 3.6),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefault / 1.1,
                vertical: kDefault / 1.2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(kDefault * 1.8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.12),
                    offset: const Offset(.5, kDefault / 1.6),
                    blurRadius: kDefault * 2,
                  ),
                ],
              ),
              child: Text(messages[index].message.trim()),
            ),
          ),
        ],
      ),
    );
  }

  Padding botCard({required int index}) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefault,
          vertical: kDefault,
        ),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                backgroundImage: AssetImage('Google_Icon.png'),
                radius: 18,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(
                    right: kDefault / 2, left: kDefault * 3.6),
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefault / 1.1,
                  vertical: kDefault / 1.2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(kDefault * 1.8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.12),
                      offset: const Offset(kDefault / 1.2, kDefault / 2),
                      blurRadius: kDefault * 2,
                    ),
                  ],
                ),
                child: Text(messages[index].message.trim()),
              ),
            ),
          ],
        ),
      );

  void sendMessage() async {
    messages.add(
      MessageModel(false, messageController.text),
    );
    setState(() => isAiTyping = true);

    // final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final model = GenerativeModel(model: 'gemini-1.0-pro', apiKey: apiKey);
    final content = [Content.text(messageController.text)];
    final response = await model.generateContent(content);
    debugPrint('response.text :${response.text}');

    messageController.clear();
    setState(() {
      messages.add(
        MessageModel(true, response.text!),
      );
      isAiTyping = false;
      // for (MessageModel element in messages) {
      //   debugPrint(element.toString());
      //   debugPrint('element.message => ${element.message}');
      // }
    });
  }
}
