/*
*    @author     KGPARMAR
*    @project    online_shopping
*    @file_name  main
*    @desc       Flutter Developer
*    @version    1.0.0
*    @since      1.0
*    @created on 05-Apr-23 9:20 PM
*    @updated on 05-Apr-23 9:20 PM
*    @Notes
*/
import 'package:flutter/material.dart';
import 'package:online_shopping/productlist/product_blocs.dart';
import 'package:online_shopping/productlist/product_list_screen.dart';
import 'package:online_shopping/repo/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ShoppingMall());
}

class ShoppingMall extends StatelessWidget {
  const ShoppingMall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShoppingMallState();
  }
}

class ShoppingMallState extends StatefulWidget {
  const ShoppingMallState({Key? key}) : super(key: key);

  @override
  _Shopping createState() => _Shopping();
}

class _Shopping extends State<ShoppingMallState> {
  ProductBloc? productBloc;
  ProductRepository? productRepository;

  @override
  void initState() {
    productRepository = ProductRepository();
    productBloc = ProductBloc(productRepository!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Mall',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListScreen(title: 'Shopping Mall', productBloc: productBloc, productRepository: productRepository),
    );
  }
}
