"""Draws Ragebound's textures into Media/ (TGA, power-of-two sizes).

Run from the addon folder:  python3 tools/make_media.py
Card textures are white with alpha so the game can tint them (the rivets keep their own colors,
since the game does not tint corner studs); the emblem comes from the painted art.
"""
import random
from PIL import Image, ImageChops, ImageDraw, ImageFilter


OUT = "Media/"
ART = "Ragebound.png"  # painted by Marius: the logo, icon and crest are made from it


def smoke(size=128, seed=7):
    """Rising smoke with a few bright embers in it, tileable, white on alpha."""
    rnd = random.Random(seed)
    img = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(img)
    for _ in range(36):
        x, y = rnd.randrange(size), rnd.randrange(size)
        rx, ry = rnd.randint(6, 14), rnd.randint(14, 30)  # taller than wide: smoke goes up
        v = rnd.randint(25, 65)
        for dx in (-size, 0, size):
            for dy in (-size, 0, size):
                d.ellipse([x + dx - rx, y + dy - ry, x + dx + rx, y + dy + ry], fill=v)
    img = img.filter(ImageFilter.GaussianBlur(7))
    sparks = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(sparks)
    for _ in range(14):
        x, y = rnd.randrange(2, size - 2), rnd.randrange(2, size - 2)
        r = rnd.choice((0.8, 1.0, 1.4))
        d.ellipse([x - r, y - r, x + r, y + r], fill=rnd.randint(150, 230))
    sparks = sparks.filter(ImageFilter.GaussianBlur(0.6))
    img = ImageChops.lighter(img, sparks)
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(img)
    return out


def rivet(size=32):
    """A dark iron rivet head, lit from the top left (in color: the game draws studs untinted)."""
    s = size * 4
    img = Image.new("RGBA", (s, s), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    c, r = s / 2, s * 0.36
    d.ellipse([c - r - s * 0.05, c - r - s * 0.05, c + r + s * 0.05, c + r + s * 0.05], fill=(10, 6, 5, 200))
    steps = 24
    for k in range(steps):
        t = k / steps
        rr = r * (1 - t)
        ox, oy = -r * 0.35 * t, -r * 0.35 * t  # the highlight drifts to the top left
        v = int(60 + 130 * t)
        d.ellipse([c + ox - rr, c + oy - rr, c + ox + rr, c + oy + rr], fill=(v, int(v * 0.80), int(v * 0.70), 255))
    img = img.filter(ImageFilter.GaussianBlur(s * 0.01)).resize((size, size), Image.LANCZOS)
    return img


def rim(size=64, width=5):
    img = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(img)
    for i in range(width * 2):
        v = int(255 * (1 - i / (width * 2)) ** 2)
        d.rectangle([i, i, size - 1 - i, size - 1 - i], outline=v)
    img = img.filter(ImageFilter.GaussianBlur(1.2))
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(img)
    return out


def emblem(size=256, art=ART):
    """The emblem, from the painted art in Ragebound.png (also the CurseForge project picture)."""
    return Image.open(art).convert("RGBA").resize((size, size), Image.LANCZOS)


def crest(size=256, art=ART):
    """The card crest: the same art as a white shape for the game to tint, its light parts
    brighter, so the faint motif behind the cards matches the icon."""
    art = emblem(size, art)
    lum = art.convert("L").point([int(70 + v * 185 / 255) for v in range(256)])
    alpha = ImageChops.multiply(art.getchannel("A"), lum)
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(alpha)
    return out


def icon(size, art=ART):
    """The emblem on a dark iron-red gradient (the minimap and addon list icon)."""
    bg = Image.new("RGBA", (size, size), (0, 0, 0, 255))
    d = ImageDraw.Draw(bg)
    for y in range(size):
        t = y / size
        d.line([(0, y), (size, y)], fill=(int(22 + 30 * (1 - t)), int(12 + 10 * (1 - t)), int(10 + 8 * (1 - t)), 255))
    e = emblem(size * 2, art).resize((size, size), Image.LANCZOS)
    return Image.alpha_composite(bg, e)


def save(img, name):
    img.save(OUT + name + ".tga")
    print("wrote", OUT + name + ".tga", img.size)


if __name__ == "__main__":
    save(smoke(), "Smoke")
    save(rivet(), "Rivet")
    save(crest(), "Crest")
    save(rim(), "Rim")
    save(emblem(256), "Logo256")
    save(emblem(64), "Logo64")
    save(icon(64), "Icon64")
    save(icon(128), "Icon128")
