import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_painter/story_painter.dart';

import 'dart:ui' as ui;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StoryPainterControl painterControl = StoryPainterControl(
    type: PainterDrawType.shape,
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
    color: Colors.black,
    width: 8,
    onDrawStart: () {},
    onDrawEnd: () {},
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('story_painter'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              ui.Image image = await painterControl.toImage(pixelRatio: 3.0);
              ByteData byteData =
                  await image.toByteData(format: ui.ImageByteFormat.png);
              var pngBytes = byteData.buffer.asUint8List();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OnlyImage(
                    imageData: pngBytes,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: StoryPainter(
        control: painterControl,
      ),
    );
  }
}

class OnlyImage extends StatelessWidget {
  final Uint8List imageData;

  const OnlyImage({Key key, this.imageData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image'),
      ),
      body: Image.memory(
        imageData,
      ),
    );
  }
}
