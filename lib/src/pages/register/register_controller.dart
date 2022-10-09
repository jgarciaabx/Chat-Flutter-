import 'dart:io';

import 'package:chat_flutter/src/models/user.dart';
import 'package:chat_flutter/src/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/response_api.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('$email');
    print('$name');
    print('$lastname');
    print('$phone');
    print('$password');
    print('$confirmPassword');

    if (isvalidForm(email, name, lastname, phone, password, confirmPassword)) {
      User user = User(
          email: email,
          name: name,
          lastname: lastname,
          phone: phone,
          password: password);

      // Response response = await usersProvider.create(user);
      ResponseApi responseApi =
          await usersProvider.createUserWithImage(user, imageFile!);

      if (responseApi.succes == true) {
        clearForm();
        goToHomePage();
      } else {
        Get.snackbar('No se pudo crear el usuario', responseApi.message!);
      }
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  Future selectImage(ImageSource imageSource) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      },
      child: Text('GALERIA'),
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      },
      child: Text('CAMARA'),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Seleccione tu imagen'),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void clearForm() {
    emailController.clear();
    nameController.clear();
    lastnameController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  bool isvalidForm(String email, String name, String lastname, String phone,
      String password, String confirmPassword) {
    if (email.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Debes Ingresar el correo Electronico');
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Debes Ingresar el correo Electronico');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Debes Ingresar el correo Electronico');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes Ingresar un Telefono');
      return false;
    }
    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'La contraseña de debe ser vacia');
      return false;
    }
    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no valido',
          'La confirmacion de contraseña de debe ser vacia');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no valido', 'Debe ser igual las Contraseñas');
      return false;
    }

    if (imageFile == null) {
      Get.snackbar(
          'Formulario no valido', 'Debe Seleccionar la imagen para un Perfil');
      return false;
    }

    if (imageFile == null) {
      Get.snackbar('Formulario', 'Debes seleccionar una imagen de Perfil');
      return false;
    }

    return true;
  }
}
