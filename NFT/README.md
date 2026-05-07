## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

data:image/svg+xml;base64,
PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdo
dD0iNTAwIj4KPHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9ImJsYWNrIj4gaGkhIHlvdSBkZWNvZGVk
IHRoaXMhIDwvdGV4dD4KPC9zdmc+

data:image/svg+xml;base64,
PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdo
dD0iNTAwIj4KICA8IS0tIGZhY2UgLS0+CiAgPGNpcmNsZSBjeD0iMjUwIiBjeT0iMjUwIiByPSIy
MDAiIGZpbGw9InllbGxvdyIgLz4KCiAgPCEtLSBleWVzIC0tPgogIDxjaXJjbGUgY3g9IjIwMCIg
Y3k9IjIyMCIgcj0iMjUiIGZpbGw9ImJsYWNrIiAvPgogIDxjaXJjbGUgY3g9IjMwMCIgY3k9IjIy
MCIgcj0iMjUiIGZpbGw9ImJsYWNrIiAvPgoKICA8IS0tIHNtaWxlIC0tPgogIDxwYXRoIGQ9Ik0x
ODAgMzAwIFEyNTAgMzcwIDMyMCAzMDAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMTAi
IGZpbGw9Im5vbmUiLz4KPC9zdmc+

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
