# Winsock

Original Winsock bindings for the Jai language. Note this is **not** Winsock 2, that is [here](https://github.com/judah-caruso/jai-winsock2).

# Usage

This depends on my [C interop module](https://github.com/judah-caruso/C). I recommend putting
dependencies in a `vendor` directory that's added to your build's `import_path`.

```shell
mkdir vendor && cd vendor/
git clone https://github.com/judah-caruso/C
git clone https://github.com/judah-caruso/jai-winsock Winsock
```

See `examples/winsock_test.jai` for basic UDP & TCP servers ported from C++.
