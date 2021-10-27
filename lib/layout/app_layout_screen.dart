import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';

class AppLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutCubitStates>(
        listener: (BuildContext context, state) => {},
        builder: (BuildContext context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Salla'),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourites'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (int index){
                cubit.changeCurrentIndex(index);
              },
            ),
            body: cubit.bottomScreens[cubit.currentIndex],

          );
        });
  }
}
