import 'dart:developer';

import 'package:chat_flutter/main.dart';
import 'package:chat_flutter/src/models/message.dart';
import 'package:chat_flutter/src/pages/chats/message/message_controller.dart';
import 'package:chat_flutter/src/util/bubble.dart';
import 'package:chat_flutter/src/util/relative_time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePage extends StatelessWidget {
  MessageController controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 246, 248, 1),
      body: Obx(
        () => Column(
          children: [
            customAppbar(),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 30,
                ),
                child: ListView(
                  children: getMessages(),
                ),
              ),
            ),
            messageBox(context),
          ],
        ),
      ),
    );
  }

  List<Widget> getMessages() {
    return controller.messages.map((message) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        alignment: message.idSender == controller.myUser.id
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: bubbleMessage(message),
      );
    }).toList();
  }

  Widget bubbleMessage(Message message) {
    return Bubble(
      message: message.message ?? '',
      delivered: true,
      isMe: message.idSender == myUser.id ? true : false,
      status: message.status ?? 'ENVIADO',
      time: RelativeTimeUtil.getRelativeTime(message.timestamp ?? 0),
    );
  }

  Widget messageBox(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 15,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.image_outlined,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.video_call_rounded,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: TextField(
              controller: controller.messageController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Escribe tu mensaje..',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () => controller.sendMessage(),
              icon: Icon(
                Icons.send,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customAppbar() {
    return SafeArea(
      child: ListTile(
        title: Text(
          '${controller.userChat.name ?? ''} ${controller.userChat.lastname ?? ''}',
          style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Desconectado',
          style: TextStyle(color: Colors.grey),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        trailing: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/img/user_profile_2.png',
                image:
                    'https://smoda.elpais.com/wp-content/uploads/2020/06/bob-esponja.jpg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
