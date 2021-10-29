import 'package:shop_app/models/home_model.dart';

class SearchModel{
  bool status;
  SearchDataModel data;

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }

}

class SearchDataModel{
  int currentPage;
  List<ProductModel> data=[];

  SearchDataModel.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(ProductModel.fromJson(element));
    });
  }

}
