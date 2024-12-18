import 'dart:developer';

import 'package:chateo/core/services/analytics_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CommunitiesRepo {
  final FirebaseMessaging _firebaseMessaging;
  final FirebaseFirestore _fireStore;
  final AnalyticsService _analyticsService;

  CommunitiesRepo(
      this._firebaseMessaging, this._fireStore, this._analyticsService);

  Future<void> subscribe(String channelName, String phoneNumber) async {
    await _firebaseMessaging.subscribeToTopic(channelName);
    await _fireStore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get()
        .then(
      (value) async {
        if (value.docs.isNotEmpty) {
          await _fireStore.collection('users').doc(value.docs[0].id).update({
            'subscribed_communities': FieldValue.arrayUnion([channelName])
          });
        }
      },
    );
    log("Subscribed to $channelName");
    await _analyticsService.logSubscriptionEvent(
      channelId: channelName,
      isSubscribed: 1,
      userPhoneNumber: phoneNumber,
    );
  }

  Future<void> unsubscribe(String channelName, String phoneNumber) async {
    await _firebaseMessaging.unsubscribeFromTopic(channelName);
    await _fireStore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get()
        .then(
      (value) async {
        if (value.docs.isNotEmpty) {
          await _fireStore.collection('users').doc(value.docs[0].id).update({
            'subscribed_communities': FieldValue.arrayRemove([channelName])
          });
        }
      },
    );
    await _analyticsService.logSubscriptionEvent(
      channelId: channelName,
      isSubscribed: 0,
      userPhoneNumber: phoneNumber,
    );
  }
}
