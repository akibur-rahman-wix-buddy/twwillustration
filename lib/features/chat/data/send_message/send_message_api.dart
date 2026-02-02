import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class SendMessageApi {
  static final SendMessageApi _singleton = SendMessageApi._internal();
  SendMessageApi._internal();
  static SendMessageApi get instance => _singleton;

  Future<Map<String, dynamic>> sendMessageApi({
    required int receiverId,
    String? message,
    List<String>? images,
  }) async {
    try {
      // Create FormData
      FormData formData = FormData();
      formData.fields.add(MapEntry('receiver_id', receiverId.toString()));
      formData.fields.add(MapEntry('product_id', ''));

      if (message != null && message.isNotEmpty) {
        formData.fields.add(MapEntry('message', message));
      }

      if (images != null && images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          String imagePath = images[i];
          String fileName = imagePath.split('/').last;

          formData.files.add(
            MapEntry(
              'images[]',
              await MultipartFile.fromFile(
                imagePath,
                filename: fileName,
              ),
            ),
          );
        }
      }

      debugPrint('>>>>>> Sending to: ${Endpoints.postSendMessageURL()} <<<<<<');
      debugPrint('>>>>>> Receiver ID: $receiverId <<<<<<');
      debugPrint('>>>>>> Message: $message <<<<<<');

      Response response = await postHttp(
        Endpoints.postSendMessageURL(),
        formData,
      );

      debugPrint('>>>>>> Response Status: ${response.statusCode} <<<<<<');
      debugPrint('>>>>>> Response Data: ${response.data} <<<<<<');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      debugPrint('error during send message: $error >>>>>>>>>>>>>>>>>>');
      if (error is DioException) {
        debugPrint('DioException response: ${error.response?.data}');
        debugPrint('DioException statusCode: ${error.response?.statusCode}');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> sendTextMessageApi({
    required int receiverId,
    required String message,
  }) async {
    return await sendMessageApi(
      receiverId: receiverId,
      message: message,
    );
  }

  Future<Map<String, dynamic>> sendImagesApi({
    required int receiverId,
    required List<String> images,
  }) async {
    return await sendMessageApi(
      receiverId: receiverId,
      images: images,
    );
  }

  Future<Map<String, dynamic>> sendTextWithImagesApi({
    required int receiverId,
    required String message,
    required List<String> images,
  }) async {
    return await sendMessageApi(
      receiverId: receiverId,
      message: message,
      images: images,
    );
  }
}
