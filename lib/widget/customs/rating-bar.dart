import 'package:flutter/material.dart';

class TadeRatingBar extends StatefulWidget {
  final int initialRating; // Initial rating value
  final ValueChanged<int>
      onRatingSelected; // Callback when a rating is selected

  const TadeRatingBar({
    Key? key,
    this.initialRating = 0,
    required this.onRatingSelected,
  }) : super(key: key);

  @override
  _TadeRatingBarState createState() => _TadeRatingBarState();
}

class _TadeRatingBarState extends State<TadeRatingBar> {
  late int _selectedRating;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.initialRating; // Set initial rating from parent
  }

  // Function to handle rating change
  void _onRatingSelected(int rating) {
    setState(() {
      _selectedRating = rating;
    });
    widget
        .onRatingSelected(rating); // Notify parent widget of the rating change
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRatingIcon(1, "Very poor"),
        _buildRatingIcon(2, "Poor"),
        _buildRatingIcon(3, "Fair"),
        _buildRatingIcon(4, "Very Good"),
        _buildRatingIcon(5, "Excellent"),
      ],
    );
  }

  // Helper function to build each rating icon with text
  Widget _buildRatingIcon(int ratingValue, String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _onRatingSelected(ratingValue), // Handle tap
          child: Icon(
              _selectedRating >= ratingValue ? Icons.star : Icons.star_outline,
              size: 33,
              color: const Color(0xff009933) // Highlight based on rating
              ),
        ),
        Text(
          label,
          style:  TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 10,
            fontFamily: "PoppinsMeds",
          ),
        )
      ],
    );
  }
}
