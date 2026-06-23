import 'dart:typed_data';

import '../../core/constants/app_assets.dart';
import '../../core/enums/user_role.dart';

enum ChatParticipantType { tailor, shopkeeper, customer }

class ChatThread {
  const ChatThread({
    required this.id,
    required this.participantName,
    required this.participantAvatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.participantType,
    this.hasUnread = false,
    this.orderLabel,
  });

  final String id;
  final String participantName;
  final String participantAvatarUrl;
  final String lastMessage;
  final String lastMessageTime;
  final ChatParticipantType participantType;
  final bool hasUnread;
  final String? orderLabel;

  static const customerThreads = [
    ChatThread(
      id: 'c-zara',
      participantName: 'Zara Mehmood',
      participantAvatarUrl: AppAssets.dress4,
      lastMessage:
          'Hello! I\'ve just finished the initial measurement mapping for your lawn suit. Before I proceed with the neckline, could you confirm if you prefer a boat neck or a classic round neck?',
      lastMessageTime: '10:42 AM',
      participantType: ChatParticipantType.tailor,
      hasUnread: true,
      orderLabel: 'Embroidered Lawn Suit',
    ),
    ChatThread(
      id: 'c-amir',
      participantName: 'Amir Mehmood',
      participantAvatarUrl: AppAssets.dress5,
      lastMessage: 'Your silk shipment is ready for pickup.',
      lastMessageTime: 'Yesterday',
      participantType: ChatParticipantType.shopkeeper,
      orderLabel: 'Raw Silk (Cream)',
    ),
    ChatThread(
      id: 'c-fatima',
      participantName: 'Fatima Khan',
      participantAvatarUrl: AppAssets.dress2,
      lastMessage: 'The bridal fitting is scheduled for Friday.',
      lastMessageTime: 'Mon',
      participantType: ChatParticipantType.tailor,
      orderLabel: 'Bridal Lehenga',
    ),
  ];

  static const tailorThreads = [
    ChatThread(
      id: 't-komal',
      participantName: 'Komal Shah',
      participantAvatarUrl: AppAssets.dress6,
      lastMessage:
          'I definitely prefer the soft dupatta drape with minimal pleating on the sleeves.',
      lastMessageTime: '10:45 AM',
      participantType: ChatParticipantType.customer,
      hasUnread: true,
      orderLabel: '3 Piece Lawn',
    ),
    ChatThread(
      id: 't-hira',
      participantName: 'Hira Shah',
      participantAvatarUrl: AppAssets.dress7,
      lastMessage: 'Can we move the fitting to next week?',
      lastMessageTime: 'Yesterday',
      participantType: ChatParticipantType.customer,
      orderLabel: 'Party Frock',
    ),
  ];

  static const shopkeeperThreads = [
    ChatThread(
      id: 's-komal',
      participantName: 'Komal Shah',
      participantAvatarUrl: AppAssets.dress6,
      lastMessage: 'Please confirm the cream silk is still available.',
      lastMessageTime: '11:02 AM',
      participantType: ChatParticipantType.customer,
      hasUnread: true,
      orderLabel: 'Raw Silk (Cream)',
    ),
    ChatThread(
      id: 's-sana',
      participantName: 'Sana Saif',
      participantAvatarUrl: AppAssets.dress8,
      lastMessage: 'The lace sample looks perfect, thank you!',
      lastMessageTime: 'Tue',
      participantType: ChatParticipantType.customer,
      orderLabel: 'Chantilly Lace',
    ),
  ];

  static List<ChatThread> forRole(UserRole role) {
    return switch (role) {
      UserRole.customer => List.of(customerThreads),
      UserRole.tailor => List.of(tailorThreads),
      UserRole.shopkeeper => List.of(shopkeeperThreads),
    };
  }

  static ChatThread? findById(String id) {
    for (final thread in [
      ...customerThreads,
      ...tailorThreads,
      ...shopkeeperThreads,
    ]) {
      if (thread.id == id) return thread;
    }
    return null;
  }
}

enum ChatMessageType { text, image, voice }

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.isOutgoing,
    required this.type,
    required this.time,
    this.text,
    this.imageUrl,
    this.localImageBytes,
    this.caption,
    this.voiceDuration,
  });

  final String id;
  final bool isOutgoing;
  final ChatMessageType type;
  final String time;
  final String? text;
  final String? imageUrl;
  final Uint8List? localImageBytes;
  final String? caption;
  final String? voiceDuration;

  static const zaraConversation = [
    ChatMessage(
      id: 'm1',
      isOutgoing: false,
      type: ChatMessageType.text,
      time: '10:38 AM',
      text:
          'Hello! I\'ve just finished the initial measurement mapping for your lawn suit. Before I proceed with the neckline finishing, could you confirm if you prefer a boat neck or a classic round neck with light embroidery?',
    ),
    ChatMessage(
      id: 'm2',
      isOutgoing: true,
      type: ChatMessageType.text,
      time: '10:42 AM',
      text:
          'I definitely prefer a soft boat neck with minimal sleeve pleating. I want it to feel light and comfortable for summer. Did you receive the fabric swatch I sent?',
    ),
    ChatMessage(
      id: 'm3',
      isOutgoing: false,
      type: ChatMessageType.image,
      time: '10:44 AM',
      imageUrl: AppAssets.dress1,
      caption:
          'This is the premium lawn we discussed. The soft drape will look beautiful once the dupatta edging is finished.',
    ),
    ChatMessage(
      id: 'm4',
      isOutgoing: true,
      type: ChatMessageType.image,
      time: '10:46 AM',
      imageUrl: AppAssets.dress2,
      caption:
          'This is the silhouette I\'m aiming for. A fitted bodice is a must, but please ensure there is enough ease for comfortable movement.',
    ),
    ChatMessage(
      id: 'm5',
      isOutgoing: false,
      type: ChatMessageType.voice,
      time: '10:48 AM',
      voiceDuration: '0:14',
    ),
  ];

  static List<ChatMessage> forThread(String threadId) {
    final useFullConversation =
        threadId == 'c-zara' || threadId == 't-komal';
    final flipPerspective = threadId.startsWith('t-') ||
        threadId.startsWith('s-');

    if (useFullConversation) {
      return zaraConversation
          .map(
            (message) => ChatMessage(
              id: message.id,
              isOutgoing: flipPerspective
                  ? !message.isOutgoing
                  : message.isOutgoing,
              type: message.type,
              time: message.time,
              text: message.text,
              imageUrl: message.imageUrl,
              localImageBytes: message.localImageBytes,
              caption: message.caption,
              voiceDuration: message.voiceDuration,
            ),
          )
          .toList();
    }

    final thread = ChatThread.findById(threadId);
    if (thread == null) return const [];

    return [
      ChatMessage(
        id: 'default-1',
        isOutgoing: false,
        type: ChatMessageType.text,
        time: thread.lastMessageTime,
        text: thread.lastMessage,
      ),
    ];
  }
}
