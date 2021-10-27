import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutCubitStates>(
      listener: (context, state)  {
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return cubit.homeModel != null
            ? productsBuilder(cubit.homeModel)
            :Center(child: CircularProgressIndicator(),);
      }
    );
  }
  Widget productsBuilder(HomeModel model){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
        CarouselSlider(
        items: model.data.banners.map((e) => Image(
            image: NetworkImage(e.image),
          width: double.infinity,

        )).toList(),
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16/9,
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
          SizedBox(height: 10,),
          Container(
            color: Colors.grey[300],
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2,
                  childAspectRatio: .6,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemBuilder: (BuildContext context,index) => griItemBuilder(model.data.products[index]),
              itemCount: model.data.products.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

            ),
          )
        ],

      ),
    );
  }

  Widget griItemBuilder(ProductModel model){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [

              Image(
                image: NetworkImage(model.image) ,
                width: double.infinity,
                height: 240,
              ),
              model.discount != 0
              ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text('DISCOUNT',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
              )
              :SizedBox(),
            ],
          ),
          Text(model.name,maxLines: 2,),
          SizedBox(height: 10,),
          Row(
            children: [
              Text('${model.price}',

              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,

              ),),
              SizedBox(width: 5,),
              model.discount != 0?Text('${model.oldPrice}',
                style: TextStyle(
                    color: primaryColor,
                  decoration: TextDecoration.lineThrough
                ),):SizedBox(width: 10,),
              Spacer(),
              IconButton(onPressed: (){},
                  icon: Icon(Icons.favorite_border,
                  )
              )
            ],
          )
        ],

      ),
    );
  }
}
