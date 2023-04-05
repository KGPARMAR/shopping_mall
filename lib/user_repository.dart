/*
*    @author     KGPARMAR
*    @project    online_shopping
*    @file_name  user_repository
*    @desc       Flutter Developer
*    @version    1.0.0
*    @since      1.0
*    @created on 05-Apr-23 9:24 PM
*    @updated on 05-Apr-23 9:24 PM
*    @Notes
*/
import 'dart:convert';

import 'package:http/http.dart';
import 'package:online_shopping/product_list_model.dart';

class UserRepository {
  String userUrl = 'http://205.134.254.135/~mobile/MtProject/public/api/product_list.php';

  Future<List<Data>> getUsers() async {
    Response response = await get(
      Uri.parse(userUrl),
      headers: {
        'token': 'eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Data.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
