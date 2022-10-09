import 'package:chat_flutter/src/models/user.dart';
import 'package:chat_flutter/src/providers/user_provider.dart';
import 'package:get/get.dart';

class UsersContoller extends GetxController {
  UsersProvider usersProvider = UsersProvider();

  Future<List<User>> getUsers() async {
    return await usersProvider.getUsers();
  }

  void goToChat(User user) {
    Get.toNamed('/message', arguments: {'user': user.toJson()});
  }
}
