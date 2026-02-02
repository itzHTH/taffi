import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

enum ConfirmationDialogType { booking, cancel, logout }

class ConfirmationDialog extends StatelessWidget {
  final ConfirmationDialogType type;
  final String? doctorName;
  final String? appointmentDate;
  final String? appointmentTime;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    super.key,
    required this.type,
    this.doctorName,
    this.appointmentDate,
    this.appointmentTime,
    this.onConfirm,
    this.onCancel,
  });

  bool get isBooking => type == ConfirmationDialogType.booking;
  bool get isLogout => type == ConfirmationDialogType.logout;

  IconData get _icon => isBooking
      ? Icons.event_available_rounded
      : isLogout
      ? Icons.logout_rounded
      : Icons.event_busy_rounded;

  Color get _iconColor => isBooking
      ? AppColors.secondary
      : isLogout
      ? AppColors.warning
      : AppColors.error;

  String get _title => isBooking
      ? 'تأكيد الحجز'
      : isLogout
      ? 'تسجيل الخروج'
      : 'إلغاء الموعد';

  String get _questionText => isBooking
      ? 'هل تريد تأكيد الحجز مع '
      : isLogout
      ? 'هل أنت متأكد من تسجيل الخروج؟'
      : 'هل أنت متأكد من إلغاء الموعد مع ';

  String get _infoMessage => isBooking
      ? 'سيتم إرسال تأكيد الحجز إلى بريدك الإلكتروني'
      : isLogout
      ? 'سيتم تسجيل خروجك من التطبيق وستحتاج إلى تسجيل الدخول مرة أخرى'
      : 'لن تتمكن من التراجع عن هذا الإجراء';

  Color get _infoColor => isBooking
      ? AppColors.primary
      : isLogout
      ? AppColors.warning
      : AppColors.primary;

  String get _confirmButtonText => isBooking
      ? 'تأكيد الحجز'
      : isLogout
      ? 'تسجيل الخروج'
      : 'تأكيد الإلغاء';

  Color get _confirmButtonColor => isBooking
      ? AppColors.secondary
      : isLogout
      ? AppColors.warning
      : AppColors.error;

  IconData get _confirmButtonIcon => isBooking
      ? Icons.check_circle_rounded
      : isLogout
      ? Icons.logout_rounded
      : Icons.close_rounded;

  List<Color> get _headerGradient => isBooking
      ? [AppColors.primary.withValues(alpha: 0.1), AppColors.secondary.withValues(alpha: 0.1)]
      : isLogout
      ? [AppColors.warning.withValues(alpha: 0.1), AppColors.warning.withValues(alpha: 0.15)]
      : [AppColors.error.withValues(alpha: 0.1), AppColors.warning.withValues(alpha: 0.1)];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 8,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.background,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: _headerGradient,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _iconColor.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(_icon, color: _iconColor, size: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question text
                  if (isLogout)
                    Text(
                      _questionText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: AppColors.textPrimary,
                      ),
                    )
                  else
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(text: _questionText),
                          TextSpan(
                            text: ' $doctorName',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                          const TextSpan(text: '؟'),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Appointment details card (only for booking/cancel)
                  if (!isLogout) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.05),
                            AppColors.secondary.withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Date
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'التاريخ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      appointmentDate ?? '',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(height: 1, color: AppColors.divider.withValues(alpha: 0.3)),
                          const SizedBox(height: 12),
                          // Time
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.access_time_rounded,
                                  size: 20,
                                  color: AppColors.secondary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'الوقت',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      appointmentTime ?? '',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Info message
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _infoColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _infoColor.withValues(alpha: 0.3), width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline_rounded, color: _infoColor, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _infoMessage,
                            style: TextStyle(fontSize: 13, color: _infoColor, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel ?? () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.border, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'رجوع',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _confirmButtonColor,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: _confirmButtonColor.withValues(alpha: 0.4),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_confirmButtonIcon, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            _confirmButtonText,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool?> show({
    required BuildContext context,
    required ConfirmationDialogType type,
    required String doctorName,
    required String appointmentDate,
    required String appointmentTime,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationDialog(
        type: type,
        doctorName: doctorName,
        appointmentDate: appointmentDate,
        appointmentTime: appointmentTime,
      ),
    );
  }
}
