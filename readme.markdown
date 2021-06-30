# Winsock

Original Winsock bindings for the Jai language. Note this is **not** Winsock 2, that is [here](https://github.com/judah-caruso/jai-winsock2).

# Usage

This depends on the static version of my [C interop module](https://github.com/judah-caruso/C)
which has been pulled in already, so there's no extra work to use these bindings.

```bash
mkdir vendor && cd vendor/
git clone https://github.com/judah-caruso/jai-winsock
```

See `examples/winsock_test.jai` for basic UDP & TCP servers ported from C++.
