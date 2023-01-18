> 1. Who controls the ledger canister?

The Controller ID for the Ledger Canister is `r7inp-6aaaa-aaaaa-aaabq-cai`. I'm not sure "who" that is though!

---

> 2. What is the subnet of the canister with the id: **mwrha-maaaa-aaaab-qabqq-cai**? How much nodes are running this subnet?

The subnet of this canister is `pae4o-o6dxf-xki7q-ezclx-znyd6-fnk6w-vkv5z-5lfwh-xym2i-otrrw-fqe`.

- Source: https://dashboard.internetcomputer.org/canister/mwrha-maaaa-aaaab-qabqq-cai

There are 16 nodes running on this subnet.

- Source: https://dashboard.internetcomputer.org/subnet/pae4o-o6dxf-xki7q-ezclx-znyd6-fnk6w-vkv5z-5lfwh-xym2i-otrrw-fqe

---

> 3. I have a neuron with 1O ICPs locked with a dissolve delay of 4 years - my neuron has been locked for 2 years. What is my expected voting power?

Voting Power is calculated as below:

```
Voting Power = ICP Stake * Dissolve Delay Bonus * Age Bonus
```

So in this case, the dissolve delay bonus is `1.24` and the age bonus is `1.125`:

```
Voting Power = 10 * 1.24 * 1.125
```

```
Voting Power = 13.95
```

- Source: https://support.dfinity.org/hc/en-us/articles/4404284534420-What-is-voting-power-

---

> 4. What is wrong with the following code?

```
actor {
  let n : Nat = 50;
  let t : Text = "Hello";

  public func convert_to_text(m : Nat) : async Text {
    Nat.toText(m);
  };

}
```

The `Nat` module needs to be imported, otherwise the error will be `unbound variable Nat`.

Solution:

```
import Nat "mo:base/Nat";

actor {
  let n : Nat = 50;
  let t : Text = "Hello";

  public func convert_to_text(m : Nat) : async Text {
    Nat.toText(m);
  };

}
```

---

> 5. What is wrong with the following code?

```
actor {
  var languages : [var Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func show_languages(language : Text) : async [var Text] {
    return (languages);
  };

}
```

There's two issues:

1. The array `languages` is set to be mutable, but is missing the keyword `var.
2. Public functions cannot return a mutable array.

**OPTION ONE:**
Make the array `languages` immutable and return that:

```
actor {
  var languages : [Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func show_languages(language : Text) : async [Text] {
    return languages;
  };

}
```

**OPTION TWO:**
Fix the mutable array and freeze it before returning it using the `Array` module:

```
import Array "mo:base/Array";

actor {
  var languages : [var Text] = [var "English", "German", "Chinese", "Japanese", "French"];

  public func show_languages(language : Text) : async [Text] {
    return Array.freeze(languages);
  };

}
```

---

> 6.  What is wrong with the following code?

```
actor {
  var languages : [Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func add_language(new_language: Text) : async [Text] {
    languages := Array.append<Text>(languages, [new_language]);
    return (languages);
  };

}
```

The `Array` module needs to be imported. , otherwise the error will be `unbound variable Array`.

It's also important to note that `Array.append` is deprecated and we whsould probably use `Buffer` instead. The Motoko docs say:

> @deprecated Array.append copies its arguments and has linear complexity; when used in a loop, consider using a Buffer, and Buffer.append, instead.

- Source: https://internetcomputer.org/docs/current/developer-docs/build/cdks/motoko-dfinity/base/Array
