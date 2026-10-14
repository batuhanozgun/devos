# usage: python3 -I log_listing.py <log> <out json>
# The listing step's printed items: 'listing: <item>' lines after the step's header line, up to 'listing: N objects ...'.
import sys, json, re
items, inside, count = [], False, None
for l in open(sys.argv[1], encoding="utf-8"):
    l = l.rstrip("\n")
    if "\x1b[36;1m" in l:
        continue
    body = l[29:] if re.match(r"^\d{4}-\d\d-\d\dT[\d:.]+Z ", l) else l
    if body.startswith("listing (W-C02-03 point 10)"):
        inside = True; continue
    if inside and body.startswith("listing: "):
        m = re.fullmatch(r"listing: (\d+) objects outside Supabase's own", body)
        if m:
            count = int(m.group(1)); break
        items.append(body[len("listing: "):])
json.dump(items, open(sys.argv[2], "w"))
print(f"items={len(items)} printed count={count} equal={len(items) == count}: {items}")
