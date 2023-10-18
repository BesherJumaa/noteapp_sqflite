import 'package:flutter/material.dart';

class SlideRight extends PageRouteBuilder {
  final Page;
  SlideRight({this.Page})
      : super(
            pageBuilder: (context, animation, animationtow) => Page,
            transitionsBuilder: (context, animation, animationtow, child) {
              //  var begin = Offset(1, 1);
              //  var end = Offset(0, 0);
              const Duration(seconds: 3);
              double begin = 0;
              double end = 1;
              var tween = Tween(begin: begin, end: end);
              var curvesanimation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              return ScaleTransition(
                  scale: tween.animate(curvesanimation),
                  child: Align(
                    alignment: Alignment.center,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ));
              // Align(
              //   alignment: Alignment.center,
              //   child: SizeTransition(
              //     sizeFactor: animation,
              //     child: child,
              //   )
              //     FadeTransition(
              //   opacity: animation,
              //   child: child,
              // );
            });
}
