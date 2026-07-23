import csv, sys
sys.stdout.reconfigure(encoding='utf-8')

# Count ACC rows
with open('d:/fansbuy/finsbuy-main/category_csv/ACC.csv', 'r', encoding='utf-8-sig') as f:
    rows = sum(1 for _ in csv.reader(f))
print(f"ACC.csv: {rows} rows (including header)")

# Fix clothing.csv - extract brand from product name
import re

with open('d:/fansbuy/finsbuy-main/category_csv/clothing.csv', 'r', encoding='utf-8-sig') as f:
    reader = csv.reader(f)
    header = next(reader)
    rows = list(reader)

print(f"clothing.csv: {len(rows)} data rows")

# Check how many have empty brand
empty_brand = sum(1 for r in rows if not r[7].strip())
print(f"  Empty brand: {empty_brand}")

# Sample some product names to understand brand pattern
for r in rows[:20]:
    name = r[0].replace('\n', ' ').strip()
    brand = r[7].strip() if len(r) > 7 else ''
    print(f"  Name: '{name}' | Brand: '{brand}'")
