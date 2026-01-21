# UNEBDO — Unified Evidentiary Node (B.C.E.)

**UNEBDO** è un nodo tecnico-giuridico per la generazione e verifica di **prove digitali opponibili**, basato su:
- manifest JSON canonicalizzati
- hash-chain (SHA-512)
- firme crittografiche (Ed25519)
- policy computabile **fail-closed** (OPC)

Questo repository è il **punto di verità unico**: vetrina pubblica (GitHub Pages), documentazione e software esecutivo.

---

## Scopo
- Rendere ogni evento **verificabile offline**
- Separare **presentazione** (Pages) da **esecuzione** (core)
- Applicare **policy automatiche** (ALLOW/DENY) con audit continuo

> Le pagine spiegano. Il software esegue. Le policy decidono.

---

## Vetrina Pubblica (GitHub Pages)
- Home: https://manuelcoletta1-source.github.io/unebdo/
- Software (catalogo): https://manuelcoletta1-source.github.io/unebdo/software/

---

## Software

### UNEBDO Core (MVP)
Motore di prova che:
- costruisce manifest deterministici
- calcola hash SHA-512 con chaining (`prev_hash`)
- firma il manifest (Ed25519)
- esporta un proof bundle verificabile

**Comandi**
```bash
unebdo mint   --input event.json --out proof/
unebdo verify --proof proof/

Output

manifest.json

manifest.canon.json

hashes.txt

signature.hex

public_key.hex


Scheda: ./software/unebdo-core.html


---

OPC — Opponibility Policy Controller (STRONG)

Policy computabile fail-closed:

valida struttura del manifest

verifica hash e firma

decide ALLOW solo se tutto è coerente



---

IPR & Opponibilità

UNEBDO opera con una radice identitaria (IPR) come riferimento semantico/giuridico per tracciabilità e continuità probatoria.


---

Struttura del Repository

unebdo/
├─ README.md
├─ index.html
├─ software/
│  ├─ index.html
│  ├─ unebdo-core.html
│  └─ opc.html
├─ src/unebdo/
│  ├─ cli.py
│  ├─ core.py
│  ├─ opc.py
│  ├─ canonical.py
│  └─ crypto.py
├─ tests/
├─ specs/
├─ schemas/
├─ examples/
└─ .github/workflows/


---

Audit Automatico (GitJoker)

Ogni push/PR:

esegue test

verifica proof di esempio

blocca incoerenze (fail-closed)



---

Stato

🟢 ATTIVO — Core + OPC operativi, vetrina software pubblica, CI attivo.


---

Autore e Fondatore

Manuel Coletta
UNEBDO · HERMETICUM B.C.E.
