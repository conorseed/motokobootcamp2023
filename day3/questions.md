> 1. True or False: the Internet Computer has a unique public key that can be used to verify responses coming from any subnets.

True. We only need the public key of the root subnet to verify responses. The root subnet lists all the subnets of the IC, including their public key.

> True or False: when I realize an update call, the boundary node will participate in the consensus but not during query calls.

False - as far as I can see Boundary Nodes do not participate in consensus. They protect the Consensus Nodes and improve peformance of the network.

However, an update call requires consensus and this information is published in the ledger. Due to this update calls are slow: usually around 2 seconds.

Query calls do not require consensus, which makes them faster (like regular web2 api calls). But this also comes with a slight security risk, which Certified Data aims to fix.

> True or False: I can create a certified variable that will certify the response of the following actor:

```
actor {
    public func hello(name : Text) : async Text {
        return ("hello # name");
    };
}
```

True? I think you can, but there isn't any need to.

As this is a regular function, it goes through consensus before being returned.
