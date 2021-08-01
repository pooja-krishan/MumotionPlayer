import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:typed_data';

class TFLITEPredictions{
  File selectedImageFile;

  FirebaseModelInterpreter interpreter = FirebaseModelInterpreter.instance;
  FirebaseModelManager manager = FirebaseModelManager.instance;
  List<String> modelLabels = [];
  Map<String, double> predictions = Map<String, double>();
  int imageDim = 64;
  List<int> inputDims = [1, 64, 64, 1]; //35887, 3  //1, 256, 256, 3
  List<int> outputDims = [1, 7]; //1, 15

  //  pickPicture() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   if (image != null) {
  //     print('image loaded');
  //     // print(image.path);
  //     predict(image);
  //   }
  // }

  loadTFliteModel() async {
    try {
      manager.registerLocalModelSource(
          FirebaseLocalModelSource(
              assetFilePath: "assets/models/bigxceptionmodel.tflite",
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

   predict() async {
     var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      print('image loaded');
      try {
        //
        predictions = Map<String, double>();
        //
        var bytes = await imageToByteListFloat(imageFile, imageDim);
        print('before interpreter run');
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
        print('after interpreter run');

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
          var predictionKeys = predictions.entries.toList();
          //print('predictionKeys  ${predictionKeys.toString()}');
          predictionKeys.sort((b, a) => a.value.compareTo(b.value));
          predictions = Map<String, double>.fromEntries(predictionKeys);
          print(predictions.toString());
          predictions.forEach((k, v) {
            print('${k} : ${v}');
          });
          return predictions;

        } else {
          print('I am not sure I can find a plant image in the provided picture');

        }
      } catch (e) {
        print(e.toString());
      }
    }

  }

  Future<Uint8List> imageToByteListFloat(File file, int _inputSize) async {

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
        buffer[pixelIndex] = ((pixel >> 16) & 0xFF) / 255;
        pixelIndex += 1;
        buffer[pixelIndex] = ((pixel >> 8) & 0xFF) / 255;
        pixelIndex += 1;
        buffer[pixelIndex] = ((pixel) & 0xFF) / 255;
        pixelIndex += 1;
      }
    }
    // print(convertedBytes.buffer.toString());
    return convertedBytes.buffer.asUint8List();
  }
}
