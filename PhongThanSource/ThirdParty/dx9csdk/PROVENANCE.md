# DirectX 9 SDK provenance

This directory is a source-controlled copy of the DirectX 9 compatibility SDK
that the Phong Than VC6 renderer already used before the source migration.

- Imported on: 2026-08-31
- Imported from: `D:\Lam game phong than\DEV AG v1\SOURCE_thien dieu 2024\SOURCE_thien dieu fix_data\dx9csdk`
- Destination: `ThirdParty\dx9csdk`
- Scope copied: `Include`, `Lib`, and the original `GameRes Readme.txt`
- Purpose: build `Represent3` without resolving headers or libraries from the
  old `SwordOnline` source tree or from an untracked machine-wide SDK.

`SHA256SUMS.txt` records the SHA-256 hash of every imported file. Regenerate it
whenever the vendored SDK is intentionally replaced, and review that change as
a dependency upgrade.
