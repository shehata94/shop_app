import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return cubit.categoriesModel != null
            ? ListView.separated(
                itemBuilder: (context, index) => categoryItem(cubit.categoriesModel.data.data[index]),
                separatorBuilder: (context, index) => divider(),
                itemCount: cubit.categoriesModel.data.data.length
        )
            : Center(
                child: RefreshProgressIndicator(),
              );
      },
    );
  }

  Widget categoryItem( CategoryItemModel categoryItemModel) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(categoryItemModel.image),
              height: 100,
              width: 100
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              categoryItemModel.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
}
