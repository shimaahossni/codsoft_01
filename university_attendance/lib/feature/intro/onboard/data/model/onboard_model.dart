// feature/intro/onboard/data/model/onboard_model.dart
class OnboardingModel {
  final String image;
  final String title;
  final String body;
  OnboardingModel(
      {required this.image, required this.title, required this.body});
}

List<OnboardingModel> pages = [
  OnboardingModel(
      image: 'assets/onboard/1.png',
      title: 'فوايد التطبيق',
      body:
          'مرحبًا في تطبيق الحضور الجامعي! تابع حضورك بسهولة ويسر.ابقَ منظمًا ولا تفوت أي محاضرة!'),
  OnboardingModel(
      image: 'assets/onboard/2.png',
      title: 'ابدأ استخدام التطبيق الآن!',
      body: 'احصل على إشعارات الحضور في الوقت المناسب. إدارة وقتك أصبحت أسهل!'),
  OnboardingModel(
      image: 'assets/onboard/3.png',
      title: 'تابع تقدمك الأكاديمي بكل سهولة.',
      body: 'تطبيقنا يتيح لك الوصول لحضورك في أي وقت.اجعل التنظيم جزءًا من روتينك اليومي!')
];
