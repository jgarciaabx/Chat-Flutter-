import 'package:chat_flutter/src/pages/chats/message/message_page.dart';
import 'package:chat_flutter/src/models/user.dart';
import 'package:chat_flutter/src/pages/home/home_page.dart';
import 'package:chat_flutter/src/pages/register/register_page.dart';
import 'package:chat_flutter/src/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'src/pages/login/login_page.dart';
import 'package:get/get.dart';

User myUser = User.fromJson(GetStorage().read('user') ?? {});
void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: myUser.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/message', page: () => MessagePage()),
      ],
      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
      ),
      navigatorKey: Get.key,
    );
  }
}
