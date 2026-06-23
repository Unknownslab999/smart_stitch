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
      id: 'c-shehzad',
      participantName: 'Shehzad Mehmood',
      participantAvatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      lastMessage:
          'Hello! I\'ve just finished the initial 3D mapping of your measurements...',
      lastMessageTime: '10:42 AM',
      participantType: ChatParticipantType.tailor,
      hasUnread: true,
      orderLabel: 'Charcoal Blazer',
    ),
    ChatThread(
      id: 'c-amir',
      participantName: 'Amir Mehmood',
      participantAvatarUrl:
          'https://images.unsplash.com/photo-1558171813-4c088753af8f?w=200',
      lastMessage: 'Your silk shipment is ready for pickup.',
      lastMessageTime: 'Yesterday',
      participantType: ChatParticipantType.shopkeeper,
      orderLabel: 'Raw Silk (Cream)',
    ),
    ChatThread(
      id: 'c-fatima',
      participantName: 'Fatima Khan',
      participantAvatarUrl:
          'https://images.unsplash.com/photo-1583391733981-5c55a4f4f2c0?w=200',
      lastMessage: 'The bridal fitting is scheduled for Friday.',
      lastMessageTime: 'Mon',
      participantType: ChatParticipantType.tailor,
      orderLabel: 'Bridal Lehenga',
    ),
  ];

  static const tailorThreads = [
    ChatThread(
      id: 't-komal',
      participantName: 'Komal Ayub',
      participantAvatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
      lastMessage:
          'I definitely prefer the soft Neapolitan shoulder with minimal padding.',
      lastMessageTime: '10:45 AM',
      participantType: ChatParticipantType.customer,
      hasUnread: true,
      orderLabel: '3 Piece Lawn',
    ),
    ChatThread(
      id: 't-ruhan',
      participantName: 'Ruhan Khan',
      participantAvatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
      lastMessage: 'Can we move the fitting to next week?',
      lastMessageTime: 'Yesterday',
      participantType: ChatParticipantType.customer,
      orderLabel: 'Sherwani',
    ),
  ];

  static const shopkeeperThreads = [
    ChatThread(
      id: 's-komal',
      participantName: 'Komal Ayub',
      participantAvatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
      lastMessage: 'Please confirm the cream silk is still available.',
      lastMessageTime: '11:02 AM',
      participantType: ChatParticipantType.customer,
      hasUnread: true,
      orderLabel: 'Raw Silk (Cream)',
    ),
    ChatThread(
      id: 's-sana',
      participantName: 'Sana Saif',
      participantAvatarUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
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
    this.caption,
    this.voiceDuration,
  });

  final String id;
  final bool isOutgoing;
  final ChatMessageType type;
  final String time;
  final String? text;
  final String? imageUrl;
  final String? caption;
  final String? voiceDuration;

  static const shehzadConversation = [
    ChatMessage(
      id: 'm1',
      isOutgoing: false,
      type: ChatMessageType.text,
      time: '10:38 AM',
      text:
          'Hello! I\'ve just finished the initial 3D mapping of your measurements. Before I proceed with the \'Suppression\' phase of the pattern, could you confirm if you prefer a roped shoulder or a more natural Neapolitan drape for the charcoal blazer?',
    ),
    ChatMessage(
      id: 'm2',
      isOutgoing: true,
      type: ChatMessageType.text,
      time: '10:42 AM',
      text:
          'I definitely prefer the soft Neapolitan shoulder with minimal padding. I want it to feel as comfortable as a cardigan. Did you receive the reference fabric I mailed?',
    ),
    ChatMessage(
      id: 'm3',
      isOutgoing: false,
      type: ChatMessageType.image,
      time: '10:44 AM',
      imageUrl:
          'https://images.unsplash.com/photo-1558171813-4c088753af8f?w=600',
      caption:
          'This is the Loro Piana charcoal herringbone we discussed. The 280g weight will have a beautiful drape once canvassed.',
    ),
    ChatMessage(
      id: 'm4',
      isOutgoing: true,
      type: ChatMessageType.image,
      time: '10:46 AM',
      imageUrl:
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=600',
      caption:
          'This is the silhouette I\'m aiming for. The tapered waist is a must, but please ensure there is enough room in the chest for movement.',
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
        threadId == 'c-shehzad' || threadId == 't-komal';
    final flipPerspective = threadId.startsWith('t-') ||
        threadId.startsWith('s-');

    if (useFullConversation) {
      return shehzadConversation
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
