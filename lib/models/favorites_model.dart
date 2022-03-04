import 'home_model.dart';

class FavoritesModel {
  late bool status;
  late String message;
  late FavoritesDataModel data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = FavoritesDataModel.fromJson(json['data']);
  }
}

class FavoritesDataModel {
  late int current_page;
  List<DataModel> data = [];

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late ProductsModel product;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductsModel.fromJson(json['product']);
  }
}
