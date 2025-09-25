

```mermaid
flowchart TD

    subgraph CPU
        CU[Control Unit<br/>(Instruction Decoder + Control Logic)]
        RF[Register File]
        ALU[ALU<br/>(Adders, Subtractors, Logic Ops)]

        CU --> RF
        RF --> ALU
        ALU --> RF
    end

    subgraph MemorySubsystem
        DEC[Binary Address Decoders]
        MEM[Main Memory]
        DEC --> MEM
    end

    CU --> DEC
    ALU --> DEC
    DEC --> CU
```
