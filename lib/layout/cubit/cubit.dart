import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LayoutCubit extends Cubit<LayoutCubitStates>{

  LayoutCubit() : super(LayoutInitState());

  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];

  void changeCurrentIndex(int index){

    currentIndex= index;
    emit(LayoutBottomNavBarChangeState());

  }

  HomeModel homeModel;
  Future<Response> getHomeData() async{
    emit(LayoutLoadingState());
    return await DioHelper.getData(
      path: Home,
      token: token,
      lang: 'en'
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);
      emit(LayoutSuccessState());
    }).catchError((error){
      print(error);
      emit(LayoutErrorState());
    });

  }

}
