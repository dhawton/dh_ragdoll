dh_ragdoll

Responds to , (comma), /rag, events from other scripts (dh_ragdoll:toggle, dh_ragdoll:set(bool value)), and puts people into ragdoll when stunned until they deactivate it (see Config).

This can be implemented in seatbelt scripts, when person is thrown from vehicle, trigger the dh_ragdoll:set event with a bool value of true and this script will keep them ragdolled until they "get up".