import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final supabase = getIt.get<DataLayer>().supabase;

  List<Map<String, dynamic>>? allAds;

  HomeCubit() : super(HomeInitial());

  getAllAds() async {
    emit(LoadingState());

    try {
      allAds = await supabase.from("ad").select('*');
      emit(SuccessState());
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    }
    try {} on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    }
  }
}
