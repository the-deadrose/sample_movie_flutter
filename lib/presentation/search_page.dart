import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_ui/presentation/detail_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/movie_state.dart';
import '../providers/search_movie_provider.dart';



class SearchPage extends ConsumerWidget {

  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final movieData = ref.watch(searchProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: searchTextController,
                autofocus: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    hintText: 'search for movies'
                ),
                onFieldSubmitted: (val){
                  ref.read(searchProvider.notifier).getSearchMovie(val);
                  searchTextController.clear();
                },
              ),
              SizedBox(height: 10,),
              Expanded(child: _MovieWidget(movieData: movieData)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MovieWidget extends StatelessWidget {
  const _MovieWidget({Key? key,
    required this.movieData,
  }) : super(key: key);

  final MovieState movieData;



  @override
  Widget build(BuildContext context) {
    if(movieData.isLoaded){
      return Center(child: CircularProgressIndicator(),);
    }else if(movieData.errorMessage.isNotEmpty){
      return Center(child: Text(movieData.errorMessage));
    }else{
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
            itemCount: movieData.searchMovies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 2/3,
                crossAxisCount: 3
            ),
            itemBuilder: (context, index){
              return InkWell(
                onTap: () => Get.to(()=> DetailPage(movieData.searchMovies[index]), transition: Transition.leftToRight),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: movieData.searchMovies[index].poster_path,
                      errorWidget: (c, s, d){
                        return Image.asset('assets/images/movie.png');
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
      );

    }

  }
}