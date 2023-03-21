module PCincrement(
    input IncPC,
    input [31:0] inputPC,
    output reg[31:0] newPC
);

initial newPC = 0;

always@(IncPC)begin
   if (IncPC)
     newPC = inputPC + 1;
end
endmodule
