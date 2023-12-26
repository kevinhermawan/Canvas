#!/bin/bash

# Check if the correct number of arguments were provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <dmg_path> <notary_profile>"
    exit 1
fi

# Assign the arguments to variables
DMG_PATH="$1"
NOTARY_PROFILE="$2"

# Notarize the DMG
xcrun notarytool submit "$DMG_PATH" \
  --keychain-profile "$NOTARY_PROFILE" \
  --wait

# Check the status of the notarization
xcrun notarytool history --keychain-profile "$NOTARY_PROFILE"
