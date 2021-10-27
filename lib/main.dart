import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/app_layout_screen.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onboard/onboard_screen.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/bloc/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();


  Widget widget;
  final onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null)
      widget = AppLayoutScreen();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget widget;
  const MyApp({Key key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (BuildContext context) => LayoutCubit()..getHomeData())],
        child: MaterialApp(
          title: 'Shop App',
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home: widget,
        ));
  }
}
