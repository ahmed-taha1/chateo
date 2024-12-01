import 'package:chateo/core/widgets/custom_input_text_field.dart';
import 'package:chateo/core/widgets/spacing.dart';
import 'package:chateo/features/chat/logic/chat_bloc.dart';
import 'package:chateo/features/chat/logic/chat_event.dart';
import 'package:chateo/features/chat/logic/chat_state.dart';
import 'package:chateo/features/chat/ui/widgets/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/message.dart';

class ChatView extends StatelessWidget {
  final String chatId;
  final TextEditingController _messageController = TextEditingController();

  ChatView({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Column(
              children: [
                // Top Header with Chat Title
                Container(
                  height: 100,
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      Text(chatId),
                    ],
                  ),
                ),
                verticalSpace(10),

                // Messages List (with BlocBuilder)
                Expanded(
                  child: BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ChatFetched) {
                        final messages = state.messages;

                        return ListView.builder(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                          physics: const BouncingScrollPhysics(),
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message =
                                messages[messages.length - 1 - index];
                            return MessageTile(
                              isSentByMe:
                                  message.sender == chatBloc.phoneNumber,
                              message: message.message,
                            );
                          },
                        );
                      } else if (state is ChatError) {
                        return Center(child: Text(state.error));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),

            // Input Field and Send Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInputTextField(
                        hintText: "Type a message",
                        controller: _messageController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        final messageText = _messageController.text.trim();
                        if (messageText.isNotEmpty) {
                          chatBloc.add(
                            SendMessage(
                              Message(
                                sender: chatBloc.phoneNumber,
                                message: messageText,
                              ),
                            ),
                          );
                          _messageController.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        size: 30,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
