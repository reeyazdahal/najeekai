import 'package:flutter/material.dart';
import '../models/person.dart';

class PersonCard extends StatefulWidget {
  final Person person;
  final VoidCallback onConnect;
  final VoidCallback onMessage;

  const PersonCard({
    super.key,
    required this.person,
    required this.onConnect,
    required this.onMessage,
  });

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  bool _isConnecting = false;
  bool _isConnected = false;

  void _handleConnect() {
    setState(() {
      _isConnecting = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isConnecting = false;
          _isConnected = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Profile Photo
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.person.photoUrl),
            ),
            const SizedBox(width: 16),
            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.person.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.person.age} • ${widget.person.distance} km away',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Shared Interests
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: widget.person.interests.take(3).map((interest) {
                      return Chip(
                        label: Text(interest),
                        backgroundColor: Colors.blue[50],
                        labelStyle: const TextStyle(fontSize: 10),
                        visualDensity: VisualDensity.compact,
                      );
                    }).toList(),
                  ),
                  if (widget.person.mutualFriends > 0) ...[
                    const SizedBox(height: 6),
                    Text(
                      '${widget.person.mutualFriends} mutual friends',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Action Buttons
            Column(
              children: [
                ElevatedButton(
                  onPressed: _isConnected
                      ? null
                      : _isConnecting
                          ? null
                          : _handleConnect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isConnected ? Colors.green : Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(100, 36),
                  ),
                  child: _isConnecting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Text(_isConnected ? 'Connected' : 'Connect'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: widget.onMessage,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(100, 36),
                  ),
                  child: const Text('Message'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
