# Resolve 21.2 update

The setup target moves from **21.1.2 build 10** to **21.2 build 5** for both
Studio and Free. Blackmagic's release notes are dated November 4, 2026; the
Linux release metadata was checked on November 5, 2026.

## Resolve changes

- Adds Blackmagic Gen 6 LUTs and Gen 5/6 support in ResolveFX False Color.
- Retains source timecode when extracting audio; fixes AAF audio timecode for
  interlaced sources, some missing AAF clips, and iXML WAV channel ordering.
- Improves multicam/source timeline handling, edit-point selection, compound
  clip creation, and conform locking multiple clips to one media-pool clip.
- Expands AI assistant color/Fusion operations, frame exports, thumbnail grids,
  and optional feature downloads, alongside scripting API improvements.
- Fixes network MXF audio issues, slow MP3 exports, OGraf loading/rendering and
  memory problems, and intermittent offline frames with some H.265 media.
- Fixes ACES 2.0 artifacts on Linux and Windows, plus several Fusion/Text+,
  subtitle, audio preference, and render issues.
- Adds Apple PROLED XDR display support and Apple-specific rendering gains;
  those platform changes do not apply to this Linux container.

## Container changes

- Pins the official Linux Studio and Free download IDs to 21.2 build 5.
- Selects the 21.2 installer filenames through the updated setup target.
- Keeps Fedora 39, existing isolated state paths, and the GPU configuration.
  Blackmagic's Linux GPU/driver requirements are unchanged from the previous
  target, including NVIDIA 580.119.02 or newer.

Sources: [official release notes](https://www.blackmagicdesign.com/support/readme/630fd2cb208a46df9493de661a76628a)
and [official download metadata](https://www.blackmagicdesign.com/api/support/us/downloads.json).
