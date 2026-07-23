import os

BASE = r'd:\fansbuy\finsbuy-main'

with open(os.path.join(BASE, 'key.txt'), 'r', encoding='utf-8') as f:
    lines = f.readlines()

all_files = os.listdir(BASE)
md_files = set()
for f in all_files:
    fp = os.path.join(BASE, f)
    if f.endswith('.md') and os.path.isfile(fp):
        md_files.add(f[:-3])

series_order = []
series_map = {}
current_series = None
current_subsection = None

for line in lines:
    line = line.rstrip('\n').rstrip('\r')
    stripped = line.strip()

    if stripped.startswith('# SERIES'):
        parts = stripped.split(':', 1)
        if len(parts) >= 2:
            sn = parts[0].replace('#', '').strip()
            sd = parts[1].strip()
            current_series = sn + ': ' + sd
            if current_series not in series_map:
                series_order.append(current_series)
                series_map[current_series] = {'subsections': {}, 'order': []}
            current_subsection = None
        continue

    if stripped.startswith('## '):
        current_subsection = stripped[3:].strip()
        if current_series and current_subsection not in series_map[current_series]['subsections']:
            series_map[current_series]['subsections'][current_subsection] = []
            series_map[current_series]['order'].append(current_subsection)
        continue

    if stripped == '' or stripped.startswith('#'):
        continue

    keyword = stripped
    if current_series:
        sub = current_subsection if current_subsection else '_main'
        if sub not in series_map[current_series]['subsections']:
            series_map[current_series]['subsections'][sub] = []
            if sub != '_main':
                series_map[current_series]['order'].append(sub)
        series_map[current_series]['subsections'][sub].append(keyword)

total_keywords = 0
total_covered = 0
total_uncovered = 0

print('=' * 80)
print('FANSBUY KEYWORD COVERAGE REPORT')
print('=' * 80)

for series_name in series_order:
    series_data = series_map[series_name]
    print()
    print('=' * 80)
    print(series_name)
    print('=' * 80)

    series_covered = 0
    series_uncovered = 0

    subs = series_data['order']
    if '_main' in series_data['subsections'] and '_main' not in subs:
        subs = ['_main'] + subs

    for subsection in subs:
        keywords = series_data['subsections'].get(subsection, [])
        sub_total = len(keywords)
        sub_covered = 0
        sub_covered_list = []
        sub_uncovered_list = []

        for kw in keywords:
            total_keywords += 1
            if kw in md_files:
                sub_covered += 1
                series_covered += 1
                total_covered += 1
                sub_covered_list.append(kw)
            else:
                series_uncovered += 1
                total_uncovered += 1
                sub_uncovered_list.append(kw)

        if subsection != '_main':
            print()
            print('  --- ' + subsection + ' ---')
        else:
            print()

        print('  Covered: ' + str(sub_covered) + '/' + str(sub_total) + '  Uncovered: ' + str(sub_total - sub_covered) + '/' + str(sub_total))

        if sub_covered_list:
            print('  [COVERED]:')
            for kw in sub_covered_list:
                print('    + ' + kw)
        if sub_uncovered_list:
            print('  [UNCOVERED]:')
            for kw in sub_uncovered_list:
                print('    - ' + kw)

    print()
    print('  >>> Series total: covered=' + str(series_covered) + ', uncovered=' + str(series_uncovered) + ', total=' + str(series_covered + series_uncovered))

print()
print('=' * 80)
print('GRAND TOTAL')
print('=' * 80)
print('  Total keywords: ' + str(total_keywords))
print('  Covered (have .md): ' + str(total_covered))
print('  Uncovered (need content): ' + str(total_uncovered))
if total_keywords > 0:
    pct = round(total_covered / total_keywords * 100, 1)
    print('  Coverage: ' + str(pct) + '%')
