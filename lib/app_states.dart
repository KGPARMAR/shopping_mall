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
import 'package:online_shopping/product_list_model.dart';

@immutable
abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<Data> users;
  UserLoadedState(this.users);
  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}