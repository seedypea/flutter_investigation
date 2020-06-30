import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:logging/logging.dart';

import 'package:investigation/global.dart';

final cameraLogger = Logger('Camera');

class CameraPage extends StatefulWidget {

  static const String route = '/camera';

  // ctr
  const CameraPage({
    Key key
  }) : super(key: key);

  /// methods

  bool isCameraAvailable() => availableDeviceCameras.length > 0;

  @override
  _CameraPageState createState() => _CameraPageState();  

}

class _CameraPageState extends State<CameraPage> {

  CameraDescription _camera;
  CameraController _controller;
  Future<void> _initialiseControllerFuture;  

  Future<void> initialise() async {

    // make sure we have a camera
    if (!widget.isCameraAvailable()) {
      return Future<void>.value();
    }

    // grab the first
    _camera = availableDeviceCameras.first;      

    print(_camera);

    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      _camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );      

    // initialise the controller
    return _controller.initialize();

  }

  @override
  void initState() {

    super.initState();

    _initialiseControllerFuture = initialise();

  }

  @override
  void dispose() {
    // dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initialiseControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            
            // the Future is complete, 
            if (widget.isCameraAvailable())
            {
              // display the preview.
              return CameraPreview(_controller);

            } else {

              return Center(child: Text('no camera available :(', style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).primaryColor)));

            }

          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Visibility(
        // only show the button if a camera is available
        visible: widget.isCameraAvailable(),
        child: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          // Provide an onPressed callback.
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initialiseControllerFuture;

              // Construct the path where the image should be saved using the
              // pattern package.
              final path = join(
                // Store the picture in the temp directory.
                // Find the temp directory using the `path_provider` plugin.
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );

              // Attempt to take a picture and log where it's been saved.
              await _controller.takePicture(path);

              // If the picture was taken, display it on a new screen.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(imagePath: path),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              cameraLogger.severe(e);
            }
          },
        ),
      ),
    );
  }

}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}