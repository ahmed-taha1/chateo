import 'package:chateo/features/communities/logic/communities_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunitiesBlocListener extends StatelessWidget {
  const CommunitiesBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunitiesCubit, CommunitiesState>(
      listener: (context, state) {
        if (state is CommunitiesSubscribed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Successfully subscribed to community"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is CommunitiesUnsubscribed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Successfully unsubscribed from community"),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
