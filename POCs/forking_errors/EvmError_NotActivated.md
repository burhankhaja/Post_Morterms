## [NotActivated] EvmError: NotActivated
```toml
# foundry.toml
evm_version = "shanghai"
```

### why does this error occur? 
- *https://github.com/foundry-rs/foundry/issues/4988*
```conf
As 0.8.20 and PUSH0 is being used here, we require Shanghai as the evm version. 
However, no evm version is being passed in, so we're defaulting to Paris, were PUSH0 isn't available. 
Therefore we get this error.
```
