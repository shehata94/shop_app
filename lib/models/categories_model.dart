
class CategoriesModel{
  bool status;
  CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }

}

class CategoriesDataModel{
  int currentPage;
  List<CategoryItemModel> data=[];

  CategoriesDataModel.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(CategoryItemModel.fromJson(element));
    });
  }

}

class CategoryItemModel{
  int id;
  String name;
  String image;

  CategoryItemModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}