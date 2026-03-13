import 'package:ecommerce_prueba/injection.dart';
import 'package:ecommerce_prueba/src/presentation/BlocProviders.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/CategoryFormPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/ClientFormPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/HomePage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/OrderFormPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/OrderPaymentListPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/ProductFormPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/ProfilePage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/SubCategoryFormPage.dart';
import 'package:ecommerce_prueba/src/presentation/utils/QrScannerPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  //  WidgetsFlutterBinding.ensureInitialized();
  await configureDependences(); // PONER ESTA LINEA PARA INYECCION ... ES INDISPENSABLE !!!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        title: 'Aprendiendo Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'home': (BuildContext context) => HomePage(),
          'profile/info': (BuildContext context) => ProfilePage(),
          'category/form': (BuildContext context) => CategoryFormPage(),
          'subcategory/form': (BuildContext context) => SubCategoryFormPage(),
          'product/form': (BuildContext context) => ProductFormPage(),
          'client/form': (BuildContext context) => ClientFormPage(),
          'order/form': (BuildContext context) => OrderFormPage(),
          'qrScanner': (BuildContext context) => QrScannerPage(),
          'order/payment/list': (BuildContext context) =>
              OrderPaymentListPage(),
        },
      ),
    );
  }
}
