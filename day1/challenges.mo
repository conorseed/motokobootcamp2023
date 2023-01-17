actor {

   /* 
    * 1. Write a function **multiply** that takes two natural numbers and returns the product. 
    * multiply(n : Nat, m : Nat) -> async Nat
    */
    
    public func multiply(n : Nat, m: Nat) : async Nat {
        return n * m;
    };

   /*
    * 2. Write a function **volume** that takes a natural number n and returns the volume of a cube with side length n.
    * volume(n : Nat) -> async Nat
    */
    public func volume(n : Nat) : async Nat {
        return n * n * n
    };

   /* 
    * 3. Write a function hours_to_minutes that takes a number of hours n and returns the number of minutes.
    * hours_to_minutes(n : Nat) -> async Nat
    */
    public func hours_to_minutes(n : Nat) : async Nat {
        return n * 60
    };

   /* 
    * 4. Write two functions **set_counter** & **get_counter** .
    * - set_counter sets the value of counter to n.
    * - get_counter returns the current value of counter.
    * set_counter(n : Nat) -> async ()
    * get_counter() -> async Nat
    */
    var counter : Nat = 0;

    public func set_counter(n : Nat) : async () {
        counter := n;
    };

    public func get_counter() : async Nat {
        return counter;
    };

   /*
    * 5. Write a function **test_divide** that takes two natural numbers n and m and returns a boolean indicating if n divides m.
    * test_divide(n: Nat, m : Nat) -> async Bool
    */
    public func test_divide(n : Nat, m : Nat) : async Bool {
        if( n % m == 0){
            // n is divisible by m
            return true;
        };
        // n is not divisble by m
        return false;
    };

   /*
    * 6. Write a function **is_even** that takes a natural number n and returns a boolean indicating if n is even.
    * is_even(n : Nat) -> async Bool 
    */
    public func is_even(n : Nat) : async Bool {
        if( n % 2 == 0){
            // is even
            return true;
        };
        // is odd  
        return false;
    };

};