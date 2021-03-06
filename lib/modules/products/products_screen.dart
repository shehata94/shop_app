import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LayoutCubit cubit = LayoutCubit.get(context);
          return cubit.homeModel != null && cubit.categoriesModel != null
              ? productsBuilder(context, cubit.homeModel, cubit.categoriesModel,cubit)
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget productsBuilder(context, HomeModel model, CategoriesModel categoriesModel,LayoutCubit cubit) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data.banners
                    .map((e) => Image(
                          image: NetworkImage(e.image),
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(
              height: 15,
            ),
            Text(
              'Categories',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => categoriesItem(categoriesModel.data.data[index]),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 5,
                      ),
                  itemCount: categoriesModel.data.data.length),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Products',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .6,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemBuilder: (BuildContext context, index) => gridItemBuilder(model.data.products[index],cubit),
                itemCount: model.data.products.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget gridItemBuilder(ProductModel model,LayoutCubit cubit) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 240,
              ),
              model.discount != 0
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
          Text(
            model.name,
            maxLines: 2,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                '${model.price}',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              model.discount != 0
                  ? Text(
                      '${model.oldPrice}',
                      style: TextStyle(color: primaryColor, decoration: TextDecoration.lineThrough),
                    )
                  : SizedBox(
                      width: 10,
                    ),
              Spacer(),
              CircleAvatar(
                radius: 20,
                backgroundColor: cubit.favourites[model.id]? primaryColor: Colors.grey,
                child: IconButton(
                    onPressed: () {
                      cubit.changeFavourites(model);
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget categoriesItem(CategoryItemModel categoryItemModel) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(categoryItemModel.image),
          height: 100,
        ),
        Container(
          padding: EdgeInsets.all(5),
          color: Colors.black.withOpacity(0.8),
          child: Text(
            categoryItemModel.name,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
