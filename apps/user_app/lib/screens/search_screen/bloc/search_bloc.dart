import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/models/all_ads_model.dart';
import 'package:user_app/setup/setup.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<Ads> ad = [];
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  List<Ads> ads = getIt.get<DataLayer>().allAds;
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});

    on<SearchAdsEvent>((event, emit) {
      ad = ads
          .where((e) => e.branch!.business!.name
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchQuery.trim().toLowerCase()))
          .toList();

      emit(SearchAdsState(ads: ad));
    });

  }
}
