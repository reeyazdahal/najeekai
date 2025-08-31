import 'package:flutter/material.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/country_code_picker.dart';
import '../widgets/resend_timer.dart';
import '../constants/colors.dart';
import 'profile_setup_screen.dart'; // Add this import

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  String _selectedCountryCode = '+1';
  bool _showOtpSection = false;
  final int _otpLength = 6;
  bool _isVerifying = false;

  void _sendOtp() {
    if (_phoneController.text.length >= 9) {
      setState(() {
        _showOtpSection = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid phone number 📱',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  void _verifyOtp(String otp) {
    // Simulate OTP verification process
    setState(() {
      _isVerifying = true;
    });

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isVerifying = false;
      });

      // For demo purposes, assume OTP is always correct
      // In real app, you'd validate against your backend
      if (otp.length == _otpLength) {
        _navigateToProfileSetup();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid OTP. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void _navigateToProfileSetup() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileSetupScreen(),
      ),
    );
  }

  void _handleSocialSignIn(String provider) {
    print('$provider sign-in pressed');
    // For social sign-in, you might want to navigate directly to profile setup
    _navigateToProfileSetup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  AppColors.background,
                ],
              ),
            ),
          ),

          // Abstract shapes
          _buildBackgroundShapes(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Header
                  Text(
                    _showOtpSection ? 'Verify Your Phone' : 'Welcome!',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      fontFamily: 'Roboto',
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    _showOtpSection
                        ? 'Enter the 6-digit code sent to your phone'
                        : 'Enter your phone number to get started',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      fontFamily: 'Roboto',
                    ),
                  ),

                  const SizedBox(height: 40),

                  if (!_showOtpSection) _buildPhoneInputSection(),
                  if (_showOtpSection) _buildOtpSection(),

                  const SizedBox(height: 32),

                  if (!_showOtpSection) _buildSocialSignInOptions(),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (_isVerifying)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPhoneInputSection() {
    return Column(
      children: [
        // Phone input field
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Country code dropdown
              CountryCodePicker(
                selectedCode: _selectedCountryCode,
                onChanged: (code) {
                  setState(() {
                    _selectedCountryCode = code;
                  });
                },
              ),

              const SizedBox(width: 12),

              Expanded(
                child: TextField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Enter your phone number... 📞',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Send OTP button
        ElevatedButton(
          onPressed: _sendOtp,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            shadowColor: AppColors.primary.withOpacity(0.3),
          ),
          child: const Text(
            'Send OTP',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpSection() {
    return Column(
      children: [
        // OTP input fields
        OtpInputField(
          length: _otpLength,
          onCompleted: _verifyOtp,
        ),

        const SizedBox(height: 24),

        // Resend timer
        const ResendTimer(),
      ],
    );
  }

  Widget _buildSocialSignInOptions() {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or continue with',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google sign-in
            IconButton(
              onPressed: () => _handleSocialSignIn('Google'),
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.g_mobiledata,
                  size: 28,
                  color: AppColors.secondary,
                ),
              ),
            ),

            const SizedBox(width: 20),

            // Apple sign-in
            IconButton(
              onPressed: () => _handleSocialSignIn('Apple'),
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.apple,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBackgroundShapes() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        child: Opacity(
          opacity: 0.1,
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 200),
            painter: _BackgroundPainter(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }
}

// Background painter for abstract shapes
class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw circles
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.3),
      size.width * 0.15,
      paint..color = AppColors.primary.withOpacity(0.3),
    );

    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.6),
      size.width * 0.1,
      paint..color = AppColors.secondary.withOpacity(0.3),
    );

    // Draw some rounded rectangles
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.4, size.height * 0.8),
        width: size.width * 0.2,
        height: size.width * 0.1,
      ),
      const Radius.circular(20),
    );

    canvas.drawRRect(
      rect,
      paint..color = const Color(0xFF34A853).withOpacity(0.3),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
