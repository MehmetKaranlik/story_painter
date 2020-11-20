# story_painter
This package provides drawing experince like in story editor of Instagram.

**story_painter** is a modified version of the [hand_signature](https://pub.dev/packages/hand_signature).

## Usage

Initialize the controller

``` Dart
StoryPainterControl painterControl = StoryPainterControl(
    type: PainterDrawType.shape,
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
    color: Colors.white,
    width: 8,
    onDrawStart: () {},
    onDrawEnd: () {},
);
```

Build StoryPainter with controller

``` Dart
StoryPainter(control: painterControl)
```

Change brush specs while drawing

``` Dart
painterControl.setColor(Colors.red);
painterControl.setWidth(24.0);
```

Export the image

``` Dart
ui.Image image = await painterControl.toImage(pixelRatio: 3.0);
```

Display or use the output

``` Dart
// Convert the data
ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
Uint8List pngBytes = byteData.buffer.asUint8List();

// Display with memory image
Image.memory(pngBytes)
```

