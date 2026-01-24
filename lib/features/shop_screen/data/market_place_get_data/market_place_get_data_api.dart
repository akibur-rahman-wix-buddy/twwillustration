import 'package:dio/dio.dart';
import 'package:twwillustration/features/shop_screen/model/market_place_get_data_model.dart';
import 'package:twwillustration/networks/dio/dio.dart';
import 'package:twwillustration/networks/endpoints.dart';
import 'package:twwillustration/networks/exception_handler/data_source.dart';

final class MarketPlaceGetDataApi {
  static final MarketPlaceGetDataApi _singleton = MarketPlaceGetDataApi._internal();
  MarketPlaceGetDataApi._internal();

  static MarketPlaceGetDataApi get instance => _singleton;

  Future<MarketPlaceGetDataModel> marketPlaceGetDataApi() async{

    try{
      Response response = await getHttp(Endpoints.marketPlaceGetDataURL());

      if(response.statusCode == 200){
        final data = response.data;
        return MarketPlaceGetDataModel.fromJson(data);
      } else{
        throw DataSource.DEFAULT.getFailure();
      }
    } catch(error){
      print(error);
      rethrow;
    }
  }

}