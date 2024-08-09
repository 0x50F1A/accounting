# Accounting Example

## Using Git-Agecrypt

https://github.com/vlaci/git-agecrypt

`git-agecrypt` allows one to upload files to public platforms (or platforms where privacy is not guaranteed, such as private repos) in an encrypted manner.

Locally, decrypting is easy.

For the purposes of this example, a pair of Ed25519 private-public keys is provided..

However in your own version you should not at all consider providing this keypair publicly.

Please refer to the git-agecrypt documentation at their github repo.

### Note on decrypting

The `git-agecrypt` docs are not amazing. 

To decrypt a particular file after cloning, add an identity `git-agecrypt config add -i ~/.ssh/id_ed25519`.

This identity needs to be a recipient of that particular file.

Then, to decrypt on first pass, run `git restore <file>`. 

For example, in this repo:

```console
git-agecrypt config add -i id_ed25519
git restore hledger.journal
```

This does not need to be done ever again, as `git pull` will automatically decrypt the file in the future.
