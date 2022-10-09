import 'package:chat_flutter/src/api/environment.dart';
import 'package:chat_flutter/src/models/chat.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatsProvider extends GetConnect {
  String url = Environment.API_CHAT + 'api/chats';

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponseApi> create(Chat chat) async {
    Response response = await post(
      '$url/create',
      chat.toJson(),
    );

    if (response.body == null) {
      Get.snackbar('Error en la Peticion', 'No se Puede Crear el Chat');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
