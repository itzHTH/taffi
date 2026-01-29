import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/remote/api_response.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/features/notifications/models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> notifications = [];
  Status status = Status.initial;
  String? message;

  Future<void> getAllNotifications() async {
    try {
      status = Status.loading;
      notifyListeners();

      final response = await ApiService.instance.get(EndPoints.notifications.getAll);
      final apiResponse = ApiResponse<List<NotificationModel>>.fromJson(
        response,
        (json) => (json as List).map((e) => NotificationModel.fromJson(e)).toList(),
      );
      if (apiResponse.success) {
        notifications = apiResponse.data!;
        status = Status.success;
        notifyListeners();
      } else {
        status = Status.error;
        message = apiResponse.message;
        notifyListeners();
      }
    } on ServerException catch (e) {
      status = Status.error;
      message = e.message;
      notifyListeners();
    } catch (e) {
      status = Status.error;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<bool> markAsRead(String id) async {
    try {
      // Find the notification
      final index = notifications.indexWhere((n) => n.id == id);
      if (index == -1) return false;

      // Store original state
      final originalNotification = notifications[index];
      final wasRead = originalNotification.isRead ?? false;

      // Optimistic update - update UI immediately
      notifications[index] = originalNotification.copyWith(isRead: true);
      notifyListeners();

      // Make API call
      final response = await ApiService.instance.put(EndPoints.notifications.markRead(id));
      final apiResponse = ApiResponse<bool>.fromJson(response, (json) => json as bool);

      if (apiResponse.success) {
        // Success - keep the optimistic update
        return true;
      } else {
        // Failed - revert the optimistic update
        notifications[index] = originalNotification.copyWith(isRead: wasRead);
        message = apiResponse.message;
        notifyListeners();
        return false;
      }
    } on ServerException catch (e) {
      // Revert on error
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index] = notifications[index].copyWith(isRead: false);
        notifyListeners();
      }
      message = e.message;
      return false;
    } catch (e) {
      // Revert on error
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index] = notifications[index].copyWith(isRead: false);
        notifyListeners();
      }
      message = e.toString();
      return false;
    }
  }
}
