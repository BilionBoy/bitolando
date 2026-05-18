#!/usr/bin/env python3
from pathlib import Path
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
required_files = [
    "public/layout/assets/img/bitolando-symbol-light.png",
    "public/layout/assets/img/bitolando-symbol-dark.png",
    "public/layout/assets/img/favicon_io/favicon.ico",
    "public/layout/assets/img/favicon_io/favicon-16x16.png",
    "public/layout/assets/img/favicon_io/favicon-32x32.png",
    "public/layout/assets/img/favicon_io/apple-touch-icon.png",
    "public/layout/assets/img/favicon_io/android-chrome-192x192.png",
    "public/layout/assets/img/favicon_io/android-chrome-512x512.png",
]

errors = []
for relative in required_files:
    path = ROOT / relative
    if not path.exists():
        errors.append(f"arquivo ausente: {relative}")
        continue

    image = Image.open(path).convert("RGBA")
    alpha_values = image.getchannel("A").getextrema()
    if alpha_values[0] == 255:
        errors.append(f"sem transparência detectada: {relative}")

header = (ROOT / "app/views/shared/_header.html.erb").read_text(encoding="utf-8")
for snippet in [
    "bitolando-symbol-light.png",
    "bitolando-symbol-dark.png",
    "bito-logo-text",
]:
    if snippet not in header:
        errors.append(f"header sem referência esperada: {snippet}")

css = (ROOT / "app/assets/stylesheets/bitolando.css").read_text(encoding="utf-8")
for snippet in [
    ".bito-logo-img-dark { display: none; }",
    '[data-theme="dark"] .bito-logo-img-dark { display: block; }',
    '[data-theme="dark"] .bito-logo-img-light { display: none; }',
]:
    if snippet not in css:
        errors.append(f"css sem regra esperada: {snippet}")

if errors:
    print("Falhou:")
    for error in errors:
        print(f"- {error}")
    raise SystemExit(1)

print("OK: header, alternância de tema e favicons transparentes validados.")
