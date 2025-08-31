import '../models/person.dart';

class PeopleData {
  static final List<Person> dummyPeople = [
    Person(
      id: '1',
      name: 'Sarah Chen',
      photoUrl:
          'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      age: 28,
      interests: ['Photography', 'Hiking', 'Coffee', 'Tech'],
      distance: 2.3,
      mutualFriends: 3,
    ),
    Person(
      id: '2',
      name: 'Marcus Johnson',
      photoUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      age: 32,
      interests: ['Guitar', 'Cooking', 'Travel', 'Movies'],
      distance: 1.8,
      mutualFriends: 2,
    ),
    Person(
      id: '3',
      name: 'Priya Sharma',
      photoUrl:
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=150&h=150&fit=crop&crop=face',
      age: 26,
      interests: ['Yoga', 'Reading', 'Art', 'Dancing'],
      distance: 3.1,
      mutualFriends: 5,
    ),
    Person(
      id: '4',
      name: 'Alex Kim',
      photoUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
      age: 30,
      interests: ['Basketball', 'Tech', 'Music', 'Food'],
      distance: 0.8,
      mutualFriends: 7,
    ),
    Person(
      id: '5',
      name: 'Emma Wright',
      photoUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      age: 29,
      interests: ['Writing', 'Running', 'Photography', 'Books'],
      distance: 4.2,
      mutualFriends: 1,
    ),
  ];
}
