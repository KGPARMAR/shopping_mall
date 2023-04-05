/*
*    @author     KGPARMAR
*    @project    online_shopping
*    @file_name  app_states
*    @desc       Flutter Developer
*    @version    1.0.0
*    @since      1.0
*    @created on 05-Apr-23 9:23 PM
*    @updated on 05-Apr-23 9:23 PM
*    @Notes       
*/

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/model/product_list_model.dart';

@immutable
abstract class ProductState extends Equatable {}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<Data> products;

  ProductLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
