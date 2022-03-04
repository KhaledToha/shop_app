import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/cubit/shop_cubit.dart';
import 'package:myapp/layout/cubit/states.dart';
import 'package:myapp/layout/shop_layout.dart';
import 'package:myapp/modules/shop_login_screen/shop_login_screen.dart';
import 'package:myapp/shared/bloc_observier.dart';
import 'package:myapp/shared/local/cache_helper.dart';
import 'package:myapp/shared/network/dio_helper.dart';
import 'package:myapp/styles/themes.dart';

import 'modules/on-boarding-screen/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  bool isDark;
  Widget startWidget;

  MyApp({required this.isDark, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavorites()
        ..getProfile()
        ..getNotification(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeLight,
            darkTheme: themeDark,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
