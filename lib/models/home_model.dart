
class HomeModel{

  bool status;
  String message;
  HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = HomeDataModel.fromJson(json['data']);
  }

}

class HomeDataModel{
  List<ProductModel> products =[];
  List<BannerModel> banners = [];

  HomeDataModel.fromJson(Map<String, dynamic> json){

    json['banners'].forEach((element){
      banners.add(element);
    });

    json['products'].forEach((element){
      products.add(element);
    });
  }


}

class BannerModel{
  int id;
  String image;

  BannerModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel{
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavourites;
  bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourites = json['in_favourites'];
    inCart = json['in_cart'];
  }
}