module task1(output x, y,
    input a, b, c
    );
    
    // Wires for intermediate results
    wire w1;  // for (a | b)
    wire w2;  // for ~c
    wire w3;  // for (a & b)
    wire w4;  // for ~(a & b)
    wire w5;  // for (~(a & b)) ^ (a | b)

    // Logic for x = (a | b) ^ ~c
    or  or1(w1, a, b);     // w1 = (a | b)
    not not1(w2, c);       // w2 = ~c
    xor xor1(x, w1, w2);   // x = w1 ^ w2

    // Logic for y = (a | b) & ((~(a & b)) ^ (a | b))
    and and1(w3, a, b);    // w3 = (a & b)
    not not2(w4, w3);      // w4 = ~(a & b)
    xor xor2(w5, w4, w1);  // w5 = w4 ^ w1
    and and2(y, w1, w5);   // y = w1 & w5

endmodule