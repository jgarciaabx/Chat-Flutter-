import 'dart:developer';

import 'package:chat_flutter/src/api/environment.dart';
import 'package:chat_flutter/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});

  var tabIndex = 0.obs; // QUE CAMBIA

  Socket socket = io('${Environment.API_CHAT}chat', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false
  });

  HomeController() {
    print('Usuario de Sesion: ${user.toJson()}');
    connectAndListen();
  }

  void connectAndListen() {
    // if (user.id != null) {
    socket.connect();
    socket.onConnect((data) {
      log('USUARIO CONECTADO A SOCKETIO');
    });
    // }
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onClose() {
    super.onClose();
    log('USUARIO DESCONECTADO A SOCKETIO');
    socket.disconnect();
  }
}
