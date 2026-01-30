import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/remote/api_response.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/features/chat/models/message_model.dart';
import 'package:taffi/features/Doctor_Info/models/doctor_model.dart';

class ChatProvider extends ChangeNotifier {
  String? errorMessage;
  Status getChatStatus = Status.initial;
  Status sendMessageStatus = Status.initial;
  DoctorModel? selectedDoctor;
  List<MessageModel> messages = [];

  Future<void> getChatMessages() async {
    getChatStatus = Status.loading;
    notifyListeners();
    try {
      final response = await ApiService.instance.get(
        EndPoints.chat.getMessages(selectedDoctor!.id!),
      );
      final ApiResponse<List<MessageModel>> apiResponse = ApiResponse.fromJson(
        response,
        (json) => (json as List<dynamic>).map((e) => MessageModel.fromJson(e)).toList(),
      );

      if (apiResponse.success) {
        messages = apiResponse.data!;
        getChatStatus = Status.success;
        notifyListeners();
      } else {
        errorMessage = apiResponse.message;
        getChatStatus = Status.error;
        notifyListeners();
      }
    } on ServerException catch (e) {
      errorMessage = e.message;
      getChatStatus = Status.error;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      getChatStatus = Status.error;
      notifyListeners();
    }
  }

  void setDoctor(DoctorModel doctor) {
    selectedDoctor = doctor;
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    if (selectedDoctor == null) {
      errorMessage = "Please select a doctor";
      sendMessageStatus = Status.error;
      notifyListeners();
      return;
    }

    messages.add(
      MessageModel(
        content: message,
        isUserMessage: true,
        timestamp: DateTime.now().toUtc().toIso8601String(),
      ),
    );
    sendMessageStatus = Status.loading;
    notifyListeners();

    try {
      final response = await ApiService.instance.post(
        EndPoints.chat.sendMessage,
        data: {"content": message, "doctorId": selectedDoctor!.id},
      );
      final ApiResponse<MessageModel> apiResponse = ApiResponse.fromJson(
        response,
        (json) => MessageModel.fromJson(json as Map<String, dynamic>),
      );

      if (apiResponse.success) {
        messages.add(apiResponse.data!);
        sendMessageStatus = Status.success;
        notifyListeners();
      } else {
        errorMessage = apiResponse.message;
        sendMessageStatus = Status.error;
        notifyListeners();
      }
    } on ServerException catch (e) {
      errorMessage = e.message;
      sendMessageStatus = Status.error;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      sendMessageStatus = Status.error;
      notifyListeners();
    }
  }
}
