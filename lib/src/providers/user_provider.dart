import 'dart:convert';
import 'dart:io';

import 'package:chat_flutter/src/api/environment.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user.dart';
import 'package:path/path.dart';

class UsersProvider extends GetConnect {
  String url = Environment.API_CHAT + 'api/users';

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<User>> getUsers() async {
    Response response = await get(
      '$url/getAll/${user.id}',
    );

    List<User> users = User.fromJsonList(response.body);
    print(response.body);

    return users;
  }

  Future<Response> create(User user) async {
    Response response = await post('$url/create', user.toJson(),
        headers: {'Content-Type': 'application/json'});

    return response;
  }

  Future<ResponseApi> createUserWithImage(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user),
      // 'headers': {
      //   'Content-Type': 'application/json',
      //   'Authorization': user.sessionToken!
      // }
    });
    Response response = await post('$url/registerWithImage', form);

    if (response.body == null) {
      Get.snackbar('Error en la Peticion', 'No se puede crear al usuario');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post('$url/login', {
      'email': email,
      'password': password,
    }, headers: {
      'Content-Type': 'application/json'
    });

    if (response.body == null) {
      Get.snackbar('Erro', 'No se pudo ejecutar la peticion de login');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
