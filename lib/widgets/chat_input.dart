import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final ValueChanged<String> onMessageSent;

  const ChatInput({
    super.key,
    required this.onMessageSent,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onMessageSent(text);
      _controller.clear();
      setState(() {
        _hasText = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          // Emoji Button
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
            onPressed: () {},
          ),

          // Attachment Button
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.grey),
            onPressed: () {},
          ),

          // Text Input
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _hasText = value.trim().isNotEmpty;
                });
              },
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: 5,
              minLines: 1,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),

          // Send Button
          IconButton(
            icon: Icon(
              _hasText ? Icons.send : Icons.mic,
              color: _hasText ? Colors.blue : Colors.grey,
            ),
            onPressed: _hasText ? _sendMessage : () {},
          ),
        ],
      ),
    );
  }
}
