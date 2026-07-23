#!/usr/bin/env python3
"""Fix all remaining encoding corruption:
- ¡ú -> → (arrow)
- ¡ª -> — (em-dash)
- ¡ªC -> — (em-dash, some files have extra C)
"""

import os

REPO = r"D:\kakobuylinki"

replacements = [
    ("¡ªC", "—"),   # Must come before ¡ª to avoid partial replacement
    ("¡ú", "→"),
    ("¡ª", "—"),
]

def fix_file(fpath):
    try:
        with open(fpath, "r", encoding="utf-8") as f:
            content = f.read()
    except UnicodeDecodeError:
        try:
            with open(fpath, "r", encoding="latin-1") as f:
                content = f.read()
        except:
            return False

    original = content
    for old, new in replacements:
        content = content.replace(old, new)

    if content == original:
        return False

    with open(fpath, "w", encoding="utf-8") as f:
        f.write(content)
    return True

def main():
    fixed = 0
    for root, dirs, files in os.walk(REPO):
        dirs[:] = [d for d in dirs if d not in ['.git', 'node_modules', 'dist']]
        for fname in files:
            if fname.endswith(('.md', '.vue', '.js', '.mjs', '.json', '.ts', '.html', '.css')):
                fpath = os.path.join(root, fname)
                if fix_file(fpath):
                    fixed += 1
                    print(f"  Fixed: {os.path.relpath(fpath, REPO)}")
    print(f"\nTotal: {fixed} files fixed")

if __name__ == "__main__":
    main()
