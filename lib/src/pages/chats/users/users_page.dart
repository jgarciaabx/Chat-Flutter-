import 'package:chat_flutter/src/models/user.dart';
import 'package:chat_flutter/src/pages/chats/users/user_controller.dart';
import 'package:chat_flutter/src/util/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {
  UsersContoller controller = Get.put(UsersContoller());

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      appBar: AppBar(
        title: Text('CHAT DE USUARIOS'),
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: controller.getUsers(),
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.isNotEmpty == true) {
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    return cardUser(snapshot.data![index]);
                  },
                );
              } else
                return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget cardUser(User user) {
    return ListTile(
      onTap: () => controller.goToChat(user),
      title: Text(user.name ?? ''),
      subtitle: Text(user.email ?? ''),
      leading: AspectRatio(
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
    );
  }
}
