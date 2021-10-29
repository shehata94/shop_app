
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchCubitStates>{

  SearchCubit() : super(SearchInitState());

  static SearchCubit get(context) => BlocProvider.of(context);

SearchModel searchModel;
  Map<int , bool> favourites = {};
  void postSearchData(String text){
    emit(SearchLoadingState());
    
    DioHelper.postData(
        path: Search,
        token: token,
        lang: 'en',
        data: {
          'text': text
        }
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      searchModel.data.data.forEach((e) => {
        favourites.addAll({e.id:e.inFavourites})
      });

      emit(SearchSuccessState());

    }).catchError((error){
      print(error);
      emit(SearchErrorState());

    });
  }
}