import 'package:intl/intl.dart';

double rating(totalRating, numReviews) {
  if (numReviews == 0) {
    return 0;
  }
  return totalRating / (numReviews * 5);
}

String currency(double number){
  return NumberFormat.currency(locale: 'en-US').format(number);
}