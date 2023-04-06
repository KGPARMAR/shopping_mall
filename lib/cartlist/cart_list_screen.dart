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

  double totalPrice = 0.0;

  Future<void> deleteProducts(Data productsList) async {
    await handler.deleteProduct(productsList.id!);
    getCartList();
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
      totalPrice += double.parse('${element.price}');
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50.0),
              child: ListView.builder(
                itemCount: productsList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (_, index) {
                  return Card(
                    child: Row(
                      children: [
                        Container(
                          height: 150.0,
                          width: 150.0,
                          alignment: Alignment.center,
                          child: Image.network(
                            productsList[index].featuredImage.toString(),
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${productsList[index].title}',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Price',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '\$ ${productsList[index].price}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Quantity',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '1',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  deleteProducts(productsList[index]);
                                  const snackBar = SnackBar(
                                    content: Text('Item delete successfully!'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);;
                                },
                                child: Icon(Icons.delete),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Items : ${productsList.length}'),
                    Text('Grand Total: ${totalPrice}'),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
