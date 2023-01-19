import Array "mo:base/Array";
import Int "mo:base/Int";
import Buffer "mo:base/Buffer";

module Utils{

    /* 
     * 1. In your file called utils.mo: create a function called second_maximum that
     * takes an array [Int] of integers and returns the second largest number in the array.
     * second_maximum(array : [Int]) ->  Int;
     */
    public func second_maximum(array : [Int]) : Int {

        switch(array.size()){
            // no need to sort if only one value...
            case(1){
                return array[0];
            };

            case(_){
                // sort low -> high
                let sorted = Array.sort<Int>(array, Int.compare);
                // get penultimate index
                let penultimate : Nat = sorted.size() - 2;
                // return penultimate
                return sorted[penultimate];
            };
        };
    };

    /*
     * In your file called utils.mo: create a function called remove_even
     * that takes an array [Nat] and returns a new array with only the odd numbers from the original array.
     * remove_event(array : [Nat]) -> [Nat];
     */
    public func remove_even(array : [Nat]) : [Nat] {
        
        // Setup buffer
        let odd_numbers = Buffer.Buffer<Nat>(0);

        // iterate over array
        for(num in array.vals()) {
            // If modulus 2 has remainder it's odd
            if( num % 2 == 1 ){
                // so add it to the buffer
                odd_numbers.add(num);
            };
        };
        
        // return odd numbers
        return Buffer.toArray(odd_numbers);
    };

    /*
     * In your file called utils.mo: write a function drop that takes 2 parameters:
     * an array [T] and a Nat n. This function will drop the n first elements of
     * the array and returns the remainder.
     * ⛔️ Do not use a loop.
     * drop<T> : (xs : [T], n : Nat) -> [T]
     */
    public func drop<T>(xs: [T], n : Nat) : [T]{
        
        // Simply return xs if 
        // n is zero
        // or > xs.size() - in this case it should probably throw an error somehow? But this is fine for now. 
        if( n == 0 or n > xs.size() ){
            return xs;
        };

        // Setup Buffer & Split it at index
        var result = Buffer.split(Buffer.fromArray<T>(xs), n);

        // return remainder
        return Buffer.toArray(result.1);
    }

}