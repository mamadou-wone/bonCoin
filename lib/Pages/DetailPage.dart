import 'package:bonCoin/Posts/post/post_app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailPage extends StatefulWidget {
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

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isfavirite = false;
  Widget build(BuildContext context) {
    Icon favoriteIcon = Icon(LineIcons.heart_o,
        color: PostAppTheme.buildLightTheme().primaryColor);
    Icon heartIcon = Icon(LineIcons.heart,
        color: PostAppTheme.buildLightTheme().primaryColor);
    return Container(
      child: Hero(
        tag: widget.photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
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
                            imageUrl: widget.photo,
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
                                        Text(
                                          widget.title,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              widget.category,
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
                                                widget.description,
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
                                                rating: widget.rating,
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
                                child: GestureDetector(
                                  child: isfavirite ? heartIcon : favoriteIcon,
                                  onTap: () {
                                    setState(() {
                                      isfavirite = !isfavirite;
                                    });
                                    // if (isfavirite) {
                                    //   print(widget.title);
                                    // }
                                  },
                                ),
                              ),
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
