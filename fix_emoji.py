#!/usr/bin/env python3
"""Fix all ?? corruption:
- In .md files: ?? in frontmatter icons -> emoji; ?? in body text -> em-dash (—)
- In .vue/.js/.mjs files: fix emoji based on context"""

import os
import re

REPO = r"D:\kakobuylinki"

# Emoji mappings for category page frontmatter icons
CATEGORY_ICONS = {
    'shoes.md': {
        "icon: '??',\n    name: 'Running Shoes'": "icon: '🏃',\n    name: 'Running Shoes'",
        "icon: '??',\n    name: 'Basketball Shoes'": "icon: '🏀',\n    name: 'Basketball Shoes'",
        "icon: '??',\n    name: 'Casual Sneakers'": "icon: '👟',\n    name: 'Casual Sneakers'",
        "icon: '??',\n    name: 'Boots'": "icon: '',\n    name: 'Boots'",
        "icon: '',\n    name: 'Slides & Sandals'": "icon: '🩴',\n    name: 'Slides & Sandals'",
    },
    'clothes.md': {
        "icon: '??',\n    name: 'T-Shirts'": "icon: '',\n    name: 'T-Shirts'",
        "icon: '??',\n    name: 'Hoodies & Sweatshirts'": "icon: '',\n    name: 'Hoodies & Sweatshirts'",
        "icon: '',\n    name: 'Jackets & Outerwear'": "icon: '🧥',\n    name: 'Jackets & Outerwear'",
        "icon: '??',\n    name: 'Pants & Jeans'": "icon: '👖',\n    name: 'Pants & Jeans'",
        "icon: '??',\n    name: 'Shorts'": "icon: '🩳',\n    name: 'Shorts'",
    },
    'hats.md': {
        "icon: '??',\n    name: 'Snapback Caps'": "icon: '🧢',\n    name: 'Snapback Caps'",
        "icon: '??',\n    name: 'Beanies'": "icon: '',\n    name: 'Beanies'",
        "icon: '??',\n    name: 'Bucket Hats'": "icon: '👒',\n    name: 'Bucket Hats'",
        "icon: '',\n    name: 'Dad Hats'": "icon: '',\n    name: 'Dad Hats'",
        "icon: '??',\n    name: 'Fitted Caps'": "icon: '',\n    name: 'Fitted Caps'",
    },
}

def fix_md_file(fpath):
    """Fix emoji in frontmatter and em-dash in body of markdown files."""
    try:
        with open(fpath, "r", encoding="utf-8") as f:
            content = f.read()
    except UnicodeDecodeError:
        # Try latin-1 as fallback (it never fails)
        with open(fpath, "r", encoding="latin-1") as f:
            content = f.read()
    
    if "??" not in content:
        return False
    
    fname = os.path.basename(fpath)
    fixed = content
    
    # Fix frontmatter icons for category pages
    if fname in CATEGORY_ICONS:
        for old, new in CATEGORY_ICONS[fname].items():
            fixed = fixed.replace(old, new)
    
    # Fix remaining ?? as em-dashes (body text)
    fixed = fixed.replace("??", "—")
    
    if fixed == content:
        return False
    
    with open(fpath, "w", encoding="utf-8") as f:
        f.write(fixed)
    return True

def fix_vue_js_file(fpath):
    """Fix emoji corruption in Vue/JS files based on context."""
    try:
        with open(fpath, "r", encoding="utf-8") as f:
            content = f.read()
    except UnicodeDecodeError:
        with open(fpath, "r", encoding="latin-1") as f:
            content = f.read()
    
    if "??" not in content:
        return False
    
    fname = os.path.basename(fpath)
    fixed = content
    
    if fname == 'site-config.js':
        replacements = {
            "icon: '??',\n      description: 'Explore the world of sneakers": "icon: '',\n      description: 'Explore the world of sneakers",
            "icon: '??',\n      description: 'From streetwear essentials": "icon: '',\n      description: 'From streetwear essentials",
            "icon: '??',\n      description: 'Complete your look with caps": "icon: '',\n      description: 'Complete your look with caps",
            "logistics info ?? all in one place": "logistics info — all in one place",
        }
        for old, new in replacements.items():
            fixed = fixed.replace(old, new)
    
    elif fname == 'ArticleNavigation.vue':
        replacements = {
            '<span class="nav-icon">??</span>\n          <span class="nav-text">Clothes</span>': 
                '<span class="nav-icon"></span>\n          <span class="nav-text">Clothes</span>',
            '<span class="nav-icon">??</span>\n          <span class="nav-text">{{ article.title }}</span>':
                '<span class="nav-icon"></span>\n          <span class="nav-text">{{ article.title }}</span>',
        }
        for old, new in replacements.items():
            fixed = fixed.replace(old, new)
    
    elif fname == 'HomePage.vue':
        replacements = {
            '<div class="intro-icon">??</div>\n            <h3>Comprehensive Guides</h3>':
                '<div class="intro-icon"></div>\n            <h3>Comprehensive Guides</h3>',
            '<div class="intro-icon">??</div>\n            <h3>Quality You Can Trust</h3>':
                '<div class="intro-icon">✅</div>\n            <h3>Quality You Can Trust</h3>',
            '<div class="intro-icon">??</div>\n            <h3>Smart Savings</h3>':
                '<div class="intro-icon">💰</div>\n            <h3>Smart Savings</h3>',
            '<h3 class="group-title">?? Save Money</h3>':
                '<h3 class="group-title"> Save Money</h3>',
            '<h3 class="group-title">?? Regional & International</h3>':
                '<h3 class="group-title"> Regional & International</h3>',
            '<div class="explore-icon">??</div>':
                '<div class="explore-icon">🔍</div>',
            "every step ?? account setup": "every step — account setup",
        }
        for old, new in replacements.items():
            fixed = fixed.replace(old, new)
    
    if fixed == content:
        return False
    
    with open(fpath, "w", encoding="utf-8") as f:
        f.write(fixed)
    return True

def main():
    md_fixed = 0
    vue_js_fixed = 0
    
    for root, dirs, files in os.walk(REPO):
        dirs[:] = [d for d in dirs if d not in ['.git', 'node_modules', 'dist']]
        for fname in files:
            fpath = os.path.join(root, fname)
            if fname.endswith('.md'):
                if fix_md_file(fpath):
                    md_fixed += 1
                    print(f"  Fixed MD: {os.path.relpath(fpath, REPO)}")
            elif fname.endswith(('.vue', '.js', '.mjs')):
                if fix_vue_js_file(fpath):
                    vue_js_fixed += 1
                    print(f"  Fixed Vue/JS: {os.path.relpath(fpath, REPO)}")
    
    print(f"\nDone: {md_fixed} MD files, {vue_js_fixed} Vue/JS files fixed")

if __name__ == "__main__":
    main()
