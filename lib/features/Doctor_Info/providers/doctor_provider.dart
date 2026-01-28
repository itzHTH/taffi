import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/remote/api_response.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';

import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/utils/helpers.dart';
import 'package:taffi/features/Doctor_Info/models/doctor_model.dart';
import 'package:taffi/features/Doctor_Info/models/schedule_day_model.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorModel> doctors = [];
  List<DoctorModel> topDoctors = [];
  DoctorModel? doctor;

  DateTime? selectedDate;
  int? selectedScheduleIndex;
  List<String> timeSlots = [];

  Status doctorsStatus = Status.initial;
  Status topDoctorsStatus = Status.initial;
  Status doctorStatus = Status.initial;

  String? errorMessage;

  Future<void> getAllDoctors() async {
    try {
      doctorsStatus = Status.loading;
      notifyListeners();

      final doctorsResponse = await ApiService.instance.get(EndPoints.doctors.base);

      final doctorsData = ApiResponse<List<DoctorModel>>.fromJson(
        doctorsResponse,
        (json) => (json as List).map((e) => DoctorModel.fromJson(e)).toList(),
      );

      if (doctorsData.success) {
        doctors = doctorsData.data!;
        doctorsStatus = Status.success;
        notifyListeners();
      } else {
        doctorsStatus = Status.error;
        errorMessage = doctorsData.message;
        notifyListeners();
      }
    } on ServerException catch (e) {
      doctorsStatus = Status.error;
      errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      doctorsStatus = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> getTopDoctors() async {
    try {
      topDoctorsStatus = Status.loading;
      notifyListeners();

      final topDoctorsResponse = await ApiService.instance.get(EndPoints.doctors.base);

      final topDoctorsData = ApiResponse<List<DoctorModel>>.fromJson(
        topDoctorsResponse,
        (json) => (json as List).map((e) => DoctorModel.fromJson(e)).toList(),
      );

      if (topDoctorsData.success) {
        topDoctors = topDoctorsData.data!.where((element) => element.rate! > 4.5).toList();
        topDoctorsStatus = Status.success;
        notifyListeners();
      } else {
        topDoctorsStatus = Status.error;
        errorMessage = topDoctorsData.message;
        notifyListeners();
      }
    } on ServerException catch (e) {
      topDoctorsStatus = Status.error;
      errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      topDoctorsStatus = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> getDoctorById(String id) async {
    try {
      doctorStatus = Status.loading;
      notifyListeners();

      final doctorResponse = await ApiService.instance.get(EndPoints.doctors.byId(id));

      final doctorData = ApiResponse<DoctorModel>.fromJson(
        doctorResponse,
        (json) => DoctorModel.fromJson(json as Map<String, dynamic>),
      );

      if (doctorData.success) {
        doctor = doctorData.data!;
        doctorStatus = Status.success;
        notifyListeners();
      } else {
        doctorStatus = Status.error;
        errorMessage = doctorData.message;
        notifyListeners();
      }
    } on ServerException catch (e) {
      doctorStatus = Status.error;
      errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      doctorStatus = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void setDoctor(DoctorModel doctor) {
    this.doctor = doctor;
    notifyListeners();
  }

  Future<void> getDoctorSchedule(String id) async {
    try {
      doctorStatus = Status.loading;
      notifyListeners();

      final doctorResponse = await ApiService.instance.get(EndPoints.doctors.schedule(id));

      final doctorScheduleData = ApiResponse<List<ScheduleDayModel>>.fromJson(
        doctorResponse,
        (json) => (json as List).map((e) => ScheduleDayModel.fromJson(e)).toList(),
      );

      if (doctorScheduleData.success) {
        doctor?.scheduleDays = doctorScheduleData.data!;
        doctorStatus = Status.success;
        notifyListeners();
      } else {
        doctorStatus = Status.error;
        errorMessage = doctorScheduleData.message;
        notifyListeners();
      }
    } on ServerException catch (e) {
      doctorStatus = Status.error;
      errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      doctorStatus = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    selectedScheduleIndex = null;

    try {
      if (doctor?.scheduleDays != null) {
        final scheduleDay = doctor!.scheduleDays!.firstWhere(
          (day) => Helpers.getDayOfWeekIndex(day.dayOfWeek!) == date.weekday,
        );
        timeSlots = Helpers.generateTimesSlots(scheduleDay.startTime!, scheduleDay.endTime!);
      }
    } catch (e) {
      timeSlots = [];
    }
    notifyListeners();
  }

  void setSelectedScheduleIndex(int index) {
    selectedScheduleIndex = index;
    notifyListeners();
  }

  void reset() {
    selectedDate = null;
    selectedScheduleIndex = null;
    timeSlots = [];
    doctor = null;
  }
}
