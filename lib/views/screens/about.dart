import 'package:flutter/material.dart';
import 'package:hisnelmoslem/shared/constants/constant.dart';
import 'package:hisnelmoslem/shared/functions/open_url.dart';
import 'package:hisnelmoslem/shared/widgets/scroll_glow_custom.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../themes/theme_services.dart';

class About extends StatelessWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String appIcon, smartIcon;
    if (ThemeServices.isDarkMode()) {
      appIcon = 'assets/images/app_icon.png';
      smartIcon = 'assets/images/smart.png';
    } else {
      appIcon = 'assets/images/app_icon_light.png';
      smartIcon = 'assets/images/smart_light.png';
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "عن التطبيق",
            style: TextStyle(fontFamily: "Uthmanic"),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: ScrollGlowCustom(
          child: ListView(
            children: [
              const SizedBox(height: 15),
              ListTile(
                leading: Image.asset(
                  appIcon,
                  scale: 3,
                ),
                title: const Text("تطبيق أذكار المسلم الإصدار " + appVersion),
                subtitle:
                    const Text("تطبيق مجاني خالي من الإعلانات ومفتوح المصدر"),
              ),
              const Divider(),
              ListTile(
                leading: Image.asset(
                  smartIcon,
                  scale: 4,
                ),
                title: const Text("هذا الاصدار ياتي برعاية SMART Team"),
                subtitle:
                    const Text("الطيب علي & محمد عوض"),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(MdiIcons.handClap),
                title: Text("نسألكم الدعاء لنا ولوالدينا"),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(MdiIcons.bookOpenPageVariant),
                title: const Text("صفحات المصحف من خلال موقع tafsir.app"),
                onTap: () {
                  openURL("https://tafsir.app/");
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text(
                    "تم الاستعانة بنسخة ديجتال من كتاب حصن المسلم من شبكة الألوكة"),
                subtitle: const Text(
                    "للفقير إلى الله تعالى الدكتور سعيد بن علي بن وهف القحطاني"),
                onTap: () {
                  openURL("https://www.alukah.net/library/0/55211/");
                },
              ),
            ],
          ),
        ));
  }
}
