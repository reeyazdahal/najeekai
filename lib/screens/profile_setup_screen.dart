import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/labeled_field.dart';
import '../widgets/interest_chip.dart';
import '../constants/colors.dart';
import '../constants/interests_data.dart';
import '../models/interest.dart';
import 'location_permission_screen.dart'; // Add this import

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _scrollController = ScrollController();

  String? _selectedAgeRange;
  String? _selectedGender;
  File? _profileImage;
  final Set<Interest> _selectedInterests = {};
  final Map<String, String?> _fieldErrors = {};

  final List<String> _ageRanges = [
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55+',
  ];

  final List<String> _genders = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _profileImage = null;
    });
  }

  void _validateForm() {
    _fieldErrors.clear();

    if (_nameController.text.isEmpty) {
      _fieldErrors['name'] = 'Please enter your name';
    }

    if (_selectedAgeRange == null) {
      _fieldErrors['age'] = 'Please select your age range';
    }

    if (_selectedInterests.length < 3) {
      _fieldErrors['interests'] = 'Select at least 3 interests';
    }

    setState(() {});

    if (_fieldErrors.isEmpty) {
      _navigateToLocationScreen();
    } else {
      // Scroll to first error
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _navigateToLocationScreen() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LocationPermissionScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _toggleInterest(Interest interest, bool selected) {
    setState(() {
      if (selected) {
        _selectedInterests.add(interest);
      } else {
        _selectedInterests.remove(interest);
      }
      _fieldErrors.remove('interests');
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Complete Your Profile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tell us about yourself to find your perfect community',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Photo
                          Center(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.grey[200],
                                      backgroundImage: _profileImage != null
                                          ? FileImage(_profileImage!)
                                          : null,
                                      child: _profileImage == null
                                          ? const Icon(
                                              Icons.person,
                                              size: 50,
                                              color: Colors.grey,
                                            )
                                          : null,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColors.primary,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                          onPressed: _pickImage,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (_profileImage != null)
                                  TextButton(
                                    onPressed: _removeImage,
                                    child: const Text(
                                      'Remove photo',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                else
                                  TextButton(
                                    onPressed: _pickImage,
                                    child: const Text(
                                      'Skip photo',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Name Field
                          LabeledField(
                            label: 'Name *',
                            errorText: _fieldErrors['name'],
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: 'Enter your full name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              onChanged: (_) => _fieldErrors.remove('name'),
                            ),
                          ),
                          // Age Range
                          LabeledField(
                            label: 'Age Range *',
                            errorText: _fieldErrors['age'],
                            child: DropdownButtonFormField<String>(
                              value: _selectedAgeRange,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              items: _ageRanges
                                  .map((age) => DropdownMenuItem(
                                        value: age,
                                        child: Text(age),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedAgeRange = value;
                                  _fieldErrors.remove('age');
                                });
                              },
                              hint: const Text('Select your age range'),
                            ),
                          ),
                          // Gender (Optional)
                          LabeledField(
                            label: 'Gender (Optional)',
                            child: DropdownButtonFormField<String>(
                              value: _selectedGender,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              items: _genders
                                  .map((gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                              hint: const Text('Select your gender'),
                            ),
                          ),
                          // Interests
                          LabeledField(
                            label: 'Interests * (Select 3-5)',
                            errorText: _fieldErrors['interests'],
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: InterestsData.allInterests
                                  .map((interest) => InterestChip(
                                        interest: interest,
                                        isSelected: _selectedInterests
                                            .contains(interest),
                                        onSelected: (selected) =>
                                            _toggleInterest(interest, selected),
                                      ))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Continue Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _validateForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                              ),
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Gradient Background Widget
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE3F2FD),
          ],
        ),
      ),
      child: child,
    );
  }
}
