//对于寄存器才是两读一写
//写和读都是需要使能信号
module regfile (
    input clk,
    input rst,
    //write
    input we,
    input [4:0]waddr,
    input [31:0]wdata,
    //read
    input re1, 
    input [4:0]raddr1,
    output reg[31:0]rdata1,

    input re2,
    input [4:0]raddr2,
    output reg[31:0]rdata2,
);              
reg[31:0] regs[0:31];

    always @(posedge clk)begin
        if(rst == 1'b0)begin
            if((we == 1'b1) && (waddr!=5'h0))begin
                regs[waddr] <= wdata;                 
            end
        end
    end


    always @(*) begin
        if(rst == 1b'1)begin
            rdata1 <= 32'h00000000;     
        end
        else begin
            //可能冲突
            if(
                (re1 == 1'b1) && 
                (raddr1 == waddr) &&
                (we == 1'b1)
            )begin
                rdata1  <= wdata;
            end
            else begin
                if(re1 == 1'b1) begin
                    rdata1 <= regs[raddr1];
            end
            else begin
                rdata1 <= 32'h00000000;
            end 
        end 
    end

       always @(*) begin
        if(rst == 1b'1)begin
            rdata2 <= 32'h00000000;     
        end
        else begin
            //可能冲突
            if(
                (re2 == 1'b1) && 
                (raddr2 == waddr) &&
                (we == 1'b1)
            )begin
                rdata2  <= wdata;
            end
            else begin
                if(re2 == 1'b1) begin
                    rdata2 <= regs[raddr1];
            end
            else begin
                rdata2 <= 32'h00000000;
            end 
        end 
    end
endmodule