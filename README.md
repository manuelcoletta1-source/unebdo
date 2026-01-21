![UNEBDO Proof](https://github.com/manuelcoletta1-source/unebdo/actions/workflows/verify-unebdo.yml/badge.svg)# UNEBDO — Unified Evidentiary Node for Blindata Digital Opposability

**UNEBDO** è un sistema tecnico-giuridico per la generazione di **prove digitali opponibili**,
basato su **manifest JSON canonicalizzati**, **hash-chain**, **firme crittografiche**
e architettura modulare **Blindata · Computabile · Evolutiva (B.C.E.)**.

Questo repository unisce:
- **vetrina pubblica (GitHub Pages)**
- **documentazione tecnica**
- **software esecutivo (UNEBDO Core)**

in un’unica base coerente.

---

## 🎯 Obiettivo del Repository

Fornire un **punto di verità unico** per UNEBDO:

- spiegare **cos’è** e **come funziona**
- mostrare i **moduli software**
- ospitare il **core esecutivo** che genera prove verificabili
- mantenere separazione chiara tra **presentazione** e **esecuzione**

👉 Le pagine spiegano.  
👉 Il software esegue.

---

## 🌐 Vetrina Pubblica (GitHub Pages)

La vetrina è accessibile qui:

🔗 https://manuelcoletta1-source.github.io/unebdo/

Include:
- introduzione a UNEBDO
- principi di opponibilità
- collegamento all’IPR
- catalogo software

### Catalogo Software
🔗 https://manuelcoletta1-source.github.io/unebdo/software/

---

## 🧩 Software

### UNEBDO Core (MVP)
🔗 Scheda software:  
https://manuelcoletta1-source.github.io/unebdo/software/unebdo-core.html

**Funzione**
- Genera **pacchetti di prova opponibili**
- Output verificabile offline
- Ripetibile e auditabile

**Caratteristiche MVP**
- Manifest JSON canonicalizzato
- Hash SHA-512 con chaining (`prev_hash`)
- Firma digitale Ed25519
- Verifica completa della prova

**Comandi**
```bash
unebdo mint   --input event.json --out proof/
unebdo verify --proof proof/**
unebdo/
├─ README.md              ← questo file (vetrina testuale)
├─ index.html             ← GitHub Pages
├─ software/              ← pagine vetrina dei software
│   ├─ index.html
│   └─ unebdo-core.html
├─ src/unebdo/            ← CORE SOFTWARE (Python)
│   ├─ cli.py
│   ├─ core.py
│   ├─ canonical.py
│   └─ crypto.py
├─ tests/
├─ pyproject.toml
└─ LICENSE
