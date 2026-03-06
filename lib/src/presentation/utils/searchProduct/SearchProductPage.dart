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

  const SearchProductPage({super.key, required this.tipoLlamado});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  SearchProductBloc? bloc;

  final TextEditingController controller = TextEditingController();

  final Color primaryColor = const Color(0xFF1E3C72);

  @override
  void dispose() {
    bloc?.add(ResetSearchProductEvent());
    controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SearchProductBloc>(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.65,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// HANDLE
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 16),

              /// TITLE
              const Text(
                'Buscar Producto',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 18),

              /// SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search),

                      const SizedBox(width: 8),

                      Expanded(
                        child: TextField(
                          controller: controller,
                          onChanged: (value) {
                            bloc?.add(
                              QueryChangedSearchProductEvent(query: value),
                            );
                          },
                          decoration: const InputDecoration(
                            hintText: 'Buscar producto o código',
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      IconButton(
                        icon: Icon(Icons.arrow_forward, color: primaryColor),
                        onPressed: () {
                          bloc?.add(ConsultarSearchProductEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// PRODUCT LIST
              Expanded(
                child: BlocBuilder<SearchProductBloc, SearchProductState>(
                  builder: (context, state) {
                    final response = state.response;

                    final List<Product> products = response is Success
                        ? response.data as List<Product>
                        : [];

                    if (response is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (response is Error) {
                      AppToast.error(
                        'Error consultando productos ${response.message}',
                      );
                      bloc?.add(ErrorSearchProductEvent());
                    }

                    if (products.isEmpty) {
                      return const Center(
                        child: Text(
                          'No hay productos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        final product = products[index];

                        final orderState = context.watch<OrderFormBloc>().state;

                        final selected = orderState.orderDetail.any(
                          (x) => x.idProducto == product.id,
                        );

                        final image1 = product.imagen1 ?? '';
                        final image2 = product.imagen2 ?? '';

                        final imagenFinal = image1.isNotEmpty ? image1 : image2;

                        final precio = product.precio ?? 0;

                        return GestureDetector(
                          onTap: () {
                            if (product.stock <= 0 &&
                                widget.tipoLlamado == 'OV') {
                              AppToast.warning(
                                '${product.descripcion} no tiene stock',
                              );
                              return;
                            }

                            if (!selected) {
                              context.read<OrderFormBloc>().add(
                                BuscarProductOrderFormEvent(product: product),
                              );
                            } else {
                              context.read<OrderFormBloc>().add(
                                EliminarProductOrderFormEvent(
                                  idProducto: product.id,
                                ),
                              );
                            }
                          },

                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selected
                                  ? Colors.green.shade50
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: selected
                                    ? Colors.green
                                    : Colors.grey.shade200,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),

                            child: Row(
                              children: [
                                /// IMAGE
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: imagenFinal.isEmpty
                                      ? const Icon(Icons.inventory_2)
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: FadeInImage.assetNetwork(
                                            image: imagenFinal,
                                            placeholder:
                                                'assets/img/no_image.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),

                                const SizedBox(width: 12),

                                /// INFO
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.descripcion,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: product.stock <= 0
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),

                                      const SizedBox(height: 5),

                                      Row(
                                        children: [
                                          Text(
                                            '\$${precio.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),

                                          const SizedBox(width: 12),

                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: product.stock <= 0
                                                  ? Colors.red.shade50
                                                  : Colors.blue.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              'Stock ${product.stock}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: product.stock <= 0
                                                    ? Colors.red
                                                    : Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                if (selected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                else
                                  const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.grey,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
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
