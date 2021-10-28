import 'package:shop_app/models/home_model.dart';

class ChangeFavouritesModel
{
  bool status;
  String message;
  ChangeFavouritesDataModel data;

  ChangeFavouritesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = ChangeFavouritesDataModel.fromJson(json['data']);
  }

}

class ChangeFavouritesDataModel
{
  int id;
  ProductModel model;

  ChangeFavouritesDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    model = ProductModel.fromJson(json['product']);

  }


}

