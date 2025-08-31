import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<ChatConversation> _conversations = [
    ChatConversation(
      id: '1',
      name: 'Sarah Chen',
      photoUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      lastMessage: 'See you at yoga tomorrow! 🧘‍♀️',
      time: '2 min ago',
      unreadCount: 0,
      isOnline: true,
    ),
    ChatConversation(
      id: '2',
      name: 'Tech Enthusiasts Group',
      photoUrl: '',
      lastMessage: 'Alex: Anyone working on Flutter projects?',
      time: '15 min ago',
      unreadCount: 3,
      isOnline: false,
      isGroup: true,
    ),
    ChatConversation(
      id: '3',
      name: 'Marcus Johnson',
      photoUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      lastMessage: 'The recipe was amazing! 👨‍🍳',
      time: '1 hr ago',
      unreadCount: 0,
      isOnline: false,
    ),
    ChatConversation(
      id: '4',
      name: 'Fitness Crew',
      photoUrl: '',
      lastMessage: 'Maria: Running group this Sunday at 8 AM',
      time: '2 hrs ago',
      unreadCount: 12,
      isOnline: false,
      isGroup: true,
    ),
    ChatConversation(
      id: '5',
      name: 'Priya Sharma',
      photoUrl: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=150&h=150&fit=crop&crop=face',
      lastMessage: 'Thanks for the book recommendation!',
      time: '5 hrs ago',
      unreadCount: 0,
      isOnline: true,
    ),
  ];

  void _navigateToChatScreen(ChatConversation conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          userName: conversation.name,
          userPhotoUrl: conversation.photoUrl,
          isOnline: conversation.isOnline,
        ),
      ),
    );
  }

  void _startNewChat() {
    print('Start new chat');
    // TODO: Implement new chat flow
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add_comment),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          final conversation = _conversations[index];
          return _buildChatListItem(conversation);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startNewChat,
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildChatListItem(ChatConversation conversation) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: conversation.photoUrl.isNotEmpty
                ? NetworkImage(conversation.photoUrl)
                : null,
            child: conversation.photoUrl.isEmpty
                ? Icon(conversation.isGroup ? Icons.groups : Icons.person, size: 24)
                : null,
            backgroundColor: conversation.isGroup ? Colors.blue[100] : Colors.grey[200],
          ),
          if (conversation.isOnline && !conversation.isGroup)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        conversation.name,
        style: TextStyle(
          fontWeight: conversation.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        conversation.lastMessage,
        style: TextStyle(
          color: conversation.unreadCount > 0 ? Colors.black : Colors.grey[600],
          fontWeight: conversation.unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            conversation.time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
          if (conversation.unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Text(
                conversation.unreadCount > 9 ? '9+' : conversation.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () => _navigateToChatScreen(conversation),
    );
  }
}

class ChatConversation {
  final String id;
  final String name;
  final String photoUrl;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isGroup;

  ChatConversation({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    this.isGroup = false,
  });
}