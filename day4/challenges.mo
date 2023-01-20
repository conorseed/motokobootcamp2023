import List "mo:base/List";
import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
actor {
    /*
     * 1. Write a function `unique` that takes a list l of type List<T> and returns a new list with all duplicate elements removed.
     * unique<T> : (l : List<T>, equal: (T,T) -> Bool) -> List<T> 
     */
     func unique(l : List.List<T>) : List.List<T> {
        let array = List.toArray<T>(l);
        var buffer = Buffer.fromArray<T>(array);
        Buffer.removeDuplicates(buffer);
        let nodupes_array = Buffer.toArray<T>(buffer);
        return List.fromArray<T>(nodupes_array);
     };

     /*
      * 2. Write a function `reverse` that takes l of type List<T> and returns the reversed list.
      * reverse<T> : (l : List<T>) -> List<T>;
      */
      func reverse(l : List<T>) : List<T>{
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
      func find_in_buffer(buf: Buffer.Buffer<T>, val: T) : ?Nat {
         Buffer.indexOf(T, buf, func x = x == val);
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