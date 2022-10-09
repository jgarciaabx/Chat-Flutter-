import 'package:chat_flutter/src/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/response_api.dart';
import '../../models/user.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  GetStorage storage = GetStorage();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ResponseApi responseApi = await usersProvider.login(email, password);

      if (responseApi.succes == true) {
        User user = User.fromJson(responseApi.data);
        storage.write('user', user.toJson());
        goGoHome();
        // Get.toNamed('/home');
      } else {
        Get.snackbar('Error de Sesion', 'No se ha podido iniciar sesion');
      }
    } else {
      Get.snackbar('Completa los Datos', 'Ingrese email y el password');
    }
  }

  void goGoHome() {
    Get.offNamedUntil('/home', (route) => false);
  }
}
