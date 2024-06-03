import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controllerfield;
  const CustomTextField({
    super.key,
    required this.controllerfield,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: TextField(
            controller: controllerfield,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: 'contoh : baharuddin@email.com',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              filled: true,
              fillColor: Colors.grey[200],
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final TextEditingController? controllerfield;
  final String label;
  const CustomPasswordField({
    super.key,
    required this.controllerfield,
    required this.label,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: TextField(
            controller: widget.controllerfield,
            obscureText: !_isPasswordVisible,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: 'Masukkan Password-mu di sini',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              filled: true,
              fillColor: Colors.grey[200],
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.grey[500],
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                child: Icon(_isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
