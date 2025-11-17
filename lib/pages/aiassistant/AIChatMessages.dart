class ChatMessage {
  final String content;
  final bool sent;
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.sent,
    required this.timestamp,
  });
}

final List<ChatMessage> messages = [
  ChatMessage(
    content: "What can I help you with today?",
    sent: false,
    timestamp: DateTime(2025, 11, 14, 13, 51),
  ),
  ChatMessage(
    content: "Can you give me some workouts that target rear delts?",
    sent: true,
    timestamp: DateTime(2025, 11, 14, 13, 52),
  ),
  ChatMessage(
    content:
    "Sounds good! Here’s a list:\n\n- Archer pulls\n- Reverse flyes\n- Dumbbell rows",
    sent: false,
    timestamp: DateTime(2025, 11, 15, 10, 14),
  ),
];