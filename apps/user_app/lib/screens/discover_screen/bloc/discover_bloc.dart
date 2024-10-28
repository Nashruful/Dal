import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  Position? position;

  DiscoverBloc() : super(DiscoverInitial()) {
    on<DiscoverEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadScreenEvent>((event, emit) async {
      emit(LoadingState());
      final LocationSettings locationSettings = LocationSettings();
      position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      emit(SuccessState());
    });
  }
}