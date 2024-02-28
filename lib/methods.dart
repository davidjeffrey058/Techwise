double rating(totalRating, numReviews) {
  if (numReviews == 0) {
    return 0;
  }
  return totalRating / (numReviews * 5);
}