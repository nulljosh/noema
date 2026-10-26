import json
from pathlib import Path
import unittest
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]


def luminance(hex_color):
    values = [int(hex_color[i:i+2], 16)/255 for i in (1,3,5)]
    linear = [v/12.92 if v <= .04045 else ((v+.055)/1.055)**2.4 for v in values]
    return sum(a*b for a,b in zip(linear,(.2126,.7152,.0722)))


class BrandTests(unittest.TestCase):
    def test_text_contrast(self):
        c = json.loads((ROOT/'design/tokens.json').read_text())['colors']
        for foreground,background in [('navy','white'),('blue','white'),('white','blue'),
                                     ('white','navy'),('navy','aqua'),('silver','navy'),('maroon','white')]:
            a,b = sorted([luminance(c[foreground]),luminance(c[background])])
            with self.subTest(pair=(foreground,background)):
                self.assertGreaterEqual((b+.05)/(a+.05), 4.5)

    def test_svg_assets_and_token_exports(self):
        for svg in (ROOT/'landing/brand').glob('*.svg'):
            tree = ET.parse(svg)
            self.assertTrue(tree.getroot().tag.endswith('svg'))
        self.assertEqual((ROOT/'design/tokens.json').read_bytes(),
                         (ROOT/'landing/brand/tokens.json').read_bytes())
        self.assertEqual((ROOT/'landing/design-system.css').read_bytes(),
                         (ROOT/'landing/brand/design-system.css').read_bytes())
