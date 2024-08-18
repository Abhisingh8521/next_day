import 'package:get/get.dart';
import 'package:next_day/db/sqflite_db.dart';
import '../model/user_api_response_model.dart';
import '../services/api_services.dart';

class FavoriteController extends GetxController {
  var pagesList = <UserModel>[].obs;
  var favoritePagesId = <String>[].obs;
  var favoritePagesList = <UserModel?>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFavorites();
  }

  void getFavorites() async {
    var data = await ApiServices.getPages();
    pagesList.value = data?.data ?? <UserModel>[];
    favoritePagesId.value =
    await LocalDatabaseServices.instance.getFavoriteUsers();
    favoritePagesList.value = pagesList
        .where((page) => favoritePagesId.contains(page.id.toString()))
        .toList();
  }

  void addFavorite({required UserModel user}) async {
    await LocalDatabaseServices.instance.addFavoriteUsers(user.id.toString());
    favoritePagesId.add(user.id.toString());
    favoritePagesList.add(user);
  }

  void removeFavorite({required UserModel user}) async {
    await LocalDatabaseServices.instance.deleteFavoriteUsers(user.id.toString());
    favoritePagesId.remove(user.id.toString());
    favoritePagesList.remove(user);
  }

  bool isFavorite(String pageId) {
    return favoritePagesId.contains(pageId);
  }
}
