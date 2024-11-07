import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impression/impression.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/models/all_ads_model.dart';
import 'package:user_app/screens/search_screen/bloc/search_bloc.dart';
import 'package:user_app/setup/setup.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SearchBloc>();
        return Scaffold(
          appBar: CustomAppBar(
              title: "Search".tr(), automaticallyImplyLeading: true),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    controller: bloc.searchController,
                    onChanged: (value) {
                      bloc.searchQuery = value;
                      bloc.add(SearchAdsEvent());
                    },
                    decoration: InputDecoration(
                      hintText: "Search hint text".tr(),
                      hintStyle: TextStyle(color: AppColors().grey2),
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Theme.of(context).canvasColor,
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors().grey2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      List<Ads> ads = [];
                      if (state is SearchAdsState) {
                        ads = state.ads;
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(children: [
                              ...ads.map((ad) {
                                return ImpressionDetector(
                                  impressedCallback: () {
                                    getIt.get<DataLayer>().recordImpressions(ad
                                        .id!); //add impressions to ad id each time it is viewed
                                  },
                                  child: searchAdsCard(
                                    companyName:
                                        ad.branch!.business!.name ?? '---',
                                    offerType: ad.offerType ?? '----',
                                    companyLogo: ad.bannerimg ??
                                        'https://img.freepik.com/free-vector/anime-chibi-boy-wearing-cap-character_18591-82515.jpg',
                                    viewLocation: 'View Location'.tr(),
                                    locationOnPressed: () async {
                                      final availableMaps =
                                          await MapLauncher.installedMaps;

                                      if (availableMaps.isNotEmpty) {
                                        await availableMaps.first.showMarker(
                                          coords: Coords(ad.branch!.latitude!,
                                              ad.branch!.longitude!),
                                          title: ad.branch!.business!.name!,
                                        );
                                      } else {
                                        // Handle the case where no maps are installed

                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'No maps are installed on this device.'
                                                      .tr())),
                                        );
                                      }
                                    },
                                    description: ad.description!,
                                  ),
                                );
                              }),
                            ]),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
