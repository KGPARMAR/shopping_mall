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
import 'package:online_shopping/model/product_list_model.dart';
import 'package:online_shopping/repo/data_base.dart';

class CartListScreen extends StatefulWidget {
  CartListScreen({super.key, required this.title});

  final String title;

  @override
  State<CartListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<CartListScreen> {
  DataBase handler = DataBase();

  Future<int> addPlanets(Data productsList) async {
    return await handler.insertProducts([productsList]);
  }

  @override
  void initState() {
    super.initState();
    getCartList();
  }

  List<Data> productsList = [];

  Future<void> getCartList() async {
    productsList = await handler.retrieveProducts();
    productsList.forEach((element) {
      print(element.title);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () async {},
            child: Icon(
              Icons.work_outline_sharp,
            ),
          )
        ],
      ),
      body: GridView.builder(
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
                              var temp = addPlanets(productsList[index]);
                              print(temp);
                            },
                            child: Icon(Icons.work_outline_sharp),
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
      ),
    );
  }
}
