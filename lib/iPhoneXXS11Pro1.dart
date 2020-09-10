import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class IiPhoneXXS11Pro1 extends StatelessWidget {
  IiPhoneXXS11Pro1({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(16.0, 75.0),
            child:
                // Adobe XD layer: 'Post' (group)
                SizedBox(
              width: 343.0,
              height: 567.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 343.0, 567.0),
                    size: Size(343.0, 567.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'Rectangle 235' (shape)
                        Container(
                      decoration: BoxDecoration(
                        color: const Color(0xfff1f9ff),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(14.0, 32.0, 149.0, 46.0),
                    size: Size(343.0, 567.0),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Big Title' (text)
                        Text(
                      'Big Title',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 40,
                        color: const Color(0xff2699fb),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(32.0, 142.0, 279.0, 82.0),
                    size: Size(343.0, 567.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Excepteur sint occa…' (text)
                        Text(
                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt. ',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 20,
                        color: const Color(0xff2699fb),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 256.0, 343.0, 207.0),
                    size: Size(343.0, 567.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Rectangle 930' (shape)
                        Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffbce0fd),
                      ),
                      child: Image.asset('assets/images/placeholder.jpg'),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(32.0, 495.0, 96.0, 40.0),
                    size: Size(343.0, 567.0),
                    pinLeft: true,
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Small Button' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 96.0, 40.0),
                          size: Size(96.0, 40.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                              // Adobe XD layer: 'Rectangle 151' (shape)
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                  width: 2.0, color: const Color(0xffbce0fd)),
                            ),
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(33.0, 15.0, 30.0, 11.0),
                          size: Size(96.0, 40.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'MORE' (text)
                              Text(
                            'MORE',
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 10,
                              color: const Color(0xff2699fb),
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
