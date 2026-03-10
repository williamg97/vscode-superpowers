#!/usr/bin/env bash
set -euo pipefail

# Bisection script to find which test creates unwanted files/state
# Usage: ./find-polluter.sh <artifact-to-watch> <test-glob>
# Example: ./find-polluter.sh '.git' 'src/**/*.test.ts'

ARTIFACT="${1:?Usage: $0 <artifact-to-watch> <test-glob>}"
TEST_GLOB="${2:?Usage: $0 <artifact-to-watch> <test-glob>}"

echo "Looking for test that creates: $ARTIFACT"
echo "Test pattern: $TEST_GLOB"
echo ""

# Find all test files matching the glob
mapfile -t TEST_FILES < <(find . -path "./$TEST_GLOB" -type f 2>/dev/null | sort)
TOTAL=${#TEST_FILES[@]}

if [ "$TOTAL" -eq 0 ]; then
    echo "No test files found matching: $TEST_GLOB"
    exit 1
fi

echo "Found $TOTAL test files to check"
echo ""

for i in "${!TEST_FILES[@]}"; do
    file="${TEST_FILES[$i]}"
    num=$((i + 1))

    # Skip if artifact already exists
    if [ -e "$ARTIFACT" ]; then
        echo "WARNING: $ARTIFACT already exists before test $num. Clean up first."
        exit 1
    fi

    echo "[$num/$TOTAL] Running: $file"
    npx jest "$file" --silent 2>/dev/null || true

    if [ -e "$ARTIFACT" ]; then
        echo ""
        echo "FOUND IT! Test $num creates $ARTIFACT"
        echo "  File: $file"
        echo ""
        echo "Artifact details:"
        ls -la "$ARTIFACT" 2>/dev/null || true
        echo ""
        echo "Next steps:"
        echo "  1. Run this test in isolation to confirm"
        echo "  2. Check test setup/teardown for missing cleanup"
        echo "  3. Look for operations that create $ARTIFACT as side effect"
        exit 0
    fi
done

echo ""
echo "No polluter found. None of the $TOTAL tests created $ARTIFACT."
