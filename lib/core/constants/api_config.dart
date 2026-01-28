class ApiConfig {
  ApiConfig._();

  static const String baseUrl = "https://taafi.ddns.net/taafi";

  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 20);
}

class EndPoints {
  static const AuthEndPoints auth = AuthEndPoints();
  static const DoctorsEndPoints doctors = DoctorsEndPoints();
  static const AppointmentsEndPoints appointments = AppointmentsEndPoints();
  static const ChatEndPoints chat = ChatEndPoints();
  static const NotificationsEndPoints notifications = NotificationsEndPoints();
  static const SpecialtiesEndPoints specialties = SpecialtiesEndPoints();
}

// 1. Auth Group
class AuthEndPoints {
  const AuthEndPoints();
  final String register = '/Auth/register';
  final String login = '/Auth/login';
  final String refreshToken = '/Auth/refresh-token';
  final String googleLogin = '/Auth/google-login';
  final String updateProfile = '/Auth/update-profile';
  final String profile = '/Auth/profile';
}

// 2. Doctors Group
class DoctorsEndPoints {
  const DoctorsEndPoints();
  final String base = '/Doctor';
  String byId(String id) => '/Doctor/$id';
  String search({String? query, String? specialtyId}) =>
      '/Doctor?search=$query&specialtyId=$specialtyId';
  String schedule(String id) => '/Doctor/$id/schedule';
  String bySpecialty(String specialtyId) => '/Speciality/doctors/$specialtyId';
}

// 3. Appointments Group
class AppointmentsEndPoints {
  const AppointmentsEndPoints();
  final String myAppointments = '/Appointments/my-appointments';
  final String create = '/Appointments';
  String byId(String id) => '/Appointments/$id';
  String cancel(String id) => '/Appointments/$id/cancel';
}

// 4. Chat Group
class ChatEndPoints {
  const ChatEndPoints();
  final String sendMessage = '/Chat';
  String getMessages(String doctorId) => '/Chat/$doctorId';
}

// 5. Notifications Group
class NotificationsEndPoints {
  const NotificationsEndPoints();
  final String getAll = '/Notifications';
  String markRead(String id) => '/Notifications/$id/read';
}

// 6. Specialties Group
class SpecialtiesEndPoints {
  const SpecialtiesEndPoints();
  final String getAll = '/Speciality/specialties';
}
