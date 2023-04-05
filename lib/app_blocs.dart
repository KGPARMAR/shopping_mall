/*
*    @author     KGPARMAR
*    @project    online_shopping
*    @file_name  app_blocs
*    @desc       Flutter Developer
*    @version    1.0.0
*    @since      1.0
*    @created on 05-Apr-23 9:24 PM
*    @updated on 05-Apr-23 9:24 PM
*    @Notes       
*/
// import 'package:bloc_example/blocs/app_events.dart';
// import 'package:bloc_example/blocs/app_states.dart';
// import 'package:bloc_example/repos/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/app_events.dart';
import 'package:online_shopping/app_states.dart';
import 'package:online_shopping/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}