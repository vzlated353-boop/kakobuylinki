import csv, sys
sys.stdout.reconfigure(encoding='utf-8')

with open('d:/fansbuy/finsbuy-main/category_csv/ACC.csv', 'r', encoding='utf-8-sig') as f:
    rows = sum(1 for _ in csv.reader(f))
print(f"ACC.csv: {rows} rows (including header)")
