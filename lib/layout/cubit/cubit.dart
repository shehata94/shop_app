import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LayoutCubit extends Cubit<LayoutCubitStates> {
  LayoutCubit() : super(LayoutInitState());

  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [ProductsScreen(), CategoriesScreen(), FavouritesScreen(), SettingsScreen()];

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(LayoutBottomNavBarChangeState());
  }

  HomeModel homeModel;
  CategoriesModel categoriesModel;
  Map<int, bool> favourites = {};

  Future<Response> getHomeData() async {
    emit(LayoutLoadingState());
    print(token);
    return await DioHelper.getData(path: Home, token: token, lang: 'en').then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((e) => {
            favourites.addAll({e.id: e.inFavourites})
          });
      print(favourites.toString());
      emit(LayoutSuccessState());
    }).catchError((error) {
      print(error);
      emit(LayoutErrorState());
    });
  }

  Future<Response> getCategoriesData() async {
    emit(LayoutLoadingState());
    return await DioHelper.getData(path: Categories, token: token, lang: 'en').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(LayoutCategoriesSuccessState());
    }).catchError((error) {
      print(error);
      emit(LayoutCategoriesErrorState());
    });
  }

  ChangeFavouritesModel changeFavouritesModel;
  Future<Response> changeFavourites(ProductModel model) async {
    favourites[model.id] = !favourites[model.id];
    return await DioHelper.postData(path: Favourites, data: {'product_id': model.id}, lang: 'en').then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      if (changeFavouritesModel.status != true) {
        favourites[model.id] = !favourites[model.id];
      } else {
        getFavourites();
      }
      emit(LayoutChangeFavouritesSuccessState());
    }).catchError((error) {
      favourites[model.id] = !favourites[model.id];
      print(error);
      emit(LayoutChangeFavouritesErrorState());
    });
  }

  FavouritesModel favouritesModel;
  Future<Response> getFavourites() async {
    emit(LayoutFavouritesLoadingState());
    return await DioHelper.getData(path: Favourites, token: token, lang: 'en').then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(LayoutFavouritesSuccessState());
      print(favouritesModel.data.data.length);
    }).catchError((error) {
      print(error);
      emit(LayoutFavouritesErrorState());
    });
  }
}
