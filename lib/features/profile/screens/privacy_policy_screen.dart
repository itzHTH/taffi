import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/profile/widgets/bullet_point.dart';
import 'package:taffi/features/profile/widgets/content_paragraph.dart';
import 'package:taffi/features/profile/widgets/section_title.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "سياسة الخصوصية",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContentParagraph(
                text:
                    "مرحباً بك في تطبيق تعافي. نحن نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية. توضح سياسة الخصوصية هذه كيفية جمعنا واستخدامنا وحمايتنا للمعلومات عند استخدامك لتطبيقنا.",
              ),
              SizedBox(height: 16),
              SectionTitle(
                title: "1. المعلومات التي نجمعها",
              ),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "نحن نقوم بجمع المعلومات التي تقدمها لنا طواعية عند استخدام التطبيق، وتشمل:",
              ),
              SizedBox(height: 6),
              BulletPoint(
                text:
                    "معلومات الحساب: مثل الاسم، عنوان البريد الإلكتروني، ورقم الهاتف عند إنشاء حساب جديد.",
              ),
              BulletPoint(
                text:
                    "البيانات المدخلة: أي بيانات تقوم بإدخالها أثناء استخدام خدمات التطبيق (مثل المواعيد، أو الملاحظات الشخصية).",
              ),
              BulletPoint(
                text:
                    "بيانات الجهاز: قد نجمع معلومات تقنية حول جهازك، مثل نوع الجهاز ونظام التشغيل، لتحسين تجربة المستخدم.",
              ),
              SizedBox(height: 16),
              SectionTitle(title: "2. كيف نستخدم معلوماتك"),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "نستخدم المعلومات التي نجمعها للأغراض التالية:",
              ),
              SizedBox(height: 6),
              BulletPoint(
                text:
                    "توفير وصيانة الخدمات التي يقدمها التطبيق.",
              ),
              BulletPoint(
                text: "إدارة حسابك وتوثيق هويتك.",
              ),
              BulletPoint(
                text:
                    "تحسين واجهة المستخدم وتجربة الاستخدام (UI/UX).",
              ),
              BulletPoint(
                text:
                    "الرد على استفساراتك وتقديم الدعم الفني.",
              ),
              SizedBox(height: 16),
              SectionTitle(title: "3. مشاركة البيانات"),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "نحن لا نقوم ببيع أو تأجير بياناتك الشخصية لأطراف ثالثة. قد نشارك البيانات فقط في الحالات التالية:",
              ),
              SizedBox(height: 6),
              BulletPoint(
                text:
                    "الامتثال للقوانين أو اللوائح المعمول بها.",
              ),
              BulletPoint(
                text: "حماية حقوق وسلامة مستخدمي التطبيق.",
              ),
              SizedBox(height: 16),
              SectionTitle(title: "4. أمن البيانات"),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "نحن نتخذ إجراءات أمنية معقولة لحماية معلوماتك من الوصول غير المصرح به أو التغيير أو الإفصاح. ومع ذلك، يرجى العلم بأنه لا توجد وسيلة نقل عبر الإنترنت أو طريقة تخزين إلكتروني آمنة بنسبة 100%.",
              ),
              SizedBox(height: 16),
              SectionTitle(
                title: "5. التغييرات على سياسة الخصوصية",
              ),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. سيتم إشعارك بأي تغييرات جوهرية عبر التطبيق أو البريد الإلكتروني.",
              ),
              SizedBox(height: 16),
              SectionTitle(title: "6. اتصل بنا"),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "إذا كان لديك أي أسئلة حول سياسة الخصوصية هذه، يرجى الاتصال بنا عبر:",
              ),
              SizedBox(height: 6),
              BulletPoint(
                text:
                    "البريد الإلكتروني:  support@taffi.app",
              ),

              SizedBox(height: 32),

              Center(
                child: Text(
                  "آخر تحديث: يناير 2026",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
