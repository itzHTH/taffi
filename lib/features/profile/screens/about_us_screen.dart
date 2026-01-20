import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/profile/widgets/bullet_point.dart';
import 'package:taffi/features/profile/widgets/content_paragraph.dart';
import 'package:taffi/features/profile/widgets/section_title.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
          "من نحن",
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
                    "مرحباً بك في تطبيق تعافي - رفيقك الموثوق في رحلتك الصحية. نحن منصة طبية متكاملة تهدف إلى تسهيل الوصول إلى الرعاية الصحية عبر تقديم خدمات طبية متنوعة بأعلى معايير الجودة والاحترافية.",
              ),

              SizedBox(height: 16),

              SectionTitle(title: "1. رؤيتنا"),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "نسعى لأن نكون المنصة الرائدة في مجال الرعاية الصحية الرقمية في العراق والمنطقة، من خلال تقديم خدمات طبية متميزة وسهلة الوصول للجميع.",
              ),

              SizedBox(height: 16),

              SectionTitle(title: "2. مهمتنا"),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "نعمل على توفير تجربة طبية متكاملة تربط المرضى بأفضل الأطباء والمراكز الصحية، مع ضمان جودة الخدمة والراحة والخصوصية التامة.",
              ),

              SizedBox(height: 16),

              SectionTitle(title: "3. خدماتنا"),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "نقدم مجموعة واسعة من الخدمات الطبية التي تشمل:",
              ),
              SizedBox(height: 6),
              BulletPoint(
                text: "حجز المواعيد الطبية بسهولة وسرعة",
              ),
              BulletPoint(
                text:
                    "التواصل المباشر مع الأطباء المتخصصين",
              ),
              BulletPoint(
                text: "إدارة السجلات والملفات الطبية",
              ),
              BulletPoint(
                text: "متابعة المواعيد والعلاجات",
              ),
              BulletPoint(
                text: "البحث عن أفضل الأطباء والتخصصات",
              ),

              SizedBox(height: 16),

              SectionTitle(title: "4. قيمنا"),
              SizedBox(height: 6),
              BulletPoint(
                text:
                    "الجودة: نلتزم بتقديم أعلى معايير الجودة في كل خدماتنا",
              ),
              BulletPoint(
                text:
                    "الخصوصية: نحترم خصوصية بياناتك ونحميها بكل السبل",
              ),
              BulletPoint(
                text:
                    "الاحترافية: فريقنا من المتخصصين المؤهلين لخدمتك",
              ),
              BulletPoint(
                text:
                    "الابتكار: نستخدم أحدث التقنيات لتحسين خدماتنا",
              ),
              BulletPoint(
                text:
                    "الشفافية: نعمل بوضوح ومصداقية مع جميع مستخدمينا",
              ),

              SizedBox(height: 16),

              SectionTitle(title: "5. فريقنا"),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "يضم فريق تعافي نخبة من المطورين والمتخصصين في مجال الرعاية الصحية الرقمية، الذين يعملون بشغف لتوفير أفضل تجربة ممكنة للمستخدمين.",
              ),

              SizedBox(height: 16),

              SectionTitle(title: "6. تواصل معنا"),
              SizedBox(height: 6),
              ContentParagraph(
                text:
                    "نحن هنا لخدمتك، لا تتردد في التواصل معنا:",
              ),
              SizedBox(height: 6),
              BulletPoint(
                text:
                    "البريد الإلكتروني:  support@taffi.app",
              ),

              SizedBox(height: 32),

              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "نحن معك في رحلتك نحو صحة أفضل",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
