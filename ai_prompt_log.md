# AI prompt log — CreativeChronicle

## 1. CSS Grid mosaic

**Prompt:** How can `grid-template-areas` create a gallery with one large image on the left and two stacked images on the right, then become one column on mobile?

**Summary:** Name three areas (`main`, `detail`, `tools`). Let `main` occupy both grid rows; place `detail` and `tools` in the right column. At the mobile breakpoint, switch to a single column and place each area on its own row. Use `object-fit: cover` to fill image frames without stretching the photos.

## 2. Bootstrap spacing and alignment

**Prompt:** Which Bootstrap utilities help align an author avatar and metadata vertically, keep share buttons on the same row, and add consistent spacing?

**Summary:** Use `d-flex`, `align-items-center`, `justify-content-between`, `flex-wrap`, and `gap-3`. Keep the author identity as a nested flex group. Wrapping allows the share controls to move below the author details on narrow screens.

## 3. Responsive article cards

**Prompt:** Which Bootstrap grid classes produce four cards at large widths, two on tablet, and one on mobile?

**Summary:** Place cards in `.row.g-4`; give each card column `col-12 col-md-6 col-lg-3`. Bootstrap's breakpoints handle the column changes without percentage widths or floats.
