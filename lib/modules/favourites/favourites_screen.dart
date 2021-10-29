import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutCubitStates>(
       listener: (context, state)=>{},
      builder: (context, state){
         var cubit = LayoutCubit.get(context);
         return state is LayoutFavouritesLoadingState
         ?Center(child: RefreshProgressIndicator(),)
        :ListView.separated(
        itemBuilder: (context, index) => listItem(cubit.favouritesModel.data.data[index].product,cubit),
        separatorBuilder: (context, index) => divider(),
        itemCount: cubit.favouritesModel.data.data.length,
        );
           },
    );
  }


}
