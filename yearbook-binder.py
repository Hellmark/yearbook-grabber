#!/usr/bin/env python3
import sys
import glob
import os
from PIL import Image

input_dir = sys.argv[1] if len(sys.argv) > 1 else "downloaded"
output_pdf = sys.argv[2] if len(sys.argv) > 2 else "yearbook.pdf"

images = sorted(glob.glob(os.path.join(input_dir, "*.jpg")))

if not images:
    print(f"No JPG images found in {input_dir}", file=sys.stderr)
    sys.exit(1)

print(f"Found {len(images)} images, building {output_pdf}...")

pages = [Image.open(p).convert("RGB") for p in images]
title = sys.argv[3] if len(sys.argv) > 3 else ""
author = sys.argv[4] if len(sys.argv) > 4 else ""
pages[0].save(output_pdf, save_all=True, append_images=pages[1:], title=title, author=author)
print("Done.")
