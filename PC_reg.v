module PC_reg (
    input clk,
    input rst,
    input pc, 
    output reg[31:0]Q 
);
always @(posedge clk or rst)begin
    if(rst == 1'b1)begin
        Q <= 32'h00000000;
    end
    else begin
        Q <= pc; 
    end
end
endmodule