> 1. True or False: we can prevent the heap being erased during upgrades by using a `stable` heap.

False? The heap will always being erased during upgrades. However, you can store stable variables in stable memory, which aare not erased during upgrades. You can also run pre and post upgrade functions which convert non stable variables to stable ones, save them to stable memory before the upgrade, then after the upgrade retrieves the stable data and imports back into the canister data.

> 2. A.call() -> B.call() -> C How much time (or rounds of consensus) do we need to wait for an answer?

If I'm reading this correctly: A.call() calls B.call(), which in turn returns C. This is 2 canister calls.

Same subnet calls take 2 seconds (1 round of consensus). So if the canisters are in the same subnet, it would take 4 seconds (2 rounds of consensus) to complete.

Different subnet calls take 4 seconds (2 rounds of consensus: 1 to sign and send the message to the other subnet, 1 for the other subnet to sign the response). If the canisters are all on different subnets, it would take 8 seconds (4 rounds of consensus) to complete.

> 3. Is possible to realize an intercanister call in query mode?

No, as intercanister calls require consensus and query calls run without consensus.
