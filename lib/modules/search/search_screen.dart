import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';

import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocProvider(
      create:(context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchCubitStates>(
        listener: (context, state){},
        builder: (context,state){
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextForm(
                      controller: searchController,
                      inputType: TextInputType.text,
                      prefix: Icons.search,
                      label: 'Search',
                    onSubmit: (String value){
                        cubit.postSearchData(value);
                    }
                  ),
                  SizedBox(height: 5,),
                  state is SearchLoadingState
                  ?LinearProgressIndicator()
                  :SizedBox(height: 3,),
                  SizedBox(height: 15,),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index) => listItem(cubit.searchModel.data.data[index], cubit, isSearch: false),
                        separatorBuilder:(context,index)=> divider(),
                        itemCount: cubit.searchModel.data.data.length
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
