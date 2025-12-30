/// Validation utilities
class Validators {
  Validators._();

  /// Validates email format
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }

    return null;
  }

  /// Validates password
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'يجب أن تحتوي على حرف كبير، صغير، رقم، ورمز خاص (!@#)';
    }

    return null;
  }

  /// Validates password
  static String? confrimPassword(String? currentValue, String? originValue) {
    if (currentValue == null || currentValue.isEmpty) {
      return 'تاكيد كلمة المرور مطلوب';
    }

    if (currentValue != originValue) {
      return '! كلمة المرور غير متطابقه';
    }

    return null;
  }

  /// Validates required field
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'هذا الحقل'} مطلوب';
    }
    return null;
  }

  /// Validates phone number
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }

    final phoneRegex = RegExp(r'^[0-9]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'يرجى إدخال رقم هاتف صحيح';
    }

    return null;
  }
}
