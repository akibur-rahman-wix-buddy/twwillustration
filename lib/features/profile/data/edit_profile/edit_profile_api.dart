import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:twwillustration/features/profile/model/edit_profile_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostEditProfileAPI{
  static final PostEditProfileAPI _singleton = PostEditProfileAPI._internal();

  PostEditProfileAPI._internal();

  static PostEditProfileAPI get instance => _singleton;

  Future<Map<String,dynamic>> postEditProfileAPI(EditProfileModel profile) async{
    try{

      MultipartFile? avatarFile;

      if(profile.profileImage != null && await File(profile.profileImage!.path).exists()){
        avatarFile = await MultipartFile.fromFile(profile.profileImage!.path);
      }

      FormData data = FormData.fromMap({
        'first_name' : profile.firstName,
        'last_name' : profile.lastName,
        'bio' : profile.bio,
        if(avatarFile != null) 'avatar' : avatarFile,
        'email' : profile.email,
        'location' : profile.location,
        '_method' : 'PUT'
      });

      Response response = await postHttp(Endpoints.editProfileURL(), data);

      if(response.statusCode == 200){
        final data = jsonDecode(jsonEncode(response.data));
        ToastUtil.showShortToast('Profile update sucessfully');
        return data;
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print('Error during update : $error');
      rethrow;
    }
  }
}