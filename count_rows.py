import csv, os, sys
sys.stdout.reconfigure(encoding='utf-8')

base = 'd:/fansbuy/finsbuy-main/category_csv'
for f in sorted(os.listdir(base)):
    path = os.path.join(base, f)
    with open(path, 'r', encoding='utf-8-sig') as fh:
        rows = sum(1 for _ in csv.reader(fh))
    print(f"{f}: {rows} rows (including header)")
