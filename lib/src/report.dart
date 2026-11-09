/// Formats a count with a singular or plural noun.
library;

String plural(int count, String noun) => '$count $noun${count == 1 ? '' : 's'}';
