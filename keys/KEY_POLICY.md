# UNEBDO Key Policy

This repository publishes **UNEBDO public keys only**.

## Scope
UNEBDO keys are used **exclusively** to sign:
- hashes (SHA-512) of artifacts
- detached UNEBDO stamps (endorsement)

UNEBDO keys **DO NOT**:
- sign content
- sign identities
- certify truth or legal rights
- replace legal authorities or QTSPs

## Algorithm
- ED25519

## Verification rule
- OFFLINE_DETERMINISTIC
- FAIL_CLOSED
- If signature verification fails → INVALID

## Custody
- Private keys are **never** published.
- Private keys are stored offline by the issuer.
- Loss or compromise requires key rotation and explicit revocation notice.

## Semantics
UNEBDO signatures express **policy compliance endorsement only**.
They make temporal and structural precedence **opposable**, not “true”.

---
UNEBDO · audit-first · hash-only · append-only
