part of 'communities_cubit.dart';

sealed class CommunitiesState extends Equatable {
  const CommunitiesState();
  @override
  List<Object> get props => [];
}

final class CommunitiesInitial extends CommunitiesState {}
final class CommunitiesSubscribed extends CommunitiesState{
  final int communityIndex;
  const CommunitiesSubscribed(this.communityIndex);
  @override
  List<Object> get props => [communityIndex];
}
final class CommunitiesUnsubscribed extends CommunitiesState{
  final int communityIndex;
  const CommunitiesUnsubscribed(this.communityIndex);
  @override
  List<Object> get props => [communityIndex];
}