import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_ui/models/movie.dart';
import 'package:flutter_ui/presentation/detail_page.dart';
import 'package:flutter_ui/providers/movie_provider.dart';
import 'package:get/get.dart';
import 'package:flutter_offline/flutter_offline.dart';



class TabBarWidgets extends StatelessWidget {
  final Categories categories;
  final String keys;
  TabBarWidgets(this.categories, this.keys);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OfflineBuilder(
            child: Container(),
            connectivityBuilder: (c, co, ch) {
              final bool connected = co != ConnectivityResult.none;
              return connected ? Consumer(
                  builder: (context, ref, child) {
                    final movieData = ref.watch(movieProvider(categories));
                    final data = categories == Categories.top_rated ? movieData
                        .topRatedMovies :
                    categories == Categories.upcoming
                        ? movieData.upcomingMovies
                        : movieData.popularMovies;
                    return movieData.isLoaded ? Center(
                        child: CircularProgressIndicator()) : movieData
                        .errorMessage.isNotEmpty ?
                    Center(child: Text(movieData.errorMessage))
                        : Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: NotificationListener(
                        onNotification: (ScrollEndNotification onNotification) {
                          final before = onNotification.metrics.extentBefore;
                          final max = onNotification.metrics.maxScrollExtent;
                          if (before == max) {
                            ref.read(movieProvider(categories).notifier).loadMore();
                          }
                          return true;
                        },
                        child: GridView.builder(
                            key: PageStorageKey(keys),
                            itemCount: data.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: 2 / 3,
                                crossAxisCount: 3
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Get.to(() => DetailPage(data[index]),
                                        transition: Transition.leftToRight),
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: data[index].poster_path,
                                      errorWidget: (c, s, d) {
                                        return Center(child: Image.asset(
                                            'assets/images/movie.png'));
                                      },
                                      placeholder: (c, s) {
                                        return Container(
                                          height: 150.h,
                                          child: Center(
                                            child: SpinKitFadingCube(
                                              color: Colors.pink,
                                              size: 34.w,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                    );
                  }
              ) : Center(child: Text('No Internet'));
            }
        )
    );
  }
}