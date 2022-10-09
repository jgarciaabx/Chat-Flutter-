import 'dart:developer';

import 'package:chat_flutter/src/models/chat.dart';
import 'package:chat_flutter/src/models/message.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/user.dart';
import 'package:chat_flutter/src/pages/home/home_controller.dart';
import 'package:chat_flutter/src/providers/chats_provider.dart';
import 'package:chat_flutter/src/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MessageController extends GetxController {
  TextEditingController messageController = TextEditingController();

  User userChat = User.fromJson(Get.arguments['user']);
  User myUser = User.fromJson(GetStorage().read('user') ?? {});

  ChatsProvider chatsProvider = ChatsProvider();
  MessageProvider messageProvider = MessageProvider();

  String idChat = '';
  List<Message> messages = <Message>[].obs; //observable

  HomeController homeController = Get.find();

  MessageController() {
    print('Usuario de chat: ${userChat.toJson()}');
    createChat();
  }
  void listenMessage() {
    homeController.socket.on('message/$idChat', (data) {
      print('data emitida $data');
      getMessages();
    });
  }

  void emitMessage() {
    homeController.socket.emit('message', {'id_chat': idChat});
  }

  void getMessages() async {
    var result = await messageProvider.getMessages(idChat);
    messages.clear();
    messages.addAll(result);
  }

  void createChat() async {
    Chat chat = Chat(
      idUser1: myUser.id,
      idUser2: userChat.id,
    );

    ResponseApi responseApi = await chatsProvider.create(chat);
    if (responseApi.succes == true) {
      idChat = responseApi.data as String;
      getMessages();
      listenMessage();
    }
  }

  void sendMessage() async {
    String messageText = messageController.text;
    if (messageText.isEmpty) {
      Get.snackbar('Texto Vacio', 'Ingrese un mensaje para enviar');
      return;
    }
    if (idChat == '') {
      Get.snackbar('Error', 'NO LLEGO EL ID CHAT >:V');
      return;
    }
    log('>>>>>>>> user chat  ${userChat.id}');
    log('>>>>>>>> Myuser chat  ${myUser.id}');

    Message message = Message(
      message: messageText,
      idSender: myUser.id,
      idReceiver: userChat.id,
      idChat: idChat,
      isImage: false,
      isVideo: false,
    );

    log('>>>>>>>> MESSAGE IDSENDER chat  ${message.idSender}');
    log('>>>>>>>> Myuser chat  ${myUser.id}');
    log('>>>>>>>> ');
    log('>>>>>>>> MESSAGE ID RECEIVER chat  ${message.idReceiver}');
    ResponseApi responseApi = await messageProvider.create(message);
    if (responseApi.succes == true) {
      messageController.text = '';
      emitMessage();
    }
  }
}
