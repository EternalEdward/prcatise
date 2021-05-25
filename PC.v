module PC(
    input clk,
    input rst,
    output reg en,
    output reg[31:0] pc
    );
    reg [31:0] pc;
    always @(posedge clk)begin
        if(rst == 1'b1)begin
            ce <= 1'b0;
        end
        else begin
            ce <= 1'b1;
        end
    end
    always @(posedge clk)begin
        if(rst == 1'b1)begin
            pc <= 32'h00000000; 
            //en <= 1'b0;
        end
        else begin
            pc <= pc + 32'h4;
            //en <= 1'b1;
        end
    end
endmodule