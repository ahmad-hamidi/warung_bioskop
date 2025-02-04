import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/misc/router_name.dart';
import 'package:warung_bioskop/presentation/pages/movie_page/methods/movie_list.dart';
import 'package:warung_bioskop/presentation/pages/movie_page/methods/promotion_list.dart';
import 'package:warung_bioskop/presentation/pages/movie_page/methods/search_bar.dart';
import 'package:warung_bioskop/presentation/pages/movie_page/methods/user_info.dart';
import 'package:warung_bioskop/presentation/providers/movie/now_playing_provider.dart';
import 'package:warung_bioskop/presentation/providers/movie/upcoming_provider.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionImages = const [
    'poster1.png',
    'poster2.png',
    'poster3.png',
  ];

  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(userDataProvider).valueOrNull;

    return ListView(
      children: [
        userInfo(userModel),
        verticalSpace(20),
        searchBar(context),
        verticalSpace(20),
        ...movieList(
          title: 'Now Playing',
          movies: ref.watch(nowPlayingProviderProvider),
          onTap: (item) {
            ref.read(routerProvider).pushNamed(RouterName.detail, extra: item);
          },
        ),
        ...promotionList(promotionImages),
        verticalSpace(20),
        ...movieList2(
          title: 'Upcoming',
          movies: ref.watch(upcomingProviderProvider),
          onTap: (item) {
            ref.read(routerProvider).pushNamed(RouterName.detail, extra: item);
          },
        ),
        verticalSpace(100),
      ],
    );
  }
}
