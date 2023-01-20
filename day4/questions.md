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

This upgrade removes the first parameter `surname` from the public function `greet`.
Technically upgrading can be done safely - Candid will automatically remove the second argument from any calls to the function and run it as normal.
However, any existing connections from other canisters or dapps will be setup to send `surname` as the first argument instead of `firstname`. So even though the calls won't fail, they'll be adding the wrong data to the canister.
