import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/community_card.dart';
import '../widgets/person_card.dart';
import '../constants/communities_data.dart';
import '../constants/people_data.dart';
import '../models/community.dart';
import '../models/person.dart';

class CommunitiesScreen extends StatefulWidget {
  // Changed from DiscoverScreen to CommunitiesScreen
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() =>
      _CommunitiesScreenState(); // Updated
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  // Updated
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _onFilterPressed() {
    print('Filter pressed');
  }

  void _onCommunityTap(Community community) {
    print('Community tapped: ${community.name}');
  }

  void _onConnect(Person person) {
    print('Connect with: ${person.name}');
  }

  void _onMessage(Person person) {
    print('Message: ${person.name}');
  }

  void _createGroup() {
    print('Create new group');
  }

  List<Community> get _filteredCommunities {
    if (_searchQuery.isEmpty) return CommunitiesData.dummyCommunities;
    return CommunitiesData.dummyCommunities.where((community) {
      return community.name.toLowerCase().contains(_searchQuery) ||
          community.tagline.toLowerCase().contains(_searchQuery) ||
          community.interests
              .any((interest) => interest.toLowerCase().contains(_searchQuery));
    }).toList();
  }

  List<Person> get _filteredPeople {
    if (_searchQuery.isEmpty) return PeopleData.dummyPeople;
    return PeopleData.dummyPeople.where((person) {
      return person.name.toLowerCase().contains(_searchQuery) ||
          person.interests
              .any((interest) => interest.toLowerCase().contains(_searchQuery));
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Communities'), // Updated title
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SearchBarWidget(
                onSearchChanged: _onSearchChanged,
                onFilterPressed: _onFilterPressed,
              ),
            ),

            // Divider
            const Divider(height: 1, thickness: 1),

            // Scrollable content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  // Communities Section
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                    child: Text(
                      'Popular Communities',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  // Horizontal Communities List
                  SizedBox(
                    height: 190,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      children: [
                        // Create Group Button
                        Container(
                          width: 160,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              onTap: _createGroup,
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 24,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Create Group',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Start community',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[600],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Community Cards
                        ..._filteredCommunities.map((community) {
                          return CommunityCard(
                            community: community,
                            onTap: () => _onCommunityTap(community),
                          );
                        }),
                      ],
                    ),
                  ),

                  // People Section Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'People Near You',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${_filteredPeople.length} results',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // People List
                  ..._filteredPeople.map((person) {
                    return PersonCard(
                      person: person,
                      onConnect: () => _onConnect(person),
                      onMessage: () => _onMessage(person),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
