import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'components.dart';

var token;

void signOut(BuildContext context){
  CacheHelper.clearData(key: 'token').then((value) {
    if (value) navigateAndFinish( context, LoginScreen());
  });
}