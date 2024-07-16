import 'dart:math';

/// Calculates the height of the separator between match cards.
///
/// The separator height is based on the size of the groups, the vertical margin between items,
/// and the height of each card.
double calculateSeparatorHeight({
  required int groupsSize,
  required double itemsMarginVertical,
  required double cardHeight,
}) {
  double separatorHeight = 0;
  for (int i = 0; i <= groupsSize; i++) {
    separatorHeight = (cardHeight * (pow(2, i) - 1)) +
        (itemsMarginVertical * ((pow(2, i) - 1) + 1));
  }
  return separatorHeight;
}
