import 'package:flutter/material.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/remote/api_response.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/features/appointments/models/appointment_model.dart';

class AppointmentProvider extends ChangeNotifier {
  List<AppointmentModel> appointmentsResponse = [];
  Status status = Status.initial;
  Status bookStatus = Status.initial;
  String? errorMessage;

  Future<void> getAppointments() async {
    try {
      status = Status.loading;
      notifyListeners();
      final response = await ApiService.instance.get(EndPoints.appointments.myAppointments);
      ApiResponse<List<AppointmentModel>> apiResponse =
          ApiResponse<List<AppointmentModel>>.fromJson(
            response,
            (json) => (json as List<dynamic>).map((e) => AppointmentModel.fromJson(e)).toList(),
          );

      if (apiResponse.success) {
        appointmentsResponse = apiResponse.data!;
        status = Status.success;
        notifyListeners();
      } else {
        status = Status.error;
        errorMessage = apiResponse.message;
        notifyListeners();
      }
    } on ServerException catch (e) {
      status = Status.error;
      errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      status = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    try {
      status = Status.loading;
      notifyListeners();
      final response = await ApiService.instance.put(EndPoints.appointments.cancel(appointmentId));
      ApiResponse<bool> apiResponse = ApiResponse<bool>.fromJson(response, (json) => json as bool);

      if (apiResponse.success) {
        status = Status.success;
        notifyListeners();
      } else {
        status = Status.error;
        errorMessage = apiResponse.message;
        notifyListeners();
      }
    } on ServerException catch (e) {
      status = Status.error;
      errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      status = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> bookAppointment({
    required String doctorId,
    required String appointmentDate,
    required String appointmentTime,
    required String patientNotes,
  }) async {
    try {
      bookStatus = Status.loading;
      notifyListeners();
      final response = await ApiService.instance.post(
        EndPoints.appointments.create,
        data: {
          'doctorId': doctorId,
          'appointmentDate': appointmentDate,
          'appointmentTime': appointmentTime,
          'patientNotes': patientNotes,
        },
      );
      ApiResponse apiResponse = ApiResponse.fromJson(response, (json) => json);

      if (apiResponse.success) {
        bookStatus = Status.success;
        notifyListeners();
      } else {
        bookStatus = Status.error;
        errorMessage = apiResponse.message;
        notifyListeners();
      }
    } on ServerException catch (e) {
      bookStatus = Status.error;
      errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      bookStatus = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
