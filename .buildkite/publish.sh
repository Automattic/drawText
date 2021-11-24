#!/bin/bash -eu

swift build -c release --arch arm64 --arch x86_64
BUILDDIR=.build/artifacts/release
mkdir -p $BUILDDIR

cp .build/apple/Products/Release/drawText $BUILDDIR/drawText
tar -czf drawText.tar.gz -C $BUILDDIR .
mv drawText.tar.gz .build/artifacts/drawText.tar.gz

CHECKSUM=$(openssl sha256 .build/artifacts/drawText.tar.gz | awk '{print $2}')

echo "Build complete: .build/artifacts/drawText.tar.gz"
echo "  Checksum: $CHECKSUM"

gh auth status
gh release create $BUILDKITE_TAG --title $BUILDKITE_TAG --notes "Checksum: $CHECKSUM" .build/artifacts/drawText.tar.gz
