import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';
import 'package:image/image.dart' as img;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase ML Kit',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CustomMLModel(),
    );
  }
}

class CustomMLModel extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CustomMLModelState();
}

class _CustomMLModelState extends State<CustomMLModel> {

  File selectedImageFile;

  FirebaseModelInterpreter interpreter = FirebaseModelInterpreter.instance;
  FirebaseModelManager manager = FirebaseModelManager.instance;
  List<String> modelLabels = [];
  Map<String, double> predictions = Map<String, double>();
  int imageDim = 64;
  List<int> inputDims = [1, 64, 64, 1]; //35887, 3  //1, 256, 256, 3
  List<int> outputDims = [1, 7]; //1, 15

  @override
  void initState() {
    super.initState();
    //
    loadTFliteModel();
  }

  loadTFliteModel() async {
    try {
      manager.registerLocalModelSource(
          FirebaseLocalModelSource(
              assetFilePath: "assets/models/emotions.tflite",
              //mobilenet_v1_1.0_224_quant.tflite
              modelName: "mobilenet_v1_1.0_224_quant"
          )
      );
      //
      rootBundle.loadString('assets/models/labels_mobilenet_quant_v1_224.txt').then((string) {
        var _labels = string.split('\n');
        _labels.removeLast();
        modelLabels = _labels;
      });
      print('model loaded successfully');
      //
    } catch (e) {
      print('local model loading error');
    }
  }

  _pickPicture() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selectedImageFile = image;
      });
      print('image loaded');
      // print(image.path);
      predict(selectedImageFile);
    }
  }

  predict(File imageFile) async {
    try {
      //
      predictions = Map<String, double>();
      //
      var bytes = await imageToByteListFloat(imageFile, imageDim);
      // var bytes = await imageToByteListFloat1(imageFile, imageDim);
      // var bytes = await imageToByteListInt(imageFile, imageDim);

      // print(bytes.toString());
      var results = await interpreter.run(
          localModelName: "mobilenet_v1_1.0_224_quant",
          inputOutputOptions: FirebaseModelInputOutputOptions(
              [
                FirebaseModelIOOption(FirebaseModelDataType.FLOAT32, inputDims)
              ],
              [
                FirebaseModelIOOption(FirebaseModelDataType.FLOAT32, outputDims)
              ]
          ),
          inputBytes: bytes
      );
      print('results');
      print(results.toString());
      if (results != null && results[0][0].length > 0) {
        for (var i = 0; i < results[0][0].length; i++) {
          if (results[0][0][i] > 0) {
            var confidenceLevel = results[0][0][i] * 100;
            if (confidenceLevel > 0) {
              predictions[modelLabels[i]] = confidenceLevel;
            }
          }
        }
        // showAlertDialog();
        // sort prdictions
        var predictionKeys = predictions.entries.toList();
        //print('predictionKeys  ${predictionKeys.toString()}');
        predictionKeys.sort((b, a) => a.value.compareTo(b.value));
        predictions = Map<String, double>.fromEntries(predictionKeys);
        // print(predictions.toString());
        //
        showPredictionResult();
      } else {
        showMessageAlert("Error",
            'I am not sure I can find a plant image in the provided picture');
      }
    } catch (e) {
      showMessageAlert("Error", e.toString());
    }
  }

  Future<Uint8List> imageToByteListFloat(File file, int _inputSize) async {
    // Uint8List _byte = await Cv2.cvtColor(
    //   // pathFrom: CVPathFrom.ASSETS,
    //   pathString: 'assets/models/smiling.jpg',
    //   outputType: Cv2.COLOR_BGR2GRAY,
    // );
    // print('cv2 ${_byte.toString()}');

    // setState(() {
    //   _byte;
    // });


    var bytes = file.readAsBytesSync();
    var decoder = img.findDecoderForData(bytes);
    img.Image image = decoder.decodeImage(bytes);

    var convertedBytes = Float32List(1 * _inputSize * _inputSize * 1 * 4);
    var buffer = Float32List.view(convertedBytes.buffer);

    int pixelIndex = 0;
    for (var i = 0; i < _inputSize; i++) {
      for (var j = 0; j < _inputSize; j++) {
        var pixel = image.getPixel(i, j);
        // print('red : ${img.getRed(pixel)}');
        // print('green : ${img.getGreen(pixel)}');
        // print('blue : ${img.getBlue(pixel)}');
        buffer[pixelIndex] = ((pixel) & 0xFF) / 255;
        pixelIndex += 1;
        buffer[pixelIndex] = ((pixel) & 0xFF) / 255;
        pixelIndex += 1;
        buffer[pixelIndex] = (pixel & 0xFF) / 255;
        pixelIndex += 1;
      }
    }
    // print(convertedBytes.buffer.toString());
    return convertedBytes.buffer.asUint8List();
  }

  Future<void> showPredictionResult() async {
    List<Widget> predictionWidget = [];
    // sort prdictions
    var predictionKeys = predictions.entries.toList();
    predictionKeys.sort((b, a) => a.value.compareTo(b.value));
    predictions = Map<String, double>.fromEntries(predictionKeys);
    //
    print('output');
    print(predictions.toString());
    predictions.forEach((k, v) {
      predictionWidget.add(
          Text("$k : ${v.toStringAsFixed(2)}%")
      );
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Predictions"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: predictionWidget,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMessageAlert(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Model'),

      ),
      body: SafeArea(
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: (selectedImageFile != null)
                        ? Image.file(
                      selectedImageFile,
                      fit: BoxFit.cover,
                    )
                        : SizedBox()
                ),
                Positioned(
                  left: 50,
                  right: 50,
                  bottom: 20.0,
                  child: RaisedButton(
                      onPressed: _pickPicture,
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 30,
                      ),
                      padding: const EdgeInsets.all(20),
                      color: Colors.red,
                      shape: CircleBorder()
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

