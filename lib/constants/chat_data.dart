import '../models/message.dart';

class ChatData {
  static final List<Message> dummyMessages = [
    Message(
      id: '1',
      senderId: 'user2',
      senderName: 'Sarah Chen',
      text: 'Hey there! 👋 How are you doing today?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      status: MessageStatus.read,
      isMe: false,
    ),
    Message(
      id: '2',
      senderId: 'user1',
      senderName: 'You',
      text:
          'Hi Sarah! I\'m doing great, thanks for asking! Just finished my morning workout 💪',
      timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
      status: MessageStatus.read,
      isMe: true,
    ),
    Message(
      id: '3',
      senderId: 'user2',
      senderName: 'Sarah Chen',
      text:
          'That\'s awesome! I was thinking about joining the yoga session in the park tomorrow. Want to come? 🧘‍♀️',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      status: MessageStatus.read,
      isMe: false,
    ),
    Message(
      id: '4',
      senderId: 'user1',
      senderName: 'You',
      text: 'Sounds perfect! What time does it start?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      status: MessageStatus.read,
      isMe: true,
    ),
    Message(
      id: '5',
      senderId: 'user2',
      senderName: 'Sarah Chen',
      text: 'It starts at 9 AM. Bring a mat if you have one!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      status: MessageStatus.read,
      isMe: false,
    ),
    Message(
      id: '6',
      senderId: 'user1',
      senderName: 'You',
      text: 'Will do! Looking forward to it 😊',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      status: MessageStatus.read,
      isMe: true,
    ),
  ];
}
