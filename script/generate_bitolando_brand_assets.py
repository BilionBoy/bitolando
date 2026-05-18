#!/usr/bin/env python3
from pathlib import Path
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
IMG_DIR = ROOT / "public" / "layout" / "assets" / "img"
FAVICON_DIR = IMG_DIR / "favicon_io"
SOURCE = IMG_DIR / "bitolando-symbol-transparent.png"

LIGHT_SYMBOL = IMG_DIR / "bitolando-symbol-light.png"
DARK_SYMBOL = IMG_DIR / "bitolando-symbol-dark.png"

FAVICON_SIZES = [16, 24, 32, 48, 64, 96, 128, 180, 192, 256, 512]


def replace_white_cursor_with_ink(img: Image.Image) -> Image.Image:
    """Mantém o âmbar e troca o cursor branco por grafite para uso no tema claro."""
    rgba = img.convert("RGBA")
    pixels = rgba.load()
    width, height = rgba.size

    for y in range(height):
        for x in range(width):
            r, g, b, a = pixels[x, y]
            if a == 0:
                continue

            # O cursor da marca é branco/quase branco. Em fundo claro ele some,
            # então a variante light usa grafite sem tocar no âmbar da órbita.
            if r > 205 and g > 205 and b > 190:
                # Preserva antialias/glow proporcionalmente na opacidade original.
                pixels[x, y] = (24, 24, 24, a)

    return rgba


def padded_square(img: Image.Image, size: int, padding_ratio: float = 0.11) -> Image.Image:
    """Centraliza o símbolo em canvas quadrado transparente para favicon/app icon."""
    rgba = img.convert("RGBA")
    bbox = rgba.getbbox()
    if not bbox:
        return Image.new("RGBA", (size, size), (0, 0, 0, 0))

    cropped = rgba.crop(bbox)
    padding = int(size * padding_ratio)
    target = size - (padding * 2)
    cropped.thumbnail((target, target), Image.Resampling.LANCZOS)

    canvas = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    x = (size - cropped.width) // 2
    y = (size - cropped.height) // 2
    canvas.alpha_composite(cropped, (x, y))
    return canvas


def main() -> None:
    if not SOURCE.exists():
        raise FileNotFoundError(f"Asset base não encontrado: {SOURCE}")

    source = Image.open(SOURCE).convert("RGBA")
    light = replace_white_cursor_with_ink(source)

    # Variante para header claro: cursor escuro, fundo transparente.
    light.save(LIGHT_SYMBOL)

    # Variante para header escuro: preserva a logo oficial transparente.
    source.save(DARK_SYMBOL)

    FAVICON_DIR.mkdir(parents=True, exist_ok=True)

    # Favicons usam a variante light para funcionar melhor na aba clara do navegador.
    for size in FAVICON_SIZES:
        icon = padded_square(light, size)
        icon.save(FAVICON_DIR / f"favicon-{size}.png")

    aliases = {
        "favicon-16x16.png": 16,
        "favicon-32x32.png": 32,
        "apple-touch-icon.png": 180,
        "android-chrome-192x192.png": 192,
        "android-chrome-512x512.png": 512,
    }
    for name, size in aliases.items():
        padded_square(light, size).save(FAVICON_DIR / name)

    ico_images = [padded_square(light, size) for size in (16, 24, 32, 48, 64)]
    ico_images[0].save(
        FAVICON_DIR / "favicon.ico",
        sizes=[(img.width, img.height) for img in ico_images],
        append_images=ico_images[1:],
    )

    manifest = """{\n  \"name\": \"bitolando\",\n  \"short_name\": \"bitolando\",\n  \"description\": \"caderno público de engenharia e arquitetura de software\",\n  \"start_url\": \"/\",\n  \"display\": \"standalone\",\n  \"theme_color\": \"#080808\",\n  \"background_color\": \"#080808\",\n  \"icons\": [\n    {\n      \"src\": \"/layout/assets/img/favicon_io/android-chrome-192x192.png\",\n      \"sizes\": \"192x192\",\n      \"type\": \"image/png\",\n      \"purpose\": \"any\"\n    },\n    {\n      \"src\": \"/layout/assets/img/favicon_io/android-chrome-512x512.png\",\n      \"sizes\": \"512x512\",\n      \"type\": \"image/png\",\n      \"purpose\": \"any\"\n    }\n  ]\n}\n"""
    (FAVICON_DIR / "site.webmanifest").write_text(manifest, encoding="utf-8")

    print(f"Gerado: {LIGHT_SYMBOL.relative_to(ROOT)}")
    print(f"Gerado: {DARK_SYMBOL.relative_to(ROOT)}")
    print(f"Favicons atualizados em: {FAVICON_DIR.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
