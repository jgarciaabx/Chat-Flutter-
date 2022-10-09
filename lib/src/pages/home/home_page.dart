import 'package:chat_flutter/src/pages/chats/chats_page.dart';
import 'package:chat_flutter/src/pages/home/home_controller.dart';
import 'package:chat_flutter/src/pages/profile/profile_page.dart';
import 'package:chat_flutter/src/pages/chats/users/users_page.dart';
import 'package:chat_flutter/src/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottonNavigatorBar(context),
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              ChatPage(),
              UsersPage(),
              ProfilePage(),
            ],
          ),
        ));
  }

  Widget bottonNavigatorBar(BuildContext context) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Container(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex.value,
            backgroundColor: MyColors.primaryColor,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  size: 20,
                ),
                label: 'Chats',
                backgroundColor: MyColors.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 20,
                ),
                label: 'Usuarios',
                backgroundColor: MyColors.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_pin_rounded,
                  size: 20,
                ),
                label: 'Perfil',
                backgroundColor: MyColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
