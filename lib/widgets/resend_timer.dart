import 'package:flutter/material.dart';

class ResendTimer extends StatefulWidget {
  const ResendTimer({super.key});

  @override
  State<ResendTimer> createState() => _ResendTimerState();
}

class _ResendTimerState extends State<ResendTimer> {
  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
        _startTimer();
      } else {
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  void _resendOtp() {
    setState(() {
      _secondsRemaining = 60;
      _canResend = false;
    });
    _startTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP sent again! 📲'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _canResend ? "Didn't receive the code? " : 'Resend code in ',
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Roboto',
          ),
        ),
        if (!_canResend)
          Text(
            '$_secondsRemaining s',
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
          ),
        if (_canResend)
          TextButton(
            onPressed: _resendOtp,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
            child: const Text(
              'Resend OTP',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
          ),
      ],
    );
  }
}
