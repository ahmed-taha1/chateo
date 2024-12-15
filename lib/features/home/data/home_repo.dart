import 'dart:developer';

import 'package:chateo/core/models/community.dart';
import 'package:chateo/core/services/cache_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepo {
  final FirebaseFirestore fireStore;
  HomeRepo(this.fireStore);

  Future<List<Community>> fetchCommunities(
      {required String phoneNumber}) async {
    List<Community> ret = [];
    var communities = await fireStore.collection('communities').get();
    var users = await fireStore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();
    if (users.docs.isEmpty) {
      fireStore
          .collection('users')
          .add({'phoneNumber': phoneNumber, 'subscribed_communities': []});
    }
    else if(users.docs[0].data()['subscribed_communities'] == null){
      await users.docs[0].reference.update({'subscribed_communities': []});
    }
    log("fetching communities");
    for (var i in communities.docs) {
      bool? isSubscribed = users.docs.isEmpty ? false : users.docs[0]
          .data()['subscribed_communities']
          .contains(i.data()['name']);

      ret.add(
        Community.fromJson(
          i.data(),
          i.id,
          isSubscribed: isSubscribed ?? false,
        ),
      );
    }
    return ret;
  }

  Future<String> getPhoneNumberFromCache() async {
    return await CacheService.getData(key: CacheServiceConstants.phoneNumber);
  }
}
