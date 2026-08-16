#!/usr/bin/env bash

set -euo pipefail

# Winboat (https://github.com/TibixDev/winboat) ships only as an *unsigned*
# GitHub-release RPM with no upstream checksum, so we pin an exact version and
# verify a SHA-256 we vetted at pin time before installing. There is no BlueBuild
# module for arbitrary GitHub-release RPMs, hence this script.
#
# To update: bump WINBOAT_VERSION, download the new RPM, `sha256sum` it, and put
# the result in WINBOAT_SHA256.
WINBOAT_VERSION="0.9.0"
WINBOAT_SHA256="64338d6d61faf761a441fc59d3129aa346ce65905e12af329a08dff40308f5f7"

WINBOAT_URL="https://github.com/TibixDev/winboat/releases/download/v${WINBOAT_VERSION}/winboat-${WINBOAT_VERSION}-x86_64.rpm"
TEMP_FILE="/tmp/winboat.rpm"

echo "=== Installing Winboat ${WINBOAT_VERSION} ==="
echo "URL: ${WINBOAT_URL}"
curl --location --fail --retry 3 --output "${TEMP_FILE}" "${WINBOAT_URL}"

echo "Verifying SHA-256..."
echo "${WINBOAT_SHA256}  ${TEMP_FILE}" | sha256sum --check --strict

dnf install -y "${TEMP_FILE}"
rm -f "${TEMP_FILE}"

# No manual optfix needed: the BlueBuild CLI symlinks /opt -> /usr/lib/opt for
# the whole build (pre_build.sh) and auto-generates the runtime tmpfiles symlink
# for every /opt subdir afterwards (post_build.sh). Winboat installs to
# /opt/winboat and is persisted + symlinked automatically, exactly like 1Password.

echo "=== Winboat installation complete ==="
