import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twwillustration/features/chat/data/send_message/send_message_api.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class SendMessageRx extends RxResponseInt<Map<String, dynamic>> {
  final api = SendMessageApi.instance;

  SendMessageRx({
    required super.empty,
    required super.dataFetcher,
  });

  ValueStream get getMessageData => dataFetcher.stream;

  Future<bool> sendMessageRx({
    required int receiverId,
    String? message,
    List<String>? images,
  }) async {
    try {
      if ((message == null || message.isEmpty) && 
          (images == null || images.isEmpty)) {
        ToastUtil.showShortToast('Please provide a message or image');
        return false;
      }

      Map<String, dynamic> data = await api.sendMessageApi(
        receiverId: receiverId,
        message: message,
        images: images,
      );

      print('>>>>>>>>>images : ${images?.first.toString()}');

      await handleSuccessWithReturn(data);
      ToastUtil.showShortToast('Message sent successfully');
      return true;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  Future<bool> sendTextMessageRx({
    required int receiverId,
    required String message,
  }) async {
    return await sendMessageRx(
      receiverId: receiverId,
      message: message,
    );
  }

  Future<bool> sendImagesRx({
    required int receiverId,
    required List<String> images,
  }) async {
    return await sendMessageRx(
      receiverId: receiverId,
      images: images,
    );
  }

  Future<bool> sendTextWithImagesRx({
    required int receiverId,
    required String message,
    required List<String> images,
  }) async {
    return await sendMessageRx(
      receiverId: receiverId,
      message: message,
      images: images,
    );
  }

  @override
  handleSuccessWithReturn(Map<String, dynamic> data) {
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(error) {
    if (error is DioException) {
      if (error.response?.statusCode == 400) {
        ToastUtil.showShortToast(
          error.response?.data["message"] ?? 'Failed to send message'
        );
      } else if (error.response?.statusCode == 413) {
        ToastUtil.showShortToast('Images are too large');
      } else {
        ToastUtil.showShortToast(
          error.response?.data["message"] ?? 'Something went wrong'
        );
      }
    } else {
      ToastUtil.showShortToast('Failed to send message');
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}