import 'package:chat_flutter/src/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => controller.signOut(),
          child: Icon(
            Icons.power_settings_new,
          ),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Column(
            children: [
              circleImageUser(),
              SizedBox(
                height: 20,
              ),
              userInfo(
                'Nombre del Usuario',
                '${controller.user.name ?? ''} ${controller.user.lastname}',
                Icons.person,
              ),
              userInfo(
                'Email',
                '${controller.user.email ?? ''} ',
                Icons.email,
              ),
              userInfo(
                'Telefono',
                '${controller.user.phone ?? ''} ',
                Icons.phone,
              ),
            ],
          ),
        ));
  }

  Widget userInfo(String title, String subtitle, IconData iconData) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
      ),
    );
  }

  Widget circleImageUser() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: 200,
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
    );
  }
}
