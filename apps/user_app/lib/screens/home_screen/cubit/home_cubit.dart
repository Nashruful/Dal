import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final supabase = getIt.get<DataLayer>().supabase;

  HomeCubit() : super(HomeInitial());

  getAllAds() async {
    if (getIt.get<DataLayer>().allAds == null) {
      emit(LoadingState());
      try {
        getIt.get<DataLayer>().allAds =
            await supabase.from("ad").select('*,branch(*,business(*))');
        print("--------------- data fetched");
        emit(SuccessState());
      } on PostgrestException catch (e) {
        emit(ErrorState(msg: e.message));
      } on AuthException catch (e) {
        emit(ErrorState(msg: e.message));
      }
    } else {
      emit(SuccessState());
    }
  }
}
