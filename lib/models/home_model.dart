class HomeModel {
  late bool status;
  late DataHomeModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataHomeModel.formJson(json['data']);
  }
}

class DataHomeModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  DataHomeModel.formJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannersModel {
  late int id;
  late String image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String image;
  late String name;
  late bool in_favorites;
  late bool in_cart;
  late String description;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
    description = json['description'];
  }
}
