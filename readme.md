# Accounting Example

## Using hledger

### General Usage

[Plain Text Accounting Workshop](https://github.com/colindean/plaintextaccounting_workshop/releases/download/2020.07.24.0/pta_workshop.pdf)

[hledger Manual](https://hledger.org/1.34/hledger.html)

### General Structure

```console
.
├── 2024
│   ├── aliased.ledger
│   ├── book.ledger
│   └── postings.ledger
├── book.ledger
└── meta
    ├── coicop-2018.ledger
    └── commodities.ledger
```

`book.ledger`

- Main entry point for the general ledger, or each year's ledger

`postings.ledger`

- Actual double-entry transactions
- should __**always**__ pass `--strict`
- should optimally __**always**__ pass all checks

`aliased.ledger`

- Because of how `hledger` works, we create a separate file to handle aliases
- This should provide a more readable `accounts` output

### Checking that any year's book passes strict checks

`hledger bal --strict -f 2024/book.ledger`

### Checking that any year's book passes all checks

`hledger check --strict ordereddates payees tags recentassertions
uniqueleafnames -f 2024/book.ledger`

## Using Git-Agecrypt

[Git-agecrypt](https://github.com/vlaci/git-agecrypt) is a rust-written file
encryption `git` extension.

`git-agecrypt` allows one to upload files to public platforms (or platforms
where privacy is not guaranteed, such as private repos) in an encrypted manner.

Locally, decrypting is easy.

For the purposes of this example, a pair of Ed25519 private-public keys is
provided in `secrets`.

However in your own version you should not at all consider providing this
key-pair publicly.

Please refer to the git-agecrypt documentation.

### Note on decrypting

The `git-agecrypt` docs are not amazing.

To decrypt a particular file after cloning, add an identity `git-agecrypt
config add -i ~/.ssh/id_ed25519`.

This identity needs to be a recipient of that particular file.

Then, to decrypt on first pass, run `git restore <file>`.

For example, in this repo:

```console
git-agecrypt config add -i id_ed25519
git restore hledger.journal
```

This does not need to be done ever again, as `git pull` will automatically
decrypt the file in the future.
