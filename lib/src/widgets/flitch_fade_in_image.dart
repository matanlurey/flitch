import 'package:flutter/widgets.dart';

class FlitchFadeInImage extends StatelessWidget {
  final String src;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;

  FlitchFadeInImage(
    this.src, {
    this.fadeInDuration = const Duration(
      milliseconds: 250
    ),
    this.fadeOutDuration = const Duration(
      milliseconds: 250
    ),
    Key key,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FadeInImage(
      placeholder: new AssetImage('assets/placeholder.png'),
      image: new NetworkImage(src),
      fit: BoxFit.cover,
      repeat: ImageRepeat.repeat,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
    );
  }
}
