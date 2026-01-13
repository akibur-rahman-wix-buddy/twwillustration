import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:twwillustration/features/community/model/post_add_post_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostAddPostApi {
  static final PostAddPostApi _singleton = PostAddPostApi._internal();
  PostAddPostApi._internal();

  static PostAddPostApi get instance => _singleton;

  Future<Map<String, dynamic>> postAddPostApi(PostAddPostDataModel post) async{
    try{

      MultipartFile avatarFile = await MultipartFile.fromFile(post.image.path);
      

      FormData data = FormData();

      data.fields.add(MapEntry('caption', post.caption));
      data.fields.addAll(
          post.tags.map((color) => MapEntry('color[]', color.toString())));
      data.files.add(MapEntry('media_path', avatarFile));    
      data.fields.add(MapEntry('visibility', post.visibility));

      Response response = await postHttp(Endpoints.postAddPostURL(), data);

      if(response.statusCode == 200){
        final data = jsonDecode(jsonEncode(response.data));
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('>>>>>>>>> error during : $error <<<<<<<<<<');
      rethrow;
    }
  }
}