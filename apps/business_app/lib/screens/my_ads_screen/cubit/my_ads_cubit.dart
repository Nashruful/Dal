import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:meta/meta.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  MyAdsCubit() : super(MyAdsInitial());

  deleteAd(String adId) async {
    emit(LoadingAdsState());

    await getIt.get<DataLayer>().supabase.from('ad').delete().eq('id', adId);
    await refreshInfo();
    emit(SuccessDeleteState());
  }

  refreshInfo() async {
    await getIt.get<DataLayer>().getBusinessInfo(); //refresh info list
  }
}
