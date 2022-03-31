import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gasoline/view/home/home_screen.dart';
import 'common/app_colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    child: const MyApp(),
    path: "resources",
    saveLocale: true,
    fallbackLocale: const Locale('ar', 'AR'),
    supportedLocales: const [
      Locale('en','EN'),
      Locale('ar' , 'AR'),
    ],
  ));
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () =>
          MaterialApp(
            //... other code
            builder: (context, widget) {
              //add this line
              ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: MaterialApp(
                  theme: ThemeData(
                    appBarTheme: AppBarTheme(
                        color: AppColors.primaryColor
                    ),
                    buttonTheme: ButtonThemeData(
                      buttonColor: AppColors.primaryColor,
                    ),
                  ),
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  home: const HomeScreen(),
                ),
              );
            },
            theme: ThemeData(
              textTheme: TextTheme(
                //To support the following, you need to use the first initialization method
                  button: TextStyle(fontSize: 16.sp)
              ),
            ),
          ),
    );
  }

}