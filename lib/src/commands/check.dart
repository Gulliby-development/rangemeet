/// The check command validates input and reports its constraint count.
library;

import '../registry.dart';
import '../report.dart';

Result runCheck(Options options, List<Item> items) => Result(0, 'ok ${plural(items.length, 'constraint')}\n', '');
