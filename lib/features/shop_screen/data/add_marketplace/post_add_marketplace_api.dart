import 'dart:io';
import 'package:dio/dio.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class PostAddMarketplaceApi {
  static final PostAddMarketplaceApi _singleton =
      PostAddMarketplaceApi._internal();

  PostAddMarketplaceApi._internal();

  static PostAddMarketplaceApi get instance => _singleton;

  Future<Map<String, dynamic>> postAddMarketplaceApi({
    required int productId,
    required List<String> images,
    required String title,
    required String description,
    required String category,
    required String size,
    required String brand,
    required String condition,
    required String price,
    required String shippingOption,
  }) async {
    try {
      /// 🔹 Base form data
      final formData = FormData.fromMap({
        'closet_id': productId.toString(),
        'title': title,
        'description': description,
        'category': category,
        'size': size,
        'brand': brand,
        'condition': condition,
        'price': price,
        'shipping_option': shippingOption,
      });

      /// 🔹 Images
      for (int i = 0; i < images.length; i++) {
        final imagePath = images[i];

        // Network image (URL)
        if (imagePath.startsWith('http')) {
          formData.fields.add(
            MapEntry('network_images[]', imagePath),
          );
        }
        // Local file
        else {
          final file = File(imagePath);
          if (await file.exists()) {
            formData.files.add(
              MapEntry(
                'images[]',
                await MultipartFile.fromFile(
                  imagePath,
                  filename: imagePath.split('/').last,
                ),
              ),
            );
          }
        }
      }

      /// 🔹 API Call
      final Response response = await postHttp(
        Endpoints.postAddMarketplaceURL(),
        formData,
      );

      /// 🔹 Success
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print('>>>>> error during postAddMarketplaceApi : $error <<<<<<<<<<<<<');
      rethrow;
    }
  }
}
