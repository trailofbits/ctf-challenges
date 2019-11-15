# macrypto

> Author: @ex0dus
> Category: crypto
> Description: wrote this cipher for a vendor, who demanded it in rust. should be good, but audit it for me?

__macrypto__ (macro + crypto) is a medium-level CTF challenge written for CSAW 2019. Users are given `macrypto.rs`, which is a semi hand-obfuscated source file that implements a broken RC4 cipher based off of the [2007 Underhanded C competition](http://underhanded-c.org/_page_id_16.html).

## Setup

```
$ cargo build
$ ./macrypto
```

## The Challenge

Figure out functionality of Rust macros implemented and the cipher being used. Realize the broken functionality in the swap macro `s!`, which implements a faulty XOR-swap trick.

## The Solution

```
$ python2 solve.py
```

will throw variable-length arbitrary input to the challenge, and checking if the faulty XOR-swap will eventually returning a plaintext flag.
