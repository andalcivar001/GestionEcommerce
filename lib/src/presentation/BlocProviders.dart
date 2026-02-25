import 'package:ecommerce_prueba/injection.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/ProductUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/SubCategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/users/UsersUseCases.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/bloc/SubCategoryFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/utils/searchProduct/bloc/SearchProductBloc.dart';
import 'package:ecommerce_prueba/src/presentation/utils/searchProduct/bloc/SearchProductEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(
    create: (context) =>
        LoginBloc(locator<AuthUseCases>())..add(InitLoginEvent()),
  ),

  BlocProvider<RegisterBloc>(
    create: (context) =>
        RegisterBloc(locator<AuthUseCases>())..add(InitRegisterEvent()),
  ),

  BlocProvider<HomeBloc>(
    create: (context) =>
        // HomeBloc(locator<AuthUseCases>())..add(InitHomeEvent()),
        HomeBloc(locator<AuthUseCases>()),
  ),
  BlocProvider<ProfileBloc>(
    create: (context) =>
        ProfileBloc(locator<AuthUseCases>(), locator<UsersUseCases>())
          ..add(InitProfileEvent()),
  ),

  BlocProvider<CategoryListBloc>(
    create: (context) =>
        CategoryListBloc(locator<CategoryUseCases>())
          ..add(InitCategoryListEvent()),
  ),

  BlocProvider<CategoryFormBloc>(
    create: (context) => CategoryFormBloc(locator<CategoryUseCases>()),
  ),

  BlocProvider<SubCategoryListBloc>(
    create: (context) => SubCategoryListBloc(
      locator<SubCategoryUseCases>(),
      locator<CategoryUseCases>(),
    )..add(InitSubCategoryListEvent()),
  ),
  BlocProvider<SubCategoryFormBloc>(
    create: (context) => SubCategoryFormBloc(
      locator<SubCategoryUseCases>(),
      locator<CategoryUseCases>(),
    ),
  ),

  BlocProvider<ProductListBloc>(
    create: (context) =>
        ProductListBloc(locator<ProductUseCases>())
          ..add(InitProductListEvent()),
  ),

  BlocProvider<ProductFormBloc>(
    create: (context) => ProductFormBloc(
      locator<ProductUseCases>(),
      locator<CategoryUseCases>(),
      locator<SubCategoryUseCases>(),
    ),
  ),

  BlocProvider<ClientListBloc>(
    create: (context) =>
        ClientListBloc(locator<ClientUseCases>())..add(InitClientListEvent()),
  ),

  BlocProvider<ClientFormBloc>(
    create: (context) => ClientFormBloc(locator<ClientUseCases>()),
  ),

  BlocProvider<OrderListBloc>(
    create: (context) =>
        OrderListBloc(locator<OrderUseCases>(), locator<AuthUseCases>())
          ..add(InitOrderListEvent()),
  ),
  BlocProvider<OrderFormBloc>(
    create: (context) => OrderFormBloc(
      locator<OrderUseCases>(),
      locator<ClientUseCases>(),
      locator<ProductUseCases>(),
      locator<AuthUseCases>(),
    ),
  ),

  BlocProvider<SearchProductBloc>(
    create: (context) =>
        SearchProductBloc(locator<ProductUseCases>())
          ..add(InitSearchProductEvent()),
  ),
];
