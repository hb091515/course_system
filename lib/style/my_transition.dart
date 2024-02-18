import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> buildMyTranstion<T>({
  required Widget child,
  required Color color,
  String? name,
  Object? arguments,
  String? restorationId,
  LocalKey? key,
}) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return _MyReveal(child: child, animation: animation, color: color);
    },
    key: key,
    name: name,
    arguments: arguments,
    restorationId: restorationId,
    transitionDuration: const Duration(milliseconds: 500),
  );
}

class _MyReveal extends StatelessWidget {
  final Widget child;

  final Animation<double> animation;

  final Color color;

  final _slideTween = Tween(begin: const Offset(0, -1), end: Offset.zero);

  final _fadeTween = TweenSequence([
    TweenSequenceItem(tween: ConstantTween(0.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1)
  ]);

  _MyReveal({
    required this.child,
    required this.animation,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SlideTransition(
          position: _slideTween.animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeOutCubic,
            ),
          ),
          child: Container(
            color: color,
          ),
        ),
        FadeTransition(
          opacity: _fadeTween.animate(animation),
          child: child,
        ),
      ],
    );
  }
}