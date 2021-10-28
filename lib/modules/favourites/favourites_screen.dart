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
        itemBuilder: (context, index) => favouritesItem(cubit.favouritesModel.data.data[index],cubit),
        separatorBuilder: (context, index) => divider(),
        itemCount: cubit.favouritesModel.data.data.length,
        );
           },
    );
  }

  Widget favouritesItem(FavouritesSecDataModel model, LayoutCubit cubit) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 130,
              width: 130,
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(model.product.image),
                    width: 130,
                    height: 130,
                  ),
                  model.product.discount != 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            color: Colors.red,
                            child: Text(
                              'DISCOUNT',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                       '${model.product.price}',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                     model.product.discount != 0
                          ? Text(
                              '${model.product.oldPrice}',
                              style: TextStyle(color: primaryColor, decoration: TextDecoration.lineThrough),
                            )
                          : SizedBox(
                              width: 10,
                            ),
                      Spacer(),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: cubit.favourites[model.product.id]? primaryColor: Colors.grey,
                        child: IconButton(
                            onPressed: () {
                               cubit.changeFavourites(model.product);
                            },
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
