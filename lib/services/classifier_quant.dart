import 'package:apptest/services/classifier.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

class ClassifierQuant extends Classifier {
  ClassifierQuant({int numThreads= 1}) : super(numThreads: numThreads);

  @override
  String get modelName => 'model.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
}
