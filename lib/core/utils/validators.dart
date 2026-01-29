/// Validation utilities
class Validators {
  Validators._();

  /// Validates email format
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

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

    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
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

    final phoneRegex = RegExp(r'^[0-9]{11}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'يجب إدخال رقم هاتف مكون من 11 رقم';
    }

    return null;
  }

  /// Validates phone number
  static String? age(String? value) {
    if (value == null || value.isEmpty) {
      return ' العمر مطلوب';
    }

    final ageRegex = RegExp(r'^[1-9][0-9]{0,1}$');
    if (!ageRegex.hasMatch(value)) {
      return 'يرجى إدخال عمر صحيح';
    }

    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'الاسم الكامل مطلوب';
    }

    String trimmedValue = value.trim();

    // Split by spaces and filter out empty strings
    List<String> words = trimmedValue.split(RegExp(r'\s+'));

    // Check if there are at least 3 words
    if (words.length < 3) {
      return 'يجب كتابة الاسم الثلاثي كاملاً (الاسم، اسم الأب، اسم الجد)';
    }

    // Check that each word contains at least 2 characters
    for (var word in words) {
      if (word.length < 2) {
        return 'كل جزء من الاسم يجب أن يحتوي على حرفين على الأقل';
      }
    }

    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'اسم المستخدم مطلوب';
    }

    if (value.length < 4) {
      return 'قصير جداً (4 أحرف على الأقل)';
    }
    if (value.length > 20) {
      return 'طويل جداً (20 حرف كحد أقصى)';
    }

    final RegExp usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$');

    if (!usernameRegex.hasMatch(value)) {
      if (value.contains(' ')) {
        return 'لا يسمح باستخدام المسافات';
      }
      if (RegExp(r'^[^a-zA-Z]').hasMatch(value)) {
        return 'يجب أن يبدأ بحرف إنجليزي';
      }
      return 'يجب استخدام أحرف إنجليزية وأرقام و (_) فقط';
    }

    return null;
  }
}
