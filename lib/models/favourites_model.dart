
import 'home_model.dart';

class FavouritesModel{

  bool status;
  FavouritesDataModel data;

  FavouritesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = FavouritesDataModel.fromJson(json['data']);
  }

}

class FavouritesDataModel{
  int currentPage;
  List<FavouritesSecDataModel> data = [];

  FavouritesDataModel.fromJson(Map<String, dynamic> json){

    json['data'].forEach((element){
      data.add(FavouritesSecDataModel.fromJson(element));
    });
  }
}

class FavouritesSecDataModel{
  int id;
  ProductModel product ;

  FavouritesSecDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    product = ProductModel.fromJson(json['product']);

  }
}


