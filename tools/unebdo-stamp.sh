#!/usr/bin/env bash
# UNEBDO STAMP TOOL — Ed25519 endorsement (fail-closed)
# Requirements: openssl >= 1.1.1, sha512sum (or shasum -a 512)
# Usage:
#   ./unebdo-stamp.sh <RECEIPT_JSON> <UNEBDO_PRIVATE_KEY> <OUT_STAMP_JSON>

set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <RECEIPT_JSON> <UNEBDO_PRIVATE_KEY> <OUT_STAMP_JSON>"
  exit 1
fi

RECEIPT="$1"
PRIVKEY="$2"
OUT="$3"

if [ ! -f "$RECEIPT" ]; then
  echo "ERROR: receipt not found: $RECEIPT"
  exit 1
fi

if [ ! -f "$PRIVKEY" ]; then
  echo "ERROR: private key not found: $PRIVKEY"
  exit 1
fi

# 1) Canonicalize JSON (keys sorted, no whitespace noise)
CANON_JSON="$(mktemp)"
python3 - <<'PY'
import json,sys
with open(sys.argv[1],'r',encoding='utf-8') as f:
    obj=json.load(f)
def canon(v):
    if isinstance(v,dict):
        return {k: canon(v[k]) for k in sorted(v)}
    if isinstance(v,list):
        return [canon(x) for x in v]
    return v
print(json.dumps(canon(obj), separators=(',',':')))
PY "$RECEIPT" > "$CANON_JSON"

# 2) SHA-512 of canonical JSON
DIGEST_HEX="$(openssl dgst -sha512 "$CANON_JSON" | awk '{print $2}')"

if [ "${#DIGEST_HEX}" -ne 128 ]; then
  echo "ERROR: invalid SHA-512 digest length"
  exit 1
fi

# 3) Sign digest hex string with Ed25519 (raw)
SIG_BIN="$(mktemp)"
printf "%s" "$DIGEST_HEX" | \
  openssl pkeyutl -sign -inkey "$PRIVKEY" -rawin > "$SIG_BIN"

SIG_B64="$(base64 < "$SIG_BIN" | tr -d '\n')"

# 4) Emit UNEBDO-STAMP-v1 (detached)
cat > "$OUT" <<JSON
{
  "schema": "UNEBDO-STAMP-v1",
  "type": "UNEBDO_OFFICIAL_STAMP",
  "policy": {
    "ue_first": true,
    "audit_first": true,
    "hash_only": true,
    "fail_closed": true,
    "append_only": true
  },
  "subject": {
    "artifact": "$(basename "$RECEIPT")",
    "hash": {
      "algorithm": "SHA-512",
      "digest_hex": "$DIGEST_HEX"
    }
  },
  "issuer": {
    "name": "UNEBDO",
    "public_key_ref": "/unebdo/keys/unebdo_ed25519_pub.pem"
  },
  "signature": {
    "algorithm": "ED25519",
    "signature_b64": "$SIG_B64",
    "signed_payload": "SHA512_DIGEST_HEX"
  },
  "verification": {
    "mode": "OFFLINE_DETERMINISTIC",
    "rule": "FAIL_CLOSED",
    "on_mismatch": "INVALID"
  }
}
JSON

chmod 600 "$OUT"
rm -f "$CANON_JSON" "$SIG_BIN"

echo "OK — UNEBDO stamp created:"
echo "  Receipt: $RECEIPT"
echo "  SHA-512: $DIGEST_HEX"
echo "  Output : $OUT"
