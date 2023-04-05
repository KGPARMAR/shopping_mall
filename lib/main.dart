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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/app_blocs.dart';
import 'package:online_shopping/app_events.dart';
import 'package:online_shopping/app_states.dart';
import 'package:online_shopping/data_base.dart';
import 'package:online_shopping/product_list_model.dart';
import 'package:online_shopping/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Mall',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Shopping Mall'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataBase handler = DataBase();

  Future<int> addPlanets(Data userList) async {
    return await handler.insertPlanets([userList]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(
            UserRepository(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            GestureDetector(
                onTap: () async {
                  var temp = await handler.retrievePlanets();
                  print(temp.length);
                  print(temp);
                },
                child: Icon(Icons.work_outline_sharp))
          ],
        ),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(UserRepository())..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserErrorState) {
            return const Center(child: Text("Error"));
          }
          if (state is UserLoadedState) {
            List<Data> userList = state.users;
            return GridView.builder(
              itemCount: userList.length,
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
                    // color: Theme.of(context).primaryColor,
                    child: Stack(
                      children: [
                        Container(
                          height: 200.0,
                          alignment: Alignment.center,
                          child: Image.network(
                            userList[index].featuredImage.toString(),
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
                                    '${userList[index].title}  ${userList[index].price}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(addPlanets(userList[index]));
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
            );
          }

          return Container();
        },
      ),
    );
  }
}
