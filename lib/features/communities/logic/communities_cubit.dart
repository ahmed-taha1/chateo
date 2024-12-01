import 'package:bloc/bloc.dart';
import 'package:chateo/core/models/community.dart';
import 'package:chateo/features/communities/data/communities_repo.dart';
import 'package:equatable/equatable.dart';

part 'communities_state.dart';

class CommunitiesCubit extends Cubit<CommunitiesState> {
  List<Community> communities = [];
  final String phoneNumber;
  final CommunitiesRepo communitiesRepo;

  CommunitiesCubit({
    required this.communities,
    required this.phoneNumber,
    required this.communitiesRepo,
  }) : super(CommunitiesInitial());

  Future<void> subscribe(int communityIndex) async {
    await communitiesRepo.subscribe(communities[communityIndex].name, phoneNumber);
    communities[communityIndex].isSubscribed = true;
    emit(CommunitiesSubscribed(communityIndex));
  }

  Future<void> unsubscribe(int communityIndex) async {
    await communitiesRepo.unsubscribe(communities[communityIndex].name, phoneNumber);
    communities[communityIndex].isSubscribed = false;
    emit(CommunitiesUnsubscribed(communityIndex));
  }
}