import 'package:flutter/cupertino.dart';

class FormValidation {
  static String? validateProductName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the product name';
    } else if (!RegExp(r"^[a-zA-Z0-9\s]+$").hasMatch(value)) {
      return 'Please enter a valid product name (letters, numbers, and spaces only)';
    }
    return null; // Return null when the product name is valid.
  }

  static String? validateInventory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the inventory';
    } else if (!RegExp(r"^[a-zA-Z0-9\s]+$").hasMatch(value)) {
      return 'Please enter a valid inventory (letters, numbers, and spaces only)';
    }
    return null; // Return null when the inventory is valid.
  }

  static String? validateSize(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the size';
    } else if (!RegExp(r"^[a-zA-Z0-9\s]+$").hasMatch(value)) {
      return 'Please enter a valid size (letters, numbers, and spaces only)';
    }
    return null; // Return null when the size is valid.
  }

  static String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the quantity';
    } else if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
      return 'Please enter a valid quantity (numbers only)';
    }
    return null; // Return null when the quantity is valid.
  }

  static String? validateActualPrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the actual price';
    } else if (!RegExp(r"^\d+(\.\d{1,2})?$").hasMatch(value)) {
      return 'Please enter a valid price (e.g., 123.45)';
    }
    return null; // Return null when the actual price is valid.
  }

  static String? validateStatus(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the status';
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return 'Please enter a valid status (letters and spaces only)';
    }
    return null; // Return null when the status is valid.
  }

  static String? validateConsumerPrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the consumer price';
    } else if (!RegExp(r"^\d+(\.\d{1,2})?$").hasMatch(value)) {
      return 'Please enter a valid price (e.g., 123.45)';
    }
    return null; // Return null when the consumer price is valid.
  }

  static String? validateDateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Data and Time ';
    }
    return null; // Return null when the consumer price is valid.
  }

  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the user name';

  }
    return null;
  }

  static String? validatePaidAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the valid price';

    }
    return null;
  }

}