extension StringExtensions on String {
  // Method to capitalize the first letter of each word and add white space
  String capitalizeAndAddSpace() {
    // Split by uppercase letters to create words
    final RegExp regExp = RegExp(r'(?<=[a-z])(?=[A-Z])');
    return this
        .split(regExp) // Split based on uppercase letters
        .map((word) => word[0].toUpperCase() + word.substring(1)) // Capitalize
        .join(' '); // Join with spaces
  }
}