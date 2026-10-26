# Cut Duerer's Melencolia I (1514, public domain) into dot masks: ink becomes opaque dots.
import sys
from PIL import Image, ImageOps
src, out = sys.argv[1], sys.argv[2]
im = Image.open(src).convert("L")
k = im.width / 786  # crop boxes are in preview pixels
CROPS = {  # name: (box in preview px, output width)
    "band": ((0, 0, 786, 414), 1600),
    "square": ((588, 132, 738, 272), 600),
    "scales": ((400, 140, 500, 300), 600),
    "solid": ((15, 320, 305, 610), 600),
    "hourglass": ((490, 50, 590, 250), 600),
    "face": ((440, 220, 760, 540), 900),
}
for name, (box, w) in CROPS.items():
    c = im.crop(tuple(round(v * k) for v in box))
    c = c.resize((w, round(w * c.height / c.width)), Image.LANCZOS)
    ink = ImageOps.invert(ImageOps.autocontrast(c, cutoff=1)).convert("1")  # Floyd-Steinberg dots
    a = Image.new("LA", ink.size, 255); a.putalpha(ink.convert("L"))
    a.save(f"{out}/{name}.png", optimize=True)
    print(name, a.size)
