import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:twwillustration/features/closet/model/get_single_closet_data_model.dart';
import 'package:twwillustration/features/closet/model/update_closet_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class UpdateClosetApi {
  static final UpdateClosetApi _singleton = UpdateClosetApi._internal();
  UpdateClosetApi._internal();

  static UpdateClosetApi get instance => _singleton;

  Future<Map<String, dynamic>> updateClosetApi(
      PostUpdateClosetModel closet, int closetId) async {
    try {
      FormData data = FormData();

      data.fields.addAll(closet.categories.map((c) {
        if (c is Map<String, dynamic>) {
          return MapEntry('categories[]', c['id'].toString());
        } else if (c is Categories) {
          return MapEntry('categories[]', c.id.toString());
        } else if (c is int) {
          return MapEntry('categories[]', c.toString());
        } else {
          throw Exception("Invalid category type: $c");
        }
      }));

// color array
      data.fields.addAll(
          closet.colors.map((color) => MapEntry('color[]', color.toString())));

// normal fields
      data.fields.add(MapEntry('title', closet.title));
      data.fields.add(MapEntry('occasion', closet.occation ?? ''));
      data.fields.add(MapEntry('brand', closet.brand ?? ''));
      data.fields.add(MapEntry('material_id', closet.materialId.toString()));
      data.fields.add(MapEntry('pattern', closet.pattern));
      data.fields.add(MapEntry('visibility', closet.visibility.toLowerCase()));
      data.fields.add(MapEntry('season', closet.season?.toLowerCase() ?? ''));
      data.fields.add(MapEntry('size', closet.size ?? ''));
      data.fields.add(MapEntry('price', closet.price ?? ''));

      if (closet.purchasedDate != null) {
        data.fields.add(MapEntry(
          'purchased_date',
          DateFormat('yyyy-MM-dd').format(closet.purchasedDate!),
        ));
      }

      // data.files.add(MapEntry('image', closet.image));
      // data.files.add(MapEntry(
      //   'image',
      //   MultipartFile.fromString(
      //     closet.image,
      //     filename: 'closet_${DateTime.now().millisecondsSinceEpoch}.png',
      //     contentType: MediaType('image', 'png'),
      //   ),
      // ));
      data.fields.add(MapEntry('_method', 'PUT'));

      Response response =
          await postHttp(Endpoints.postUpdateClosetURL(closetId), data);

      if (response.statusCode == 200) {
        final data = jsonDecode(jsonEncode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      debugPrint('error during : $error');
      rethrow;
    }
  }
}
