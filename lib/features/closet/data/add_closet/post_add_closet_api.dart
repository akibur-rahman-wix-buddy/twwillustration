import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:twwillustration/features/closet/model/post_add_closet_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';
import 'package:http_parser/http_parser.dart';

final class PostAddClosetApi {
  static final PostAddClosetApi _singleton = PostAddClosetApi._internal();
  PostAddClosetApi._internal();

  static PostAddClosetApi get instance => _singleton;

  Future<Map<String, dynamic>> postAddClosetApi(
      PostAddClosetModel closet) async {
    try {
      FormData data = FormData();

// categories array
      data.fields.addAll(closet.categories
          .map((c) => MapEntry('categories[]', c['id'].toString())));

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

// image file
      data.files.add(MapEntry(
        'image',
        MultipartFile.fromBytes(
          closet.image,
          filename: 'closet_${DateTime.now().millisecondsSinceEpoch}.png',
          contentType: MediaType('image', 'png'),
        ),
      ));

      Response response = await postHttp(Endpoints.postAddClosetURL(), data);

      if (response.statusCode == 200) {
        final data = jsonDecode(jsonEncode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print('>>>>> error during : $error <<<<<<<<<<<<<');
      rethrow;
    }
  }
}
