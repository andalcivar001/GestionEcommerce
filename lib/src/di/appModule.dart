import 'package:ecommerce_prueba/src/data/datasource/local/SharedPref.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/OrderPaymentService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/AuthService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/CategoryService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/CityService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/ClientService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/OrderService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/ProductService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/ProvinceService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/SubCategoryService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/UserService.dart';
import 'package:ecommerce_prueba/src/data/repository/AuthRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/data/repository/CategoryRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/data/repository/ClientRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/data/repository/OrderPaymentRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/data/repository/OrderRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/data/repository/ProductRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/data/repository/SubCategoryRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/data/repository/UserRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/repository/AuthRepository.dart';
import 'package:ecommerce_prueba/src/domain/repository/CategoryRepository.dart';
import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';
import 'package:ecommerce_prueba/src/domain/repository/OrderPaymentRepository.dart';
import 'package:ecommerce_prueba/src/domain/repository/OrderRepository.dart';
import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';
import 'package:ecommerce_prueba/src/domain/repository/SubCategoryRepository.dart';
import 'package:ecommerce_prueba/src/domain/repository/UserRepository.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CreateCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/DeleteCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/GetCategoriesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/UpdateCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/CreateClientUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/DeleteClientUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetCitiesByProvinceUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetCitiesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetClientByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetClientsUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetProvincesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/UpdateClientUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/CreateOrderUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/DeleteOrderUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/GetOrderByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/GetOrdersByUserUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/UpdateOrderUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/CreateOrderPaymentUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/DeleteOrderPaymentUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetOrderPaymentByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetOrderPaymentsByOrdenUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/OrderPaymentUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/UpdateOrderPaymentUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/CreateProductUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/DeleteProductUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/GetProductByCodAlternoUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/GetProductByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/GetProductsSearchUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/GetProductsUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/ProductUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/UpdateProductUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/CreateSubCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/DeleteSubCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/GetSubCategoriesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/SubCategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/UpdateSubCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/SaveUserSessionUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/users/UpdateUsersUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/users/UsersUseCases.dart';
import 'package:injectable/injectable.dart';

@module
abstract class Appmodule {
  @injectable
  SharedPref get sharedPref => SharedPref();

  @injectable
  Future<String> get token async {
    String token = "";
    final userSession = await sharedPref.read('user');
    if (userSession != null) {
      //convertir el objeto dinamico a una clase
      AuthResponse authResponse = AuthResponse.fromJson(userSession);
      token = authResponse.token;
    }
    return token;
  }

  /******* SERVICIOS *****/
  ///
  @injectable
  AuthService get authService => AuthService();

  @injectable
  UserService get userService => UserService(token);

  @injectable
  CategoryService get categoryService => CategoryService(token);

  @injectable
  SubCategoryService get subCategoryService => SubCategoryService(token);

  @injectable
  ProductService get productService => ProductService(token);

  @injectable
  ClientService get clientService => ClientService(token);

  @injectable
  ProvinceService get provinceService => ProvinceService(token);

  @injectable
  CityService get cityService => CityService(token);

  @injectable
  OrderService get orderService => OrderService(token);

  @injectable
  OrderPaymentService get orderPaymentService => OrderPaymentService(token);

  /******** REPOSITORIOS *********** */ ////
  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(authService, sharedPref);

  @injectable
  UserRepository get userRepository => UserRepositoryImpl(userService);

  @injectable
  CategoryRepository get categoryRepository =>
      CategoryRepositoryImpl(categoryService);

  SubCategoryRepository get subCategoryRepository =>
      SubCategoryRepositoryImpl(subCategoryService);

  ProductRepository get productRepository =>
      ProductRepositoryImpl(productService);

  ClientRepository get clientRepository =>
      ClientRepositoryImpl(clientService, provinceService, cityService);

  OrderRepository get orderRepository => OrderRepositoryImpl(orderService);

  OrderPaymentRepository get orderPaymentRepository =>
      OrderPaymentRepositoryImpl(orderPaymentService);

  /********* USECASE *******/
  ///
  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    getUserSession: GetUserSessionUseCase(authRepository),
    saveUserSession: SaveUserSessionUseCase(authRepository),
    logout: LogoutUseCase(authRepository),
  );

  @injectable
  UsersUseCases get userUseCase =>
      UsersUseCases(update: UpdateUsersUseCase(userRepository));

  @injectable
  CategoryUseCases get categoryUseCases => CategoryUseCases(
    getCategories: GetCategoriesUseCase(categoryRepository),
    create: CreateCategoryUseCase(categoryRepository),
    update: UpdateCategoryUseCase(categoryRepository),
    delete: DeleteCategoryUseCase(categoryRepository),
  );

  @injectable
  SubCategoryUseCases get subCategoryUseCases => SubCategoryUseCases(
    getSubCategories: GetSubCategoriesUseCase(subCategoryRepository),
    create: CreateSubCategoryUseCase(subCategoryRepository),
    update: UpdateSubCategoryUseCase(subCategoryRepository),
    delete: DeleteSubCategoryUseCase(subCategoryRepository),
  );

  @injectable
  ProductUseCases get productUseCases => ProductUseCases(
    getProducts: GetProductUseCase(productRepository),
    getBydId: GetProductByIdUaseCase(productRepository),
    create: CreateProductUseCase(productRepository),
    update: UpdateProductUseCase(productRepository),
    delete: DeleteProductUseCase(productRepository),
    getByCodAlterno: GetProductByCodalternoUseCase(productRepository),
    getProductsSearch: GetProductsSearchUseCase(productRepository),
  );

  @injectable
  ClientUseCases get clientUseCases => ClientUseCases(
    getClients: GetClientsUseCase(clientRepository),
    getCitiesByProvince: GetCitiesByProvince(clientRepository),
    getProvinces: GetProvincesUseCase(clientRepository),
    getClientById: GetClientByIdUseCase(clientRepository),
    getCities: GetCitiesUseCase(clientRepository),
    create: CreateClientUseCase(clientRepository),
    update: UpdateClientUseCase(clientRepository),
    delete: DeleteClientUseCase(clientRepository),
  );

  @injectable
  OrderUseCases get orderUseCases => OrderUseCases(
    getOrderByUser: GetOrdersByUserUseCase(orderRepository),
    getOrderById: GetOrderByIdUseCase(orderRepository),
    create: CreateOrderUseCase(orderRepository),
    update: UpdateOrderUseCase(orderRepository),
    delete: DeleteOrderUseCase(orderRepository),
  );

  @injectable
  OrderPaymentUseCases get orderPaymentUseCases => OrderPaymentUseCases(
    getOrderPaymentByIdUseCase: GetOrderPaymentByIdUseCase(
      orderPaymentRepository,
    ),
    getOrderPaymentsByOrdenUseCase: GetOrderPaymentsByOrdenUseCase(
      orderPaymentRepository,
    ),
    createOrderPaymentUseCase: CreateOrderPaymentUseCase(
      orderPaymentRepository,
    ),
    updateOrderPaymentUseCase: UpdateOrderPaymentUseCase(
      orderPaymentRepository,
    ),
    deleteOrderPaymentUseCase: DeleteOrderPaymentUseCase(
      orderPaymentRepository,
    ),
  );
}
