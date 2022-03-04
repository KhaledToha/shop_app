import '../../models/change_favoirets.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavBarState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetProfileState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {}

class ShopErrorGetProfileState extends ShopStates {}

class ShopLoadingUpdateProfileState extends ShopStates {}

class ShopSuccessUpdateProfileState extends ShopStates {}

class ShopErrorUpdateProfileState extends ShopStates {}

class SearchInitialState extends ShopStates {}

class SearchLoadingState extends ShopStates {}

class SearchSuccessState extends ShopStates {}

class SearchErrorState extends ShopStates {}

class NotificationLoadingState extends ShopStates {}

class NotificationSuccessState extends ShopStates {}

class NotificationErrorState extends ShopStates {}
