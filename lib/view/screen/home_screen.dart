import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/user_api_response_model.dart';
import '../../services/api_services.dart';
import '../../controller/favorite_controller.dart';
import '../../utils/colors/colors.dart';
import '../../utils/constraint.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.put(FavoriteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          Obx(
                () => Badge(
              largeSize: 20,
              offset: const Offset(-1, 4),
              label:
              Text(favoriteController.favoritePagesList.length.toString()),
              child: IconButton(
                  onPressed: () {
                    Get.to(FavoriteScreen());
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )),
            ),
          )
        ],
        leadingWidth: 35,
      ),
      body: FutureBuilder(
          future: ApiServices.getPages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
              return Center(child: Text("You haven't any Page"));
            }
            return ListView.builder(
              itemCount: snapshot.data?.data?.length,
              itemBuilder: (context, index) {
                var data = snapshot.data?.data?[index];
                return pageItems(
                    favoriteController: favoriteController,
                    userModel: data ?? UserModel());
              },
            );
          }),
    );
  }
}

pageItems(
    {required FavoriteController favoriteController,
      required UserModel userModel}) {
  return Container(
    decoration: BoxDecoration(
        color: secondaryColor, borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 16),
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: userModel.avatar ?? defaultImage,

            placeholder: (context, url) =>
                const Center(child: CupertinoActivityIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          "${userModel.firstName}, ${userModel.lastName}",
          style: TextStyle(fontSize: 14, color: Colors.grey[400]),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white)),
              child: Text(
                userModel.email ?? "",
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Obx(() {
              bool isFavorite =
              favoriteController.isFavorite(userModel.id.toString());
              return IconButton(
                onPressed: () {
                  if (isFavorite) {
                    favoriteController.removeFavorite(user: userModel);
                  } else {
                    favoriteController.addFavorite(user: userModel);
                  }
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color:  isFavorite ? Colors.red :Colors.white,
                  size: 26,
                ),
              );
            }),
          ],
        ),
      ],
    ),
  );
}
