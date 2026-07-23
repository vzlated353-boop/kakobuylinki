import subprocess
import sys

result = subprocess.run(
    [sys.executable, 'd:/fansbuy/finsbuy-main/fix_clothing_brands.py'],
    capture_output=True,
    text=True,
    encoding='utf-8'
)

with open('d:/fansbuy/finsbuy-main/fix_output.txt', 'w', encoding='utf-8') as f:
    f.write("STDOUT:\n")
    f.write(result.stdout)
    f.write("\nSTDERR:\n")
    f.write(result.stderr)
    f.write(f"\nReturn code: {result.returncode}\n")

print("Done. Check fix_output.txt")
