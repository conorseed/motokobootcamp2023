> 1. How much is the current memory capacity of a canister?

It looks like it's possible to go up to 48 GB of stable memory. However, the wasm heap is limited to just 4 GB due to Wasm runtime 32-bit memory limitations.

Source:

- https://forum.dfinity.org/t/increased-canister-smart-contract-memory/6148/140

---

<br>

> 2. What is the issue with the following code sample?

```
actor {
  let counter : Nat = 0;
  public func increment_counter() : async () {
    counter := counter + 1;
  };
}
```

The `counter` variable is declared using `let` making it immutible. This means that when the function `increment_counter()` runs, it will throw an error (probably "expected mutable assignment target") as the value of an immutible variable cannot be changed.

To fix this, we can change `let` to `var` as below:

```
actor {
  var counter : Nat = 0;
  public func increment_counter() : async () {
    counter := counter + 1;
  };
}
```

---

<br>

> 3. What is the issue with the following code sample?

```
actor {
  var message : Text = 0;

  public query func change_message(new_message : Text) : async () {
    message := new_message;
    return;
  };

  public query func see_message() : async Text {
    return(message);
  };
}
```

The `message` variable is declared as type `Text`, but then given a value `0` which is not of that type. This throws the error "does not have expected type Text".

To fix it, we can give the variable a value of the correct type - even an empty string would do. e.g.

```
actor {
  var message : Text = "Hello from New Zealand 🇳🇿";

  public query func change_message(new_message : Text) : async () {
    message := new_message;
    return;
  };

  public query func see_message() : async Text {
    return(message);
  };
}
```

---

<br>

> 4. False or True: we can remove the keyword **async** for return argument of a query function since queries are faster to answer.

False. When removing the `async` keyword from a query you will get the error "'shared query function must have syntactic return type 'async \<typ\>'"
