import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/models/mock_chat.dart';
import '../../../../shared/models/selected_image.dart';
import '../../../../shared/services/photo_picker_service.dart';
import '../widgets/chat_conversation_app_bar.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message_bubble.dart';

class ChatConversationScreen extends StatefulWidget {
  const ChatConversationScreen({
    super.key,
    required this.threadId,
  });

  final String threadId;

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  late List<ChatMessage> _messages;
  final _messageController = TextEditingController();
  SelectedImage? _pendingImage;

  @override
  void initState() {
    super.initState();
    _messages = List.of(ChatMessage.forThread(widget.threadId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  ChatThread? get _thread => ChatThread.findById(widget.threadId);

  void _sendMessage() {
    final text = _messageController.text.trim();
    final hasImage = _pendingImage != null;
    if (text.isEmpty && !hasImage) return;

    setState(() {
      if (hasImage) {
        _messages.add(
          ChatMessage(
            id: 'local-img-${DateTime.now().millisecondsSinceEpoch}',
            isOutgoing: true,
            type: ChatMessageType.image,
            time: _formatNow(),
            localImageBytes: _pendingImage!.bytes,
            caption: text.isEmpty ? null : text,
          ),
        );
        _pendingImage = null;
      } else {
        _messages.add(
          ChatMessage(
            id: 'local-${DateTime.now().millisecondsSinceEpoch}',
            isOutgoing: true,
            type: ChatMessageType.text,
            time: _formatNow(),
            text: text,
          ),
        );
      }
      _messageController.clear();
    });
  }

  Future<void> _attachPhoto() async {
    final image = await PhotoPickerService.showPickerSheet(context);
    if (image == null || !mounted) return;
    setState(() => _pendingImage = image);
  }

  String _formatNow() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final thread = _thread;

    if (thread == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: const Center(child: Text('Conversation not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: ChatConversationAppBar(
        thread: thread,
        onCall: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Calling ${thread.participantName}...')),
          );
        },
        onMore: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('More options coming soon')),
          );
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              children: [
                const ChatDateDivider(),
                ..._messages.map(
                  (message) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: ChatMessageBubble(message: message),
                  ),
                ),
              ],
            ),
          ),
          ChatInputBar(
            controller: _messageController,
            onSend: _sendMessage,
            onAttach: _attachPhoto,
            pendingImage: _pendingImage,
            onClearPending: () => setState(() => _pendingImage = null),
          ),
        ],
      ),
    );
  }
}
