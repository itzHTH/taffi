import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/notifications/widgets/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  late List<Map<String, dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = [
      {
        'title': 'موعد جديد مع الدكتور أحمد',
        'message':
            'تم تأكيد موعدك مع الدكتور أحمد يوم الأحد 22 يناير 2026 في تمام الساعة 10:00 صباحاً. يرجى الحضور قبل الموعد بـ 15 دقيقة.',
        'time': 'منذ ساعة',
        'isRead': false,
      },
      {
        'title': 'تذكير بالموعد',
        'message':
            'موعدك مع الدكتور سارة غداً في تمام الساعة 3:00 مساءً. لا تنسى إحضار التحاليل الطبية.',
        'time': 'منذ 3 ساعات',
        'isRead': false,
      },
      {
        'title': 'نتائج الفحوصات جاهزة',
        'message':
            'أصبحت نتائج فحوصاتك الطبية جاهزة الآن. يمكنك الاطلاع عليها من خلال التطبيق أو استلامها من العيادة.',
        'time': 'منذ يوم',
        'isRead': true,
      },
      {
        'title': 'تم إلغاء الموعد',
        'message':
            'نأسف لإبلاغك بأن موعدك مع الدكتور محمد تم إلغاؤه. يرجى إعادة جدولة موعد جديد في أقرب وقت ممكن.',
        'time': 'منذ يومين',
        'isRead': true,
      },
      {
        'title': 'عرض خاص لك',
        'message':
            'احصل على خصم 20% على جميع الفحوصات الطبية الشاملة لفترة محدودة. اغتنم الفرصة الآن!',
        'time': 'منذ 3 أيام',
        'isRead': true,
      },
    ];
  }

  void _markAsRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "الإشعارات",
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
          notifications.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 80,
                          color: AppColors.textHint,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد إشعارات',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color:
                                    AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 16,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((
                      context,
                      index,
                    ) {
                      final notification =
                          notifications[index];
                      return NotificationItem(
                        title:
                            notification['title'] as String,
                        message:
                            notification['message']
                                as String,
                        time:
                            notification['time'] as String,
                        isRead:
                            notification['isRead'] as bool,
                        onRead: () => _markAsRead(index),
                      );
                    }, childCount: notifications.length),
                  ),
                ),
        ],
      ),
    );
  }
}
