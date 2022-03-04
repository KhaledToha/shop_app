import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/cubit/states.dart';
import 'package:myapp/shared/local/cache_helper.dart';

import '../../models/categories_model.dart';
import '../../models/change_favoirets.dart';
import '../../models/favorites_model.dart';
import '../../models/home_model.dart';
import '../../models/login_model.dart';
import '../../models/notification_model.dart';
import '../../models/search_model.dart';
import '../../modules/categories_screen/categories_screen.dart';
import '../../modules/faviortes_screen/faviortes_screen.dart';
import '../../modules/products_screen/products_screen.dart';
import '../../modules/settings_screen/settings_screen.dart';
import '../../shared/end_points.dart';
import '../../shared/network/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FaviortesScreen(),
    SettingsScreen()
  ];

  void changeNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: Home, token: CacheHelper.getData(key: 'token'))
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessHomeDataState());
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.in_favorites});
      });
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: GetCategories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
            url: setFavoriets,
            data: {'product_id': productId},
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
            url: 'favorites', token: CacheHelper.getData(key: 'token'))
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? profileModel;

  void getProfile() {
    DioHelper.getData(url: Profile, token: CacheHelper.getData(key: 'token'))
        .then((value) {
      profileModel = ShopLoginModel.fromjson(value.data);

      emit(ShopSuccessGetProfileState());
    }).catchError((error) {
      emit(ShopErrorGetProfileState());
    });
  }

  void updateData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateProfileState());

    DioHelper.putData(
            url: Update,
            data: {'name': name, 'email': email, 'phone': phone},
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      profileModel = ShopLoginModel.fromjson(value.data);

      emit(ShopSuccessUpdateProfileState());
    }).catchError((error) {
      emit(ShopErrorUpdateProfileState());
    });
  }

  SearchModel? searchModel;

  void getSearch(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(url: Search, data: {'text': text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }

  NotificationModel? notificationModel;

  void getNotification() {
    emit(NotificationLoadingState());

    DioHelper.getData(
            url: 'notifications', token: CacheHelper.getData(key: 'token'))
        .then((value) {
      notificationModel = NotificationModel.fromJson(value.data);

      emit(NotificationSuccessState());
    }).catchError((error) {
      emit(NotificationErrorState());
    });
  }
}
