#!/usr/bin/env texlua
-- Build configuration for framecite (l3build)
--   l3build unpack   -> runs framecite.ins, generates framecite.sty
--   l3build doc      -> typesets framecite.dtx to framecite.pdf
--   l3build ctan     -> builds the CTAN upload zip

module = "framecite"

sourcefiles  = {"framecite.dtx", "framecite.ins"}
installfiles = {"framecite.sty"}
typesetfiles = {"framecite.dtx"}
typesetdemofiles = {"framecite_demo.tex"}

-- The ins writes the generated demo to the unpack directory (build/
-- unpacked), but l3build collects typesetdemofiles from the main
-- directory. Copy it into the typesetting sandbox so the demo builds
-- even in a clean checkout where no demo .tex sits in the main dir.
function docinit_hook()
  cp("framecite_demo.tex", unpackdir, typesetdir)
  return 0
end

-- The demo embeds its bibliography via filecontents: no .bib ships.
-- The default {"*.bib"} glob would only sweep stale artifacts from
-- manual in-place builds into the upload.
bibfiles = { }

-- Only the demo PDF goes into the upload: the demo .tex (like the
-- generated .sty) is a docstrip-derived file. Keep the default
-- excludes and pin down the demo artifacts so the archive contents
-- do not depend on what happens to sit in the main directory.
excludefiles = {"*~", "build.lua", "config-*.lua",
                "framecite_demo.tex", "framecite_demo.bib"}

uploadconfig = {
  pkg       = "framecite",
  version   = "0.7",
  author    = "Hirnmoder",
  repository = "https://github.com/Hirnmoder/framecite",
  bugtracker = {"https://github.com/Hirnmoder/framecite/issues"},
  license   = "lppl1.3c",
  summary   = "Per-frame mini references for beamer + biblatex",
  description = [[framecite lists, on each beamer slide where a
short-form citation appears, the source as a small block at the bottom
of that slide: the citation label, the author (or editor), and the
quoted title. The block sits between real LaTeX footnotes and the
theme footline, decoupled from \footnote via a blank mark and its own
beamer font/color element. Collection is automatic from the standard
cite commands, with optional manual registration (\fcite, \fsource).]],
  ctanPath  = "/macros/latex/contrib/framecite",
  uploader  = "Hirnmoder",
}
