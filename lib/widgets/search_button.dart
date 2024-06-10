import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool showRefreshButton;

  const SearchButton({
    super.key,
    required this.onTap,
    required this.showRefreshButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(showRefreshButton ? Icons.refresh : Icons.search, color: Colors.white, size: 25),
      ),
    );
  }
}
