> 1.  Is the heap memory saved when upgrading a canister? How much heap memory does a canister has?

No it is not. Only stable memory is saved. We can declare `stable` variables in the heap memory, which store data in stable memory and so they will persist through upgrades. The wasm heap is limited to 4GB.

> 2. How much accounts can a unique Principal own?

Accounts are 32-byte strings, meaning it's possible for a Principal to own up to 4,294,967,295 accounts.

> 3. Can we safely upgrade a canister from interface A to interface B?

Interface A

```motoko
actor {
  public func greet(surname : Text, firstname : Text) : async Text {
    return "Hello" # firstname # surname # " !";
  };
}
```

Interface B

```
actor {
  public func greet(firstname : Text) : async Text {
    return "Hello" # firstname # " !";
  };
}
```

No. This upgrade removes a required parameter from the public function `greet`. This would require other canisters or dapps to update their connection with the canister, otherwise their calls would fail due to sending two parameters instead of one.
