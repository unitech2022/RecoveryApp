import 'package:discovery_zone/bloc/market_cubit/market_cubit.dart';
import 'package:discovery_zone/core/enums/loading_status.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/layout/palette.dart';
import 'package:discovery_zone/core/widgets/empty_list_widget.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:discovery_zone/ui/components/no_internet_widget.dart';
import 'package:discovery_zone/ui/markets_screen/components/list_markets_widget.dart';
import 'package:discovery_zone/ui/markets_screen/components/shimmer_market_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketsScreen extends StatefulWidget {
  final int id, type; // ** type  0 normaly 1 ==> markets
  final String title;
  const MarketsScreen(
      {super.key, required this.id, required this.type, required this.title});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    print(widget.id.toString() + widget.type.toString());
    fetchData();
  }

  Future<void> fetchData() async {
    if (widget.type == 0) {
      MarketCubit.get(context)
          .getMarketsByCategoryId(id: widget.id, context: context, page: 1);
    } else {
      MarketCubit.get(context)
          .getMarketsByFieldId(id: widget.id, context: context, page: 1);
    }

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        print(MarketCubit.get(context).totalPages);
        if (MarketCubit.get(context).currentPage <
            MarketCubit.get(context).totalPages) {
          MarketCubit.get(context).currentPage++;

          if (widget.type == 0) {
            MarketCubit.get(context).getMarketsByCategoryId(
                id: widget.id,
                context: context,
                page: MarketCubit.get(context).currentPage);
          } else {
            MarketCubit.get(context).getMarketsByFieldId(
                id: widget.id,
                context: context,
                page: MarketCubit.get(context).currentPage);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: const BackButton(
            color: Palette.mainColor,
          ),
          title: Texts(
            title: widget.title,
            family: AppFonts.caB,
            size: 25,
            textColor: Palette.mainColor,
            height: 2.0,
          ),
          // actions: const [IconAlertWidget()],
        ),
        body: BlocBuilder<MarketCubit, MarketState>(builder: (context, state) {
          switch (state.getMarketsState) {
            case RequestState.noInternet:
              return NoInternetWidget(
                onPress: () {
                  if (widget.type == 0) {
                    MarketCubit.get(context).getMarketsByCategoryId(
                        id: widget.id, context: context, page: 1);
                  } else {
                    MarketCubit.get(context).getMarketsByFieldId(
                        id: widget.id, context: context, page: 1);
                  }
                },
              );
            case RequestState.loaded:
              return MarketCubit.get(context).markets.isEmpty
                  ? EmptyListWidget(message: "لا توجد متاجر".tr())
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          ListMarketsWidget(
                              markets: MarketCubit.get(context).markets),
                          const SizedBox(
                            height: 20,
                          ),
                          state.getMarketsState == RequestState.pagination
                              ? const SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: CircularProgressIndicator(),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ));

            case RequestState.error:
            case RequestState.loading:
              return const ShimmerMarketWidget();
            default:
              return const ShimmerMarketWidget();
          }
        }));
  }
}
