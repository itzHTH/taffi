import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/notifications/providers/notification_provider.dart';
import 'package:taffi/features/notifications/widgets/notification_item.dart';
import 'package:taffi/features/notifications/widgets/notification_shimmer.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchNotifications();
    });
  }

  Future<void> _fetchNotifications() async {
    await context.read<NotificationProvider>().getAllNotifications();
  }

  Future<void> _markAsRead(String id) async {
    final success = await context.read<NotificationProvider>().markAsRead(id);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('تم وضع علامة مقروء بنجاح'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    } else {
      final errorMessage = context.read<NotificationProvider>().message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? 'فشل في وضع علامة مقروء'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("الإشعارات", style: Theme.of(context).textTheme.titleLarge),
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.primary,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            floating: true,
            snap: true,
          ),

          if (provider.status == Status.loading)
            SliverPadding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const NotificationShimmer(),
                  childCount: 5,
                ),
              ),
            )
          // Error state
          else if (provider.status == Status.error)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      'حدث خطأ',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        provider.message ?? 'فشل في تحميل الإشعارات',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _fetchNotifications,
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            )
          // Empty state
          else if (provider.notifications.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_none, size: 80, color: AppColors.textHint),
                    const SizedBox(height: 16),
                    Text(
                      'لا توجد إشعارات',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            )
          // Success state with notifications
          else
            SliverPadding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final notification = provider.notifications[index];
                  return NotificationItem(
                    title: notification.title ?? "عنوان الإشعار",
                    message: notification.message ?? "رسالة الإشعار",
                    time: notification.createdAt?.toLocal().toString() ?? "وقت الإشعار",
                    isRead: notification.isRead ?? false,
                    onRead: () async => await _markAsRead(notification.id ?? ""),
                  );
                }, childCount: provider.notifications.length),
              ),
            ),
        ],
      ),
    );
  }
}
