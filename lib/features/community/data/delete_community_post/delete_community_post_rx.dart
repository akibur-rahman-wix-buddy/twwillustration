import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/community/data/delete_community_post/delete_community_post_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class DeleteCommunityPostRx extends RxResponseInt<Map<String, dynamic>>{
  final api = DeleteCommunityPostApi.instance;

  DeleteCommunityPostRx({
    required super.empty,
    required super.dataFetcher
  });

  ValueStream get getDeleteCommunityPostData => dataFetcher.stream;

  Future<bool> deleteCommunityPostRx(int postId) async{
    try{
      Map<String, dynamic> data = await api.deleteCommunityPostApi(postId);

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    dataFetcher.sink.add(data);

    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["error"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}