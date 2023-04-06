/*
*    @author     KGPARMAR
*    @project    online_shopping
*    @file_name  ProductListScreen
*    @desc       Flutter Developer
*    @version    1.0.0
*    @since      1.0
*    @created on 05-Apr-23 10:53 PM
*    @updated on 05-Apr-23 10:53 PM
*    @Notes       
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/cartlist/cart_list_screen.dart';
import 'package:online_shopping/model/product_list_model.dart';
import 'package:online_shopping/productlist/product_blocs.dart';
import 'package:online_shopping/productlist/product_events.dart';
import 'package:online_shopping/productlist/product_states.dart';
import 'package:online_shopping/repo/data_base.dart';
import 'package:online_shopping/repo/user_repository.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key, required this.title, this.productBloc, this.productRepository});

  ProductBloc? productBloc;
  ProductRepository? productRepository;
  final String title;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DataBase handler = DataBase();
  ScrollController? controller;
  int page = 1;

  Future<int> addProducts(Data productsList) async {
    return await handler.insertProducts([productsList]);
  }

  void _scrollListener() {
    /*if (controller!.position.extentAfter < 500) {
      page++;
      widget.productBloc!..add(LoadProductEvent(page));
    }*/
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller!.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (BuildContext context) => widget.productBloc!,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            GestureDetector(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CartListScreen(
                      title: 'My Cart',
                    ),
                  ),
                );
              },
              child: Icon(Icons.add_shopping_cart_outlined),
            )
          ],
        ),
        body: BlocProvider(
          create: (context) => widget.productBloc!..add(LoadProductEvent(page)),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductErrorState) {
                return const Center(child: Text("Error"));
              }
              if (state is ProductLoadedState) {
                List<Data> productsList = state.products;
                return GridView.builder(
                  controller: controller,
                  itemCount: productsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) {
                    return Container(
                      height: 250.0,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Card(
                        child: Stack(
                          children: [
                            Container(
                              height: 200.0,
                              alignment: Alignment.center,
                              child: Image.network(
                                productsList[index].featuredImage.toString(),
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 50.0,
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${productsList[index].title}  ${productsList[index].price}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        addProducts(productsList[index]);
                                        const snackBar = SnackBar(
                                          content: Text('Item added successfully!'),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      child: Icon(Icons.add_shopping_cart_outlined),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
