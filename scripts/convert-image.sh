#!/usr/bin/env bash

# Image conversion script for responsive web images
# Converts a source image to multiple formats and resolutions for <picture> elements
# 
# Usage: ./scripts/convert-image.sh <input_image> [output_prefix] [base_size]
# 
# Arguments:
#   input_image    - Source image file (PNG, JPG, etc.)
#   output_prefix  - Output filename prefix (default: avatar)
#   base_size      - Base size in pixels for 1x version (default: 150)
#
# Example: ./scripts/convert-image.sh source.png avatar 150
# 
# Generates files in public/img/:
#   - avatar1x.{webp,jp2,jpg,png}
#   - avatar1.5x.{webp,jp2,jpg}
#   - avatar2x.{webp,jp2,jpg}
#   - avatar3x.{webp,jp2,jpg}

set -e  # Exit on any error

# Check if ImageMagick is installed
if ! command -v magick &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it first:"
    echo "  macOS: brew install imagemagick"
    echo "  Ubuntu/Debian: sudo apt-get install imagemagick"
    echo "  CentOS/RHEL: sudo yum install ImageMagick"
    exit 1
fi

# Parse arguments
INPUT_IMAGE="$1"
OUTPUT_PREFIX="${2:-avatar}"
BASE_SIZE="${3:-150}"

# Validate input
if [ -z "$INPUT_IMAGE" ]; then
    echo "Usage: $0 <input_image> [output_prefix] [base_size]"
    echo "Example: $0 source.png avatar 150"
    exit 1
fi

if [ ! -f "$INPUT_IMAGE" ]; then
    echo "Error: Input file '$INPUT_IMAGE' does not exist"
    exit 1
fi

# Create output directory if it doesn't exist
OUTPUT_DIR="public/img"
mkdir -p "$OUTPUT_DIR"

echo "Converting '$INPUT_IMAGE' to multiple formats and sizes..."
echo "Output prefix: $OUTPUT_PREFIX"
echo "Base size: ${BASE_SIZE}px"
echo "Output directory: $OUTPUT_DIR"
echo ""

# Calculate sizes
SIZE_1X="$BASE_SIZE"
SIZE_1_5X="$((BASE_SIZE * 3 / 2))"
SIZE_2X="$((BASE_SIZE * 2))"
SIZE_3X="$((BASE_SIZE * 3))"

# Special case: PNG only for 1x version (typically the source/fallback)
echo "Creating PNG version..."
magick "$INPUT_IMAGE" -resize "${SIZE_1X}x${SIZE_1X}" "$OUTPUT_DIR/${OUTPUT_PREFIX}1x.png"
echo "✓ Created: ${OUTPUT_PREFIX}1x.png (${SIZE_1X}x${SIZE_1X})"

# Generate all formats for all sizes
echo ""
echo "Processing 1x (${SIZE_1X}x${SIZE_1X})..."
magick "$INPUT_IMAGE" -resize "${SIZE_1X}x${SIZE_1X}" -quality 85 "$OUTPUT_DIR/${OUTPUT_PREFIX}1x.webp"
magick "$INPUT_IMAGE" -resize "${SIZE_1X}x${SIZE_1X}" -quality 85 "$OUTPUT_DIR/${OUTPUT_PREFIX}1x.jp2"
magick "$INPUT_IMAGE" -resize "${SIZE_1X}x${SIZE_1X}" -quality 90 -strip "$OUTPUT_DIR/${OUTPUT_PREFIX}1x.jpg"
echo "✓ Created: ${OUTPUT_PREFIX}1x.webp"
echo "✓ Created: ${OUTPUT_PREFIX}1x.jp2"
echo "✓ Created: ${OUTPUT_PREFIX}1x.jpg"

echo ""
echo "Processing 1.5x (${SIZE_1_5X}x${SIZE_1_5X})..."
magick "$INPUT_IMAGE" -resize "${SIZE_1_5X}x${SIZE_1_5X}" -quality 85 "$OUTPUT_DIR/${OUTPUT_PREFIX}1_5x.webp"
magick "$INPUT_IMAGE" -resize "${SIZE_1_5X}x${SIZE_1_5X}" -quality 85 "$OUTPUT_DIR/${OUTPUT_PREFIX}1_5x.jp2"
magick "$INPUT_IMAGE" -resize "${SIZE_1_5X}x${SIZE_1_5X}" -quality 90 -strip "$OUTPUT_DIR/${OUTPUT_PREFIX}1_5x.jpg"
echo "✓ Created: ${OUTPUT_PREFIX}1_5x.webp"
echo "✓ Created: ${OUTPUT_PREFIX}1_5x.jp2"
echo "✓ Created: ${OUTPUT_PREFIX}1_5x.jpg"

echo ""
echo "Processing 2x (${SIZE_2X}x${SIZE_2X})..."
magick "$INPUT_IMAGE" -resize "${SIZE_2X}x${SIZE_2X}" -quality 85 "$OUTPUT_DIR/${OUTPUT_PREFIX}2x.webp"
magick "$INPUT_IMAGE" -resize "${SIZE_2X}x${SIZE_2X}" -quality 85 "$OUTPUT_DIR/${OUTPUT_PREFIX}2x.jp2"
magick "$INPUT_IMAGE" -resize "${SIZE_2X}x${SIZE_2X}" -quality 90 -strip "$OUTPUT_DIR/${OUTPUT_PREFIX}2x.jpg"
echo "✓ Created: ${OUTPUT_PREFIX}2x.webp"
echo "✓ Created: ${OUTPUT_PREFIX}2x.jp2"
echo "✓ Created: ${OUTPUT_PREFIX}2x.jpg"

echo ""
echo "Processing 3x (${SIZE_3X}x${SIZE_3X})..."
magick "$INPUT_IMAGE" -resize "${SIZE_3X}x${SIZE_3X}" -quality 85 "$OUTPUT_DIR/${OUTPUT_PREFIX}3x.webp"
magick "$INPUT_IMAGE" -resize "${SIZE_3X}x${SIZE_3X}" -quality 85 "$OUTPUT_DIR/${OUTPUT_PREFIX}3x.jp2"
magick "$INPUT_IMAGE" -resize "${SIZE_3X}x${SIZE_3X}" -quality 90 -strip "$OUTPUT_DIR/${OUTPUT_PREFIX}3x.jpg"
echo "✓ Created: ${OUTPUT_PREFIX}3x.webp"
echo "✓ Created: ${OUTPUT_PREFIX}3x.jp2"
echo "✓ Created: ${OUTPUT_PREFIX}3x.jpg"

echo ""
echo "✅ Image conversion complete!"
echo ""
echo "Generated files in $OUTPUT_DIR/:"
ls -la "$OUTPUT_DIR/${OUTPUT_PREFIX}"*

echo ""
echo "You can now use this HTML in your templates:"
echo ""
echo "<picture>"
echo "  <source type=\"image/webp\" srcset=\"/img/${OUTPUT_PREFIX}1x.webp 1x, /img/${OUTPUT_PREFIX}1_5x.webp 1.5x, /img/${OUTPUT_PREFIX}2x.webp 2x, /img/${OUTPUT_PREFIX}3x.webp 3x\">"
echo "  <source type=\"image/jp2\" srcset=\"/img/${OUTPUT_PREFIX}1x.jp2 1x, /img/${OUTPUT_PREFIX}1_5x.jp2 1.5x, /img/${OUTPUT_PREFIX}2x.jp2 2x, /img/${OUTPUT_PREFIX}3x.jp2 3x\">"
echo "  <source type=\"image/jpeg\" srcset=\"/img/${OUTPUT_PREFIX}1x.jpg 1x, /img/${OUTPUT_PREFIX}1_5x.jpg 1.5x, /img/${OUTPUT_PREFIX}2x.jpg 2x, /img/${OUTPUT_PREFIX}3x.jpg 3x\">"
echo "  <img src=\"/img/${OUTPUT_PREFIX}1x.jpg\" alt=\"Description\" style=\"width: ${BASE_SIZE}px; height: ${BASE_SIZE}px;\">"
echo "</picture>"