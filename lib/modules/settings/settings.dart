import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/app_layout_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterCubitStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              if (state.loginModel.status) {
                print(state.loginModel.message);
                CacheHelper.setData(key: 'token', value: state.loginModel.data.token).then((value) {
                  navigateAndFinish(context, AppLayoutScreen());
                });

                //Todo
                //Toast message for success
              } else {
                //Todo
                //Toast message for error
                print(state.loginModel.message);
              }
            }
          },
          builder: (context, state) {
            var cubit = RegisterCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Icon(Icons.person,size: 70,color: Colors.grey,),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            controller: nameController,
                            inputType: TextInputType.name,
                            prefix: Icons.person,
                            label: "User Name",
                            validate: (String text) {
                              if (text.isEmpty) {
                                return ("User name can\'t be empty");
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextForm(

                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            prefix: Icons.email_outlined,
                            label: "Email Address",
                            validate: (String text) {
                              if (text.isEmpty) {
                                return ("Email address can\'t be empty");
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextForm(
                            controller: phoneController,
                            inputType: TextInputType.phone,
                            prefix: Icons.phone,
                            label: "Phone Number",
                            validate: (String text) {
                              if (text.isEmpty) {
                                return ("Phone number can\'t be empty");
                              }
                            }),
                        SizedBox(
                          height: 25,
                        ),
                        state is RegisterLoadingState
                            ? Center(child: RefreshProgressIndicator())
                            : defaultButton(
                            label: "Update",
                            onPressed: () {

                            }),
                        SizedBox(
                          height: 25,
                        ),
                        defaultButton(
                            label: "Sign out",
                            onPressed: () {
                              signOut(context);

                            }),

                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
