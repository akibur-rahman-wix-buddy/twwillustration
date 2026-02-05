import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/streams.dart';
import 'package:twwillustration/features/shop_screen/data/get_marketplace_wardrobe_filters/get_marketplace_wardrobe_filters_api.dart';
import 'package:twwillustration/features/shop_screen/model/get_marketplace_wardrobe_filters_data_model.dart';
import 'package:twwillustration/helpers/toast.dart';
import 'package:twwillustration/networks/rx_base.dart';

final class GetMarketplaceWardrobeFiltersRx extends RxResponseInt<GetMatketplaceWardrobeFiltersDataModel>{
  final api = GetMarketplaceWardrobeFiltersApi.instance;

  GetMarketplaceWardrobeFiltersRx({required super.empty, required super.dataFetcher});

  ValueStream get getMarketplaceWardrobeFiltersData => dataFetcher.stream;

  Future<bool> getMarketplaceWardrobeFiltersRx() async{
    try{
      GetMatketplaceWardrobeFiltersDataModel data = await api.getMarketplaceWardrobeFiltersApi();

      await handleSuccessWithReturn(data);
      return true;
    } catch(error){
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(GetMatketplaceWardrobeFiltersDataModel data) {
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(error) {
    if(error is DioException){
      if(error.response!.statusCode == 400){
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else{
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}