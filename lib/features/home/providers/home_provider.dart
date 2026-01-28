import 'package:flutter/foundation.dart';
import 'package:taffi/core/enums/status_enum.dart';

class HomeProvider extends ChangeNotifier {
  Status status = Status.initial;
  String? errorMessage;
}
