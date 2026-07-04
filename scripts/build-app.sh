#!/usr/bin/env bash
# Builds MacClockWidget as a release binary and wraps it into a proper macOS
# .app bundle at ./build/MacClockWidget.app, ad-hoc code-signed so macOS will
# launch it without a quarantine prompt on the local machine.
#
# Usage:
#   ./scripts/build-app.sh            # build, bundle, ad-hoc sign
#   ./scripts/build-app.sh install    # also copy the .app to /Applications and launch it
#   ./scripts/build-app.sh run        # also launch the local .app
#
# Requirements: Xcode Command Line Tools (swift, codesign).

set -euo pipefail

APP_NAME="MacClockWidget"
BUNDLE_ID="com.cktools.macclockwidget"
BUILD_DIR="build"
APP_BUNDLE="${BUILD_DIR}/${APP_NAME}.app"
CONTENTS_DIR="${APP_BUNDLE}/Contents"
MACOS_DIR="${CONTENTS_DIR}/MacOS"
RESOURCES_DIR="${CONTENTS_DIR}/Resources"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${PROJECT_DIR}"

case "${1:-}" in
    install)
        INSTALL=true
        RUN=true
        ;;
    run)
        INSTALL=false
        RUN=true
        ;;
    *)
        INSTALL=false
        RUN=false
        ;;
esac

echo "==> Building ${APP_NAME} (release, arch=$(uname -m))…"
swift build -c release

BIN_PATH="$(swift build -c release --show-bin-path)/${APP_NAME}"
if [[ ! -x "${BIN_PATH}" ]]; then
    echo "Error: built binary not found at ${BIN_PATH}" >&2
    exit 1
fi

echo "==> Assembling ${APP_BUNDLE}…"
rm -rf "${APP_BUNDLE}"
mkdir -p "${MACOS_DIR}" "${RESOURCES_DIR}"
cp "${BIN_PATH}" "${MACOS_DIR}/${APP_NAME}"
cp "Resources/Info.plist" "${CONTENTS_DIR}/Info.plist"

echo "==> Ad-hoc code-signing…"
codesign --force --deep --sign - --identifier "${BUNDLE_ID}" "${APP_BUNDLE}"
codesign --verify --verbose "${APP_BUNDLE}" >/dev/null

echo "==> Done: ${APP_BUNDLE}"

if [[ "${INSTALL}" == "true" ]]; then
    DEST="/Applications/${APP_NAME}.app"
    echo "==> Closing any running instance and installing to ${DEST}…"
    pkill -x "${APP_NAME}" 2>/dev/null || true
    sleep 0.5
    rm -rf "${DEST}"
    cp -R "${APP_BUNDLE}" "${DEST}"
    echo "Installed: ${DEST}"
fi

if [[ "${RUN}" == "true" ]]; then
    echo "==> Launching ${APP_BUNDLE}…"
    pkill -x "${APP_NAME}" 2>/dev/null || true
    sleep 0.5
    open "${APP_BUNDLE}"
fi
