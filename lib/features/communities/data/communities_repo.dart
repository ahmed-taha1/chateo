import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CommunitiesRepo{
  final FirebaseMessaging _firebaseMessaging;
  final FirebaseFirestore _fireStore;

  CommunitiesRepo(this._firebaseMessaging, this._fireStore);

  Future<void> subscribe(String channelName, String phoneNumber)async{
    await _firebaseMessaging.subscribeToTopic(channelName);
    await _fireStore.collection('users').where('phoneNumber', isEqualTo: phoneNumber).get().then((value) async{
      if(value.docs.isNotEmpty){
        await _fireStore.collection('users').doc(value.docs[0].id).update({
          'subscribed_communities': FieldValue.arrayUnion([channelName])
        });
      }
    });
  }

  Future<void> unsubscribe(String channelName, String phoneNumber)async{
    await _firebaseMessaging.unsubscribeFromTopic(channelName);
    await _fireStore.collection('users').where('phoneNumber', isEqualTo: phoneNumber).get().then((value) async{
      if(value.docs.isNotEmpty){
        await _fireStore.collection('users').doc(value.docs[0].id).update({
          'subscribed_communities': FieldValue.arrayRemove([channelName])
        });
      }
    });
  }
}