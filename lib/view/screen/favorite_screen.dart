import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/favorite_controller.dart';
import '../../model/user_api_response_model.dart';
import 'home_screen.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Screen"),
      ),
      body: Obx(() => favoriteController.favoritePagesList.isNotEmpty
          ? ListView.builder(
        itemCount: favoriteController.favoritePagesList.length,
        itemBuilder: (context, index) {
          var data = favoriteController.favoritePagesList[index];
          return pageItems(
              favoriteController: favoriteController,
              userModel: data ?? UserModel());
        },
      )
          : const Center(
        child: Text("you havn't favorite item"),
      )),
    );
  }
}
