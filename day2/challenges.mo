import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Buffer "mo:base/Buffer";
import Bool "mo:base/Bool";

actor{
    type Pattern = Text.Pattern;

    /*
     * 1. Write a function **average_array** that takes an array of integers and returns the average value of the elements in the array.
     * average_array(array : [Int]) -> async Int. 
     */
    public func average_array(array : [Int]) : async Int {
        
        // Calculate the sum of the array
        var arraySum : Int = 0;
        for(int in array.vals()){
            arraySum += int;
        };

        // Calcuate the average by dividing the arraySum by the array size
        var arrayAverage : Int = arraySum / array.size();

        return arrayAverage;
    };

    /*
     * 2. **Character count**: Write a function that takes in a string and a character, 
     * and returns the number of occurrences of that character in the string.
     * count_character(t : Text, c : Char) -> async Nat
     */
    public func count_character(t : Text, c : Char) : async Nat {
        
        var occurances : Nat = 0;
        
        // iterate over chars in text
        for(ch in t.chars()){
            // check if current ch is equal to c
            if( ch == c ){
                occurances += 1;
            }
        };

        return occurances;
    };

    /*
     * 3. Write a function **factorial** that takes a natural number n
     * and returns the [factorial](https://www.britannica.com/science/factorial) of n.
     * factorial(n : Nat) ->  async Nat
     */
    public func factorial(n : Nat) : async Nat {

        // Factorial 0 is equal to 1
        if( n == 0 ){
            return 1;
        };

        // Otherwise iterate and multiply!
        var factorial : Nat = 1;

        for(i in Iter.range(1, n)) {
            factorial *= i;    
        };

        return factorial;
    };

    /*
     * 4.  Write a function **number_of_words** that takes a sentence
     * and returns the number of words in the sentence.
     * number_of_words(t : Text) -> async Nat 
     */
    public func number_of_words(t : Text) : async Nat {

        // Create pattern to check for whitespace
        let isWhitespace : Pattern = #predicate(Char.isWhitespace);

        // Remove whitespace at start and end
        // Otherwise it counts those when splitting below
        var trimmed = Text.trimEnd(t, isWhitespace);
        trimmed := Text.trimStart(trimmed, isWhitespace);

        // Split text into words
        let split : Iter.Iter<Text> = Text.split(trimmed, isWhitespace);

        // returns the size of the iteration
        return Iter.size(split);
    };

    /*
     * 5. Write a function **find_duplicates** that takes an array of natural numbers
     * and returns a new array containing all duplicate numbers. 
     * The order of the elements in the returned array should be the same
     * as the order of the first occurrence in the input array.
     * find_duplicates(a : [Nat]) -> async [Nat]
     */
    public func find_duplicates(a : [Nat]) : async [Nat] {
        
        // Setup duplcates array
        //var duplicates : [Nat] = [];
        var duplicates = Buffer.Buffer<Nat>(0);
        
        // Iterate over each value
        for(i in a.keys()) {

            // see if this has already been found
            //let exists : ?Nat = Array.find<Nat>(duplicates, func x = a[i] == x);
            let exists : Bool = Buffer.contains<Nat>(duplicates, a[i], func(x: Nat, y: Nat) : Bool { x == y});

            switch(exists) {
                // do nothing if already exists
                case(true){};
                // if it doesn't already exist in duplicates run checks
                case(false) { 
                    // filter through array to check if there's more than one of the current value
                    let entries : [Nat] = Array.filter<Nat>(a, func x = a[i] == x);
                    
                    // if there's more than one, push to duplicates
                    if(entries.size() > 1){
                        //duplicates := Array.append<Nat>(duplicates, [a[i]]);
                        duplicates.add(a[i]);
                    };
                };
            };
            
        };
        return Buffer.toArray(duplicates);
    };


    /*
     * 6. Write a function **convert_to_binary** that takes a natural number n
     * and returns a string representing the binary representation of n.
     * convert_to_binary(n : Nat) -> async Text
     */
    public func convert_to_binary(n : Nat) : async Text {
        
        var binary : Text = "";
        var remainder : Nat = 0;
        var i : Nat = n;
        
        // while the number isn't zero
        while(i != 0){
            // get remainder
            remainder := i % 2;
            // add remainder to start of binary string
            binary := Text.concat( Nat.toText(remainder), binary );
            // divide n by 2
            i := i / 2;
        };

        return binary;
    };
}