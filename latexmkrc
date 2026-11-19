# framecite: doc.sty writes .idx entries in the gind.ist dialect
# (actual '=', level '!', quote '+'). Plain makeindex mis-parses
# them, so index with the doc companion style file (gind.ist,
# generated from doc.dtx and shipped with TeX Live).
$makeindex = 'makeindex %O -s gind.ist -o %D %B';
