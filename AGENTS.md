# Resolve upgrades and container rebuilds

Keep this process simple and limited to the user's request. The user has
explicitly rejected extra preservation and backup workflows for Resolve upgrades.

- Verify the latest official Resolve release and use Resolve's official installer
  upgrade flow. Let the installer manage the existing installation.
- Rebuild the container when requested, using this repository's existing setup.
  Make only the version, download ID, and compatibility changes needed for the
  requested upgrade and rebuild.
- Do not preserve, back up, copy forward, migrate, or restore plugins, add-ons,
  custom LUTs, or other custom installation components. They may not work across
  versions. Do not add a preservation step around the official installer.
- Do not create installation backups, container snapshots, project-library
  backups, or project exports unless explicitly requested.
- Do not open, save, duplicate, or edit projects or timelines as part of an
  application upgrade. Project-editing checkpoint workflows do not apply here.
- Do not add unrelated cleanup, refactoring, documentation, or configuration
  changes. If release changes are requested, summarize them in the reply unless
  the user asks to save them in a file.
- Verify the installed version and run the existing container checks for GPU
  access, audio, and dependencies. State the verification boundary; do not expand
  this into project or playback testing unless requested.
- Complete the authorized upgrade and rebuild without repeated permission
  questions. Ask only when a real blocker requires user input.

The default scope is: official upgrade, requested container rebuild, basic
verification, and a concise report. Additional work requires an explicit request.
