import List "mo:base/List";
import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
actor {
    /*
     * 1. Write a function `unique` that takes a list l of type List<T> and returns a new list with all duplicate elements removed.
     * unique<T> : (l : List<T>, equal: (T,T) -> Bool) -> List<T> 
     */
     func unique<T>(l : List.List<T>) : List.List<T> {
        
        var arr = List.toArray(l);
        var dups = Buffer.Buffer<T>(0);
        var unique = Buffer.Buffer<T>(0);

        for(i in arr.keys()){
         
         let exists : Bool = Buffer.contains<T>(dups, arr[i], func(x, y) { x == y});

         switch(exists) {
            case(true) {};
            case(false) { 
               // filter through array to check if there's more than one of the current value
               let entries = Array.filter<T>(arr, func x = arr[i] == x);
               
               // if there's only one, push to duplicates
               if(entries.size() == 1){
                  unique.add(arr[i]);
               };
            };
         };

        };

        return List.fromArray<T>(Buffer.toArray<T>(unique));
     };

     /*
      * 2. Write a function `reverse` that takes l of type List<T> and returns the reversed list.
      * reverse<T> : (l : List<T>) -> List<T>;
      */
      func reverse<T>(l : List.List<T>) : List.List<T>{
         return List.reverse(l);
      };

      /*
       * 3. Write a function `is_anonymous` that takes no arguments but returns a Boolean indicating if the caller is anonymous or not.
       * is_anynomous : () -> async Bool; 
       */
       public shared({caller}) func is_anynomous() : async Bool {
         return Principal.isAnonymous(caller)
       };

      /*
       * 4. Write a function `find_in_buffer` that takes two arguments,
       * buf of type **Buffer** and val of type **T**, and returns the optional index of the first occurrence of "val" in "buf".
       * find_in_buffer<T> :  (buf: Buffer.Buffer<T>, val: T, equal: (T,T) -> Bool) -> ?Nat
       */
      func find_in_buffer<T>(buf: Buffer.Buffer<T>, val: T) : ?Nat {
         Buffer.indexOf<T>(val, buf, func (x, y) { x == y } );
      };

      /* 
       * 5. Add a function called `get_usernames` that will
       * return an array of tuples (Principal, Text) which contains all the entries in usernames.
       * get_usernames : () -> async [(Principal, Text)];
       */
      let usernames = HashMap.HashMap<Principal, Text>(0, Principal.equal, Principal.hash);
      public shared ({ caller }) func add_username(name : Text) : async () {
         usernames.put(caller, name);
      };

      public query func get_usernames() : async [(Principal, Text)]{
         return Iter.toArray<(Principal, Text)>(usernames.entries());
      }

}