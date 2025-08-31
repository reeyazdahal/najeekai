import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/activity_pin.dart';
import '../widgets/activity_card.dart';
import '../widgets/activity_mini_card.dart';
import '../widgets/add_activity_sheet.dart';
import '../constants/activities_data.dart';
import '../models/activity.dart';
import '../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();
  Activity? _selectedActivity;
  final double _initialZoom = 13.0;
  final LatLng _initialCenter = const LatLng(27.7172, 85.3240);

  // Method to handle map movement based on search query
  void _searchAndMoveMap(String query) async {
    if (query.isEmpty) return;

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          _mapController.move(LatLng(lat, lon), _initialZoom + 2);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location not found')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to perform search')),
      );
    }
  }

  // Method to show the search bottom sheet
  void _showSearchSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Search Location',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search for a city, landmark...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: (query) {
                  Navigator.pop(context); // Close the sheet
                  _searchAndMoveMap(query);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  // Method to show the list of activities in a modal bottom sheet
  void _showActivityListSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.2,
          maxChildSize: 0.95, // Increased max size
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Draggable handle
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const Text(
                  '2 activities in this area',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: ActivitiesData.dummyActivities.length,
                    itemBuilder: (context, index) {
                      final activity = ActivitiesData.dummyActivities[index];
                      return ActivityCard(
                        activity: activity,
                        onTap: () {
                          Navigator.pop(context);
                          _showFullActivityDetails(activity);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Method to show a mini card for an activity pin
  void _showActivityDetails(Activity activity) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ActivityMiniCard(
        activity: activity,
        onViewDetails: () {
          Navigator.pop(context);
          _showFullActivityDetails(activity);
        },
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  // Method to show the full details in an AlertDialog
  void _showFullActivityDetails(Activity activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(activity.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(activity.icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(activity.category),
              ],
            ),
            const SizedBox(height: 16),
            Text(activity.description),
            const SizedBox(height: 16),
            Text('Organizer: ${activity.organizer}'),
            Text('Participants: ${activity.participants}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Join Activity'),
          ),
        ],
      ),
    );
  }

  // Method to show the Add Activity sheet
  void _showAddActivitySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddActivitySheet(
        onActivityAdded: () {
          setState(() {
            print('Activity added - refresh home screen');
          });
        },
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: IconButton(
            icon: const Icon(Icons.person, size: 20),
            onPressed: () {},
          ),
        ),
        title: const Text(
          'najeekai',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map View (always present)
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _initialCenter,
              zoom: _initialZoom,
              onTap: (_, __) => setState(() => _selectedActivity = null),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.najeekai.app',
              ),
              MarkerLayer(
                markers: ActivitiesData.dummyActivities.map((activity) {
                  return Marker(
                    point: LatLng(activity.latitude, activity.longitude),
                    width: 60,
                    height: 60,
                    child: ActivityPin(
                      activity: activity,
                      onTap: () {
                        setState(() {
                          _selectedActivity = activity;
                        });
                        _showActivityDetails(activity);
                      },
                      isSelected: _selectedActivity?.id == activity.id,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Search button
          Positioned(
            top: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: _showSearchSheet,
              backgroundColor: Colors.white,
              child: const Icon(Icons.search, color: Colors.black),
            ),
          ),

          // "List" button to show the modal sheet
          Positioned(
            bottom: 32, // Adjusted position
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: _showActivityListSheet,
                icon: const Icon(Icons.list, color: Colors.white),
                label: const Text(
                  'List',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 16), // Adjusted padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddActivitySheet,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
