class Event {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String category;
  final String imageUrl;
  final int attendees;
  final String organizer;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.category,
    required this.imageUrl,
    required this.attendees,
    required this.organizer,
  });

  String get formattedDate {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String get formattedTime {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

class EventsData {
  static final List<Event> dummyEvents = [
    Event(
      id: '1',
      title: 'Tech Meetup & Networking',
      description:
          'Join us for an evening of tech discussions, networking, and knowledge sharing. Meet fellow developers, designers, and tech enthusiasts. We\'ll have lightning talks, refreshments, and plenty of opportunities to connect with like-minded people in the tech community.',
      dateTime: DateTime.now().add(const Duration(days: 2, hours: 18)),
      location: 'Tech Hub Downtown, 123 Innovation St',
      category: '💻 Tech',
      imageUrl:
          'https://images.unsplash.com/photo-1511578314322-379afb476865?w=400&h=200&fit=crop',
      attendees: 47,
      organizer: 'Tech Enthusiasts Group',
    ),
    Event(
      id: '2',
      title: 'Yoga in the Park',
      description:
          'Start your weekend with a peaceful yoga session in the beautiful city park. All levels welcome - from beginners to experienced yogis. Bring your own mat and water bottle. We\'ll focus on mindfulness, breathing, and gentle stretching to energize your body and mind.',
      dateTime: DateTime.now().add(const Duration(days: 3, hours: 9)),
      location: 'Central Park, Main Lawn',
      category: '🏃 Sports',
      imageUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400&h=200&fit=crop',
      attendees: 23,
      organizer: 'Wellness Community',
    ),
    Event(
      id: '3',
      title: 'Live Music Night',
      description:
          'Enjoy an evening of live music featuring local artists and bands. Different genres including acoustic, jazz, and indie rock. Come support local talent and enjoy great music in a cozy atmosphere. Food and drinks available for purchase.',
      dateTime: DateTime.now().add(const Duration(days: 5, hours: 20)),
      location: 'The Melody Cafe, 456 Music Ave',
      category: '🎤 Music',
      imageUrl:
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=400&h=200&fit=crop',
      attendees: 89,
      organizer: 'Local Music Collective',
    ),
    Event(
      id: '4',
      title: 'Book Club Discussion',
      description:
          'This month we\'re discussing "The Midnight Library" by Matt Haig. Join us for a lively conversation about choices, regrets, and the infinite possibilities of life. New members always welcome! Light refreshments provided.',
      dateTime: DateTime.now().add(const Duration(days: 7, hours: 16)),
      location: 'Coffee Corner, 789 Read St',
      category: '📚 Learning',
      imageUrl:
          'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=200&fit=crop',
      attendees: 15,
      organizer: 'Bookworm Club',
    ),
    Event(
      id: '5',
      title: 'Beach Volleyball Tournament',
      description:
          'Join our friendly beach volleyball tournament! Teams of 4-6 players. All skill levels welcome. We\'ll have multiple courts, referees, and prizes for the winning team. Bring your competitive spirit and beach gear!',
      dateTime: DateTime.now().add(const Duration(days: 10, hours: 14)),
      location: 'Sunset Beach, Volleyball Courts',
      category: '🎉 Social',
      imageUrl:
          'https://images.unsplash.com/photo-1592656094267-764a60323e56?w=400&h=200&fit=crop',
      attendees: 32,
      organizer: 'Sports & Social Club',
    ),
  ];

  static final List<String> categories = [
    '🎤 Music',
    '📚 Learning',
    '🏃 Sports',
    '💻 Tech',
    '🎉 Social',
    '🍕 Food',
    '🎨 Arts',
    '🌳 Outdoor',
  ];
}
