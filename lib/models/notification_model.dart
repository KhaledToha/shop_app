class NotificationModel {
  bool? status;
  NotificationDataModel? data;


  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  NotificationDataModel.fromJson(json['data']) : null;
  }


}

class NotificationDataModel {
 late int currentPage;
  List<Data> data =[];
 late String firstPageUrl;
 late int from;
 late int lastPage;
 late  String lastPageUrl;
 late Null nextPageUrl;
 late  String path;
 late int perPage;
 late  Null prevPageUrl;
 late  int to;
 late int total;



 NotificationDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {

      json['data'].forEach((element) {
        data.add( Data.fromJson(element));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}

class Data {
 late int id;
 late String title;
 late String message;



  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
  }


}
