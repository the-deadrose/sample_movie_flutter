import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/presentation/home_page.dart';
import 'package:get/get.dart';



final dio = Dio();

Future<void>  getData () async{
  try{
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    print(response.data);
  }on DioError catch(err){
     print(err.message);
     print(err.response);
  }



}



void main() async{
  await Future.delayed(Duration(milliseconds: 500));
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        //statusBarColor: appColor,
      )
  );
  runApp(ProviderScope(child: Home()));
}
  class Home extends StatelessWidget {
    // const ({Key? key}) : super(key: key);


    @override
    Widget build(BuildContext context) {
    return ScreenUtilInit(
    designSize: const Size(411, 866),
    minTextAdapt: true,
    builder: (context , child) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: child,
    );
    },
    child:  HomePage(),
    );
    }
    }