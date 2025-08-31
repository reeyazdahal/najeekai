import 'package:flutter/material.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input.dart';
import '../constants/chat_data.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userPhotoUrl;
  final bool isOnline;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.userPhotoUrl,
    this.isOnline = true,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    // Load initial messages
    _messages.addAll(ChatData.dummyMessages);
    // Scroll to bottom after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleMessageSent(String text) {
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user1',
      senderName: 'You',
      text: text,
      timestamp: DateTime.now(),
      status: MessageStatus.sending,
      isMe: true,
    );

    setState(() {
      _messages.add(newMessage);
    });

    _scrollToBottom();

    // Simulate message delivery
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          // Update the status of the specific message
          final index = _messages.indexWhere((m) => m.id == newMessage.id);
          if (index != -1) {
            _messages[index].status = MessageStatus.sent;
          }
        });
      }
    });

    // Simulate message being read
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          // Update the status of the specific message
          final index = _messages.indexWhere((m) => m.id == newMessage.id);
          if (index != -1) {
            _messages[index].status = MessageStatus.read;
          }
        });
      }
    });

    // Simulate reply (optional)
    if (text.toLowerCase().contains('?')) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          final reply = Message(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            senderId: 'user2',
            senderName: widget.userName,
            text: _generateReply(text),
            timestamp: DateTime.now(),
            status: MessageStatus.read,
            isMe: false,
          );

          setState(() {
            _messages.add(reply);
          });

          _scrollToBottom();
        }
      });
    }
  }

  String _generateReply(String message) {
    if (message.toLowerCase().contains('how are you')) {
      return 'I\'m doing great! Thanks for asking! 😊';
    } else if (message.toLowerCase().contains('time')) {
      return 'Let me check my schedule...';
    } else if (message.toLowerCase().contains('meet')) {
      return 'Sounds good! When works for you?';
    } else if (message.toLowerCase().contains('hello') ||
        message.toLowerCase().contains('hi')) {
      return 'Hello there! 👋';
    } else {
      return 'That\'s interesting! Tell me more about it.';
    }
  }

  void _handleBackPressed() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: ChatAppBar(
        userName: widget.userName,
        userPhotoUrl: widget.userPhotoUrl,
        isOnline: widget.isOnline,
        onBackPressed: _handleBackPressed,
      ),
      body: Column(
        children: [
          // Chat Area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showAvatar = index == 0 ||
                    _messages[index - 1].senderId != message.senderId;

                return MessageBubble(
                  message: message,
                  showAvatar: showAvatar,
                );
              },
            ),
          ),

          // Input Area
          ChatInput(
            onMessageSent: _handleMessageSent,
          ),
        ],
      ),
    );
  }
}
