import 'package:chat_flutter/src/api/environment.dart';
import 'package:chat_flutter/src/models/message.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MessageProvider extends GetConnect {
  String url = Environment.API_CHAT + 'api/messages';

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Message>> getMessages(String idChat) async {
    Response response = await get(
      '$url/findByChat/${idChat}',
    );

    List<Message> messages = Message.fromJsonList(response.body);
    print(response.body);

    return messages;
  }

  Future<ResponseApi> create(Message message) async {
    Response response = await post('$url/create', message.toJson());

    if (response.body == null) {
      Get.snackbar('Error en la Peticion', 'No se Puede Actualizar el usuario');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
