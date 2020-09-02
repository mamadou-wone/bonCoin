import 'package:bonCoin/Posts/post/post_app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(
      {Key key,
      this.photo,
      this.onTap,
      this.width,
      this.rating,
      this.screenHeight,
      this.screenWidth,
      this.title,
      this.category,
      this.description})
      : super(key: key);

  final String title;
  final String category;
  final String description;
  final String photo;
  final VoidCallback onTap;
  final double width;
  final double rating;
  final double screenWidth;
  final double screenHeight;

  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 0.7,
                          child: CachedNetworkImage(
                            imageUrl: photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          color: PostAppTheme.buildLightTheme().backgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Text(
                                        //   title,
                                        //   textAlign: TextAlign.left,
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.w600,
                                        //     fontSize: 22,
                                        //   ),
                                        // ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              category,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey
                                                      .withOpacity(0.8)),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                description,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: <Widget>[
                                              SmoothStarRating(
                                                allowHalfRating: true,
                                                starCount: 5,
                                                rating: rating,
                                                size: 20,
                                                color: PostAppTheme
                                                        .buildLightTheme()
                                                    .primaryColor,
                                                borderColor: PostAppTheme
                                                        .buildLightTheme()
                                                    .primaryColor,
                                              ),
                                              Text(
                                                ' Note',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
