import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/remote/api_response.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/features/specialties/models/specialty_model.dart';

class SpecialtyProvider extends ChangeNotifier {
  List<SpecialtyModel> specialties = [];
  Status specialtiesStatus = Status.initial;
  SpecialtyModel? selectedSpecialty;
  Status selectedSpecialtyStatus = Status.initial;
  String? errorMessage;

  Future<void> getSpecialties() async {
    try {
      specialtiesStatus = Status.loading;
      notifyListeners();
      final apiResponse = await ApiService.instance.get(EndPoints.specialties.getAll);

      final response = ApiResponse<List<SpecialtyModel>>.fromJson(
        apiResponse,
        (json) => (json as List).map((item) => SpecialtyModel.fromJson(item)).toList(),
      );

      if (response.success) {
        specialties = response.data!;
        specialtiesStatus = Status.success;
        notifyListeners();
      } else {
        specialtiesStatus = Status.error;
        errorMessage = response.message;
        notifyListeners();
      }
    } on ServerException catch (e) {
      specialtiesStatus = Status.error;
      errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      specialtiesStatus = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void setSelectedSpecialty(SpecialtyModel specialty) {
    selectedSpecialty = specialty;
    notifyListeners();
  }
}
