import 'package:flutter/material.dart';
import '../widgets/category_chip.dart';
import '../widgets/event_card.dart';
import '../constants/events_data.dart';
import 'event_details_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _searchQuery = '';

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _navigateToEventDetails(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsScreen(event: event),
      ),
    );
  }

  void _joinEvent(Event event) {
    // TODO: Implement join event functionality
    print('Joining event: ${event.title}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joined ${event.title}!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  List<Event> get _filteredEvents {
    List<Event> events = EventsData.dummyEvents;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      events = events.where((event) {
        return event.title.toLowerCase().contains(_searchQuery) ||
            event.description.toLowerCase().contains(_searchQuery) ||
            event.location.toLowerCase().contains(_searchQuery);
      }).toList();
    }

    // Filter by category
    if (_selectedCategory != 'All') {
      events = events.where((event) => event.category == _selectedCategory).toList();
    }

    return events;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search events...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          // Category Chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                // All category
                CategoryChip(
                  category: 'All',
                  isSelected: _selectedCategory == 'All',
                  onTap: () => _selectCategory('All'),
                ),
                // Other categories
                ...EventsData.categories.map((category) {
                  return CategoryChip(
                    category: category,
                    isSelected: _selectedCategory == category,
                    onTap: () => _selectCategory(category),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Events List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEvents.length,
              itemBuilder: (context, index) {
                final event = _filteredEvents[index];
                return EventCard(
                  event: event,
                  onTap: () => _navigateToEventDetails(event),
                  onJoin: () => _joinEvent(event),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}