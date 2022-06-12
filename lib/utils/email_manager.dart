import 'package:flutter/foundation.dart';
import 'package:hisnelmoslem/models/fake_haith.dart';
import 'package:hisnelmoslem/models/zikr_content.dart';
import 'package:hisnelmoslem/models/zikr_title.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailManager {
  static const String emailOwner = "Elteyab@smart.sd";

  static void sendFeedback() {
    sendEmail(
      toMailId: emailOwner,
      subject: 'تطبيق أذكار المسلم: تقييم التطبيق',
      body: '''
كم من عشرة تعطي هذا التطبيق؟

ملاحظات:

ما أعجبك في التطبيق:

ما لا يعجبك في التطبيق:

شئ تتمنى وجوده:

''',
    );
  }

  static void messageUS() {
    sendEmail(
      toMailId: emailOwner,
      subject: 'تطبيق أذكار المسلم: نداء',
      body: 'السلام عليكم ورحمة الله وبركاته' '\n',
    );
  }

  static void sendMisspelledInZikrWithDbModel({
    required DbTitle dbTitle,
    required DbContent dbContent,
  }) {
    sendMisspelledInZikr(
      subject: dbTitle.name,
      cardNumber: dbContent.orderId.toString(),
      text: dbContent.content,
    );
  }

  static void sendMisspelledInZikrWithText({
    required String subject,
    required String cardNumber,
    required String text,
  }) {
    sendMisspelledInZikr(
      cardNumber: cardNumber,
      subject: subject,
      text: text,
    );
  }

  static void sendMisspelledInZikr({
    required String subject,
    required String cardNumber,
    required String text,
  }) {
    sendEmail(
      toMailId: emailOwner,
      subject: 'تطبيق أذكار المسلم: خطأ إملائي ',
      body: ' السلام عليكم ورحمة الله وبركاته يوجد خطأ إملائي في'
              '\n'
              'الموضوع: ' +
          subject +
          '\n' +
          'الذكر رقم: ' +
          cardNumber +
          '\n' +
          'النص: ' +
          text +
          '\n' +
          'والصواب:' +
          '\n',
    );
  }

  static void sendMisspelledInFakeHadith({
    required DbFakeHaith fakeHaith,
  }) {
    sendEmail(
      toMailId: emailOwner,
      subject: 'تطبيق أذكار المسلم: خطأ إملائي ',
      body: '''
السلام عليكم ورحمة الله وبركاته يوجد خطأ إملائي في

الموضوع: أحاديث لا تصح

البطاقة رقم: ${(fakeHaith.id) + 1}

النص: ${fakeHaith.text}

والصواب:

''',
    );
  }

  static void sendEmail({
    required String toMailId,
    required String subject,
    required String body,
  }) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
