import 'rows.dart';

final rows = [
  row(['check'], 'n0 *\nn1 *\nn2 *\nn3 *\nn4 *\nn5 *\nn6 *\nn7 *\nn8 *\nn9 *\nn10 *\nn11 *\nn12 *\nn13 *\nn14 *\nn15 *\nn16 *\nn17 *\nn18 *\nn19 *\nn20 *\nn21 *\nn22 *\nn23 *\nn24 *\nn25 *\nn26 *\nn27 *\nn28 *\nn29 *\nn30 *\nn31 *\nn32 *\nn33 *\nn34 *\nn35 *\nn36 *\nn37 *\nn38 *\nn39 *\n', 0, 'ok 40 constraints\n', ''),
  row(['check'], 'n0 *\nn1 *\nn2 *\nn3 *\nn4 *\nn5 *\nn6 *\nn7 *\nn8 *\nn9 *\nn10 *\nn11 *\nn12 *\nn13 *\nn14 *\nn15 *\nn16 *\nn17 *\nn18 *\nn19 *\nn20 *\nn21 *\nn22 *\nn23 *\nn24 *\nn25 *\nn26 *\nn27 *\nn28 *\nn29 *\nn30 *\nn31 *\nn32 *\nn33 *\nn34 *\nn35 *\nn36 *\nn37 *\nn38 *\nn39 *\nn40 *\n', 1, '', 'rangemeet: input is too long (max 40 lines)\n'),
  row(['check'], 'abcdefghijkl ^1\n', 0, 'ok 1 constraint\n', ''),
  row(['check'], 'abcdefghijklm ^1\n', 1, '', 'rangemeet: line 1: bad name abcdefghijklm\n'),
  row(['check'], 'a ^9999.9999.9999\n', 0, 'ok 1 constraint\n', ''),
  row(['check'], 'a ^10000.0.0\n', 1, '', 'rangemeet: line 1: bad constraint ^10000.0.0\n'),
  row(['pick', '--have', '1.0.0,1.0.1,1.0.2,1.0.3,1.0.4,1.0.5,1.0.6,1.0.7,1.0.8,1.0.9,1.0.10,1.0.11,1.0.12,1.0.13,1.0.14,1.0.15,1.0.16,1.0.17,1.0.18,1.0.19,1.0.20'], 'a ^1\n', 2, '', 'rangemeet: bad value for --have\n'),
  row(['show'], 'a >=9999.9999.9999\nb <=9999.9999.9999\nc >9999.9999.9998\n', 0, 'a >=9999.9999.9999\nb <9999.9999.10000\nc >=9999.9999.9999\n3 constraints\n', ''),
  row(['meet'], 'n0 >=0\nn1 >=1\nn2 >=2\nn3 >=3\nn4 >=4\nn5 >=5\nn6 >=6\nn7 >=7\nn8 >=8\nn9 >=9\nn10 >=10\nn11 >=11\nn12 >=12\nn13 >=13\nn14 >=14\nn15 >=15\nn16 >=16\nn17 >=17\nn18 >=18\nn19 >=19\nn20 >=20\nn21 >=21\nn22 >=22\nn23 >=23\nn24 >=24\nn25 >=25\nn26 >=26\nn27 >=27\nn28 >=28\nn29 >=29\nn30 >=30\nn31 >=31\nn32 >=32\nn33 >=33\nn34 >=34\nn35 >=35\nn36 >=36\nn37 >=37\nn38 >=38\nn39 >=39\n', 0, 'meet >=39.0.0 of 40 constraints\n', ''),
  row(['clash', '--limit', '1000'], 'a <1\nb >=1\n', 1, 'a b\nclashes 1\n', ''),
  row(['pick', '--have', '1.0.0,1.0.1,1.0.2,1.0.3,1.0.4,1.0.5,1.0.6,1.0.7,1.0.8,1.0.9,1.0.10,1.0.11,1.0.12,1.0.13,1.0.14,1.0.15,1.0.16,1.0.17,1.0.18,1.0.19'], 'a ^1\n', 0, 'pick 1.0.19\n', ''),
  row(['pick', '--have', '9999.9999.9999,9999.9999.9998'], 'a *\n', 0, 'pick 9999.9999.9999\n', ''),
];

void main() => runRows(rows);
