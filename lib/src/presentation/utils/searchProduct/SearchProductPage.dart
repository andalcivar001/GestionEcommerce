import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/utils/searchProduct/bloc/SearchProductBloc.dart';
import 'package:ecommerce_prueba/src/presentation/utils/searchProduct/bloc/SearchProductEvent.dart';
import 'package:ecommerce_prueba/src/presentation/utils/searchProduct/bloc/SearchProductState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductPage extends StatefulWidget {
  final String tipoLlamado;
  SearchProductPage({required this.tipoLlamado});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

// class SearchProductContent extends StatelessWidget {
class _SearchProductPageState extends State<SearchProductPage> {
  SearchProductBloc? bloc;

  @override
  void dispose() {
    bloc?.add(ResetSearchProductEvent());
    controller.clear();
    super.dispose();
  }

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SearchProductBloc>(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.6,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Column(
            children: [
              SizedBox(height: 12),

              //Barra Superior
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              SizedBox(height: 15),

              Text(
                'Buscar Producto',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        onChanged: (value) {
                          bloc?.add(
                            QueryChangedSearchProductEvent(query: value),
                          );
                        },
                        decoration: InputDecoration(
                          hintText: 'Buscar por descripción o código',
                          prefixIcon: Icon(Icons.edit),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E3C72),
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        bloc?.add(ConsultarSearchProductEvent());
                      },
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              Expanded(
                child: BlocBuilder<SearchProductBloc, SearchProductState>(
                  builder: (context, state) {
                    final response = state.response;
                    final List<Product> products = response is Success
                        ? response.data as List<Product>
                        : [];
                    if (response is Loading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (response is Error) {
                      AppToast.error(
                        'Hubo un Problema al consultar los productos ${response.message}',
                      );
                      bloc?.add(ErrorSearchProductEvent());
                    }

                    if (products.isEmpty) {
                      return Center(
                        child: Text(
                          'No hay productos consultados',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: products.length,
                        itemBuilder: (_, index) {
                          final product = products[index];
                          final image1 = product.imagen1 ?? '';
                          final image2 = product.imagen2 ?? '';
                          final imagenFinal = image1.isNotEmpty
                              ? image1
                              : image2.isNotEmpty
                              ? image2
                              : '';

                          final precio = product.precio ?? 0;

                          return GestureDetector(
                            onTap: () {
                              // bloc?.add(ResetSearchProductEvent());
                              //controller.clear();
                              //Navigator.pop(context, product);
                              if (product.stock <= 0 &&
                                  widget.tipoLlamado == 'OV') {
                                AppToast.warning(
                                  '${product.descripcion} no tiene stock, no se puede agregar',
                                );
                                return;
                              }

                              AppToast.success(
                                '${product.descripcion} agregado correctamente',
                              );
                              context.read<OrderFormBloc>().add(
                                BuscarProductOrderFormEvent(product: product),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.08),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                    ),
                                    child: imagenFinal.isEmpty
                                        ? Icon(
                                            Icons.inventory_2,
                                            color: Color(0xFF1E3C72),
                                          )
                                        : FadeInImage.assetNetwork(
                                            image: imagenFinal,
                                            placeholder:
                                                'assets/img/no_image.jpg',
                                            fit: BoxFit.cover,
                                            fadeInDuration: const Duration(
                                              seconds: 1,
                                            ),

                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.inventory_2,
                                                    color: Color(0xFF1E3C72),
                                                  );
                                                },
                                          ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.descripcion,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: product.stock <= 0
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '\$${precio.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: product.stock <= 0
                                                    ? Colors.red
                                                    : Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              'Stock: ${product.stock} uni.',
                                              style: TextStyle(
                                                color: product.stock <= 0
                                                    ? Colors.red
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blueAccent,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
