import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> logSubscriptionEvent({
    required String channelId,
    required int isSubscribed,
    required String userPhoneNumber,
  }) async {
    analytics.logEvent(
      name: 'channel_subscription',
      parameters: {
        'channel_id': channelId,
        'is_subscribed': isSubscribed,
        'user_phone_number': userPhoneNumber,
      },
    );
  }

  Future<void> logFirstTimeLogin(String userPhoneNumber) async {
    await analytics.logEvent(
      name: 'first_time_login',
      parameters: {
        'user_phone_number': userPhoneNumber,
      },
    );
  }

  Future<void> logCustomEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    await analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}
