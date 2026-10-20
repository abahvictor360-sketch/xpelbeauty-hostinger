"""Build the catalogue's product thumbnails: public/Img/thumbs/<name>.webp

For every product image in the database:
  * photos on a solid/studio background get the background removed (rembg),
    so the pack sits cleanly on the catalogue's colour bands
  * toothpaste boxes photographed lying flat are stood upright
  * trimmed to the product and saved as a 380px WebP (keeps transparency)

The catalogue loads these and falls back to the full image when a thumbnail
is missing, so new products still show before this script is re-run.

Usage:  python scripts/catalogue-thumbs.py [--force] [--only name1,name2]
Needs:  pip install pillow "rembg[cpu]"
"""
import json
import os
import sys
import urllib.request

from PIL import Image, ImageOps

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
IMG_DIR = os.path.join(ROOT, 'public', 'Img')
OUT_DIR = os.path.join(IMG_DIR, 'thumbs')
SUPABASE_URL = 'https://pogtqhnnhrbeundifxet.supabase.co'
ANON_KEY = ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBvZ3RxaG5uaHJiZXVuZGlmeGV0Iiwicm9sZSI6ImFub24i'
            'LCJpYXQiOjE3OTI0ODEzMjQsImV4cCI6MjEwODA1NzMyNH0.vB-wskf0k6EUfze89jAlEzBMRJiYqGNqNy7MoFq9gt4')
MAX_SIDE = 380

# Images where automatic cut-out fails (pack too close to its background):
# build the thumbnail from a clean, already-transparent picture instead.
THUMB_SOURCE = {
    'tea-tree-peppermint-hand-pack': '40050_HERO-removebg-preview.png',
}


def products():
    req = urllib.request.Request(f'{SUPABASE_URL}/rest/v1/products?select=id,name,image&order=id',
                                 headers={'apikey': ANON_KEY, 'Range': '0-9999'})
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.load(r)


def has_transparent_edges(im):
    """True when the image already is a cut-out (transparent around the edges)."""
    if im.mode != 'RGBA':
        return False
    a = im.getchannel('A')
    w, h = a.size
    edge = [a.getpixel((x, y)) for x in range(0, w, max(1, w // 40)) for y in (0, h - 1)]
    edge += [a.getpixel((x, y)) for y in range(0, h, max(1, h // 40)) for x in (0, w - 1)]
    return sum(1 for v in edge if v < 20) > len(edge) * 0.6


def clean_mask(alpha):
    """Tidy rembg's mask: fill holes fully enclosed by the product (white
    labels it mistook for background) and drop small stray fragments such as
    reflections, keeping every piece at least 12% the size of the largest."""
    import numpy as np
    from scipy import ndimage
    m = np.array(alpha) > 24
    m = ndimage.binary_fill_holes(m)
    labels, n = ndimage.label(m)
    if n > 1:
        sizes = ndimage.sum(m, labels, range(1, n + 1))
        keep = [i + 1 for i, s in enumerate(sizes) if s >= sizes.max() * 0.12]
        m = np.isin(labels, keep)
    soft = np.where(m, np.maximum(np.array(alpha), 255 * ndimage.binary_erosion(m, iterations=2)), 0)
    return Image.fromarray(soft.astype('uint8'), 'L')


def main():
    force = '--force' in sys.argv
    only = None
    if '--only' in sys.argv:
        only = set(sys.argv[sys.argv.index('--only') + 1].split(','))
    os.makedirs(OUT_DIR, exist_ok=True)

    from rembg import new_session, remove
    session = new_session('isnet-general-use')

    seen = {}
    for p in products():
        img = (p.get('image') or '').strip()
        if not img.startswith('/Img/') or img.startswith('/Img/thumbs/'):
            continue
        name = os.path.basename(img)
        is_toothpaste = 'toothpaste' in p['name'].lower()
        key = (name, is_toothpaste)
        if key in seen:
            continue
        seen[key] = True
        base = os.path.splitext(name)[0]
        if only and base not in only and name not in only:
            continue
        src = os.path.join(IMG_DIR, THUMB_SOURCE.get(base, name))
        dst = os.path.join(OUT_DIR, base + '.webp')
        if not os.path.exists(src):
            print('missing', name)
            continue
        if os.path.exists(dst) and not force:
            continue

        im = ImageOps.exif_transpose(Image.open(src))
        im = im.convert('RGBA')
        im.thumbnail((1400, 1400))          # work size: fast, still sharp at 500px
        if not has_transparent_edges(im):
            cut = remove(im, session=session, post_process_mask=True)
            im.putalpha(clean_mask(cut.getchannel('A')))   # original pixels, cleaned mask
        else:
            im.putalpha(clean_mask(im.getchannel('A')))    # existing cut-outs: drop stray bits too
        bbox = im.getchannel('A').point(lambda v: 255 if v > 24 else 0).getbbox()
        if bbox:
            im = im.crop(bbox)
        if is_toothpaste and im.width > im.height * 1.25:
            im = im.rotate(90, expand=True)  # stand the box up, label reading bottom-to-top
        im.thumbnail((MAX_SIDE, MAX_SIDE))
        im.save(dst, 'WEBP', quality=82, method=4)
        print('ok', base, im.size, 'rotated' if is_toothpaste and im.height > im.width else '')


if __name__ == '__main__':
    main()
