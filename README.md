pdf_split_bookmark-pdftk
========================

This utility reads bookmarks using PDFTK, then splits based on a specified bookmark level.

You will need the pdftk binaries from Sid Steward (http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/).

Caveat: Bookmarks should start a new page.

Usage:

    pdf = PDF.new('foo.pdf')
    pdf.split_by_bookmark_at_level(2)

Optionally specify an output directory:

    pdf.split_by_bookmark_at_level(2, '/dev/null')
