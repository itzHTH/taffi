class AppointmentModel {
  String? id;
  String? patientId;
  String? doctorId;
  String? appointmentDate;
  String? appointmentTime;
  String? status;
  bool? isActive;
  String? doctorName;
  String? doctorImage;
  String? specialtyName;

  AppointmentModel({
    this.id,
    this.patientId,
    this.doctorId,
    this.appointmentDate,
    this.appointmentTime,
    this.status,
    this.isActive,
    this.doctorName,
    this.doctorImage,
    this.specialtyName,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    doctorId = json['doctorId'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    status = json['status'];
    isActive = json['isActive'];
    doctorName = json['doctorName'];
    doctorImage = "https://taafi.ddns.net/${json['doctorImage']}";
    specialtyName = json['specialtyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['patientId'] = patientId;
    data['doctorId'] = doctorId;
    data['appointmentDate'] = appointmentDate;
    data['appointmentTime'] = appointmentTime;
    data['status'] = status;
    data['isActive'] = isActive;
    data['doctorName'] = doctorName;
    data['doctorImage'] = doctorImage;
    data['specialtyName'] = specialtyName;
    return data;
  }

  String get formattedDate {
    if (appointmentDate == null || appointmentDate!.isEmpty) {
      return '';
    }

    try {
      final dateTime = DateTime.parse(appointmentDate!);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    } catch (e) {
      // If parsing fails, check if it's already in the correct format
      if (appointmentDate!.contains('T') || appointmentDate!.contains(' ')) {
        final datePart = appointmentDate!.split(RegExp(r'[T\s]')).first;
        // Try to parse and re-format with padding
        try {
          final dt = DateTime.parse(datePart);
          return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
        } catch (_) {
          return datePart;
        }
      }
      // Return as is if it's already a simple date
      return appointmentDate!;
    }
  }

  String get formattedTime {
    if (appointmentTime == null || appointmentTime!.isEmpty) {
      return '';
    }

    try {
      if (appointmentTime!.contains(':') &&
          !appointmentTime!.contains('T') &&
          !appointmentTime!.contains(' ')) {
        final parts = appointmentTime!.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]).toString().padLeft(2, '0');

          // Convert to 12-hour format with AM/PM in Arabic
          final period = hour >= 12 ? 'مساءً' : 'صباحاً';
          if (hour == 0) {
            hour = 12;
          } else if (hour > 12) {
            hour = hour - 12;
          }

          return '${hour.toString().padLeft(2, '0')}:$minute $period';
        }
      }
    } catch (e) {
      return appointmentTime!;
    }

    return appointmentTime!;
  }
}
