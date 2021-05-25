module ID (
    input pc_i,
    input rst,
    input [31:0]inst_i,
    input[31:0] reg1_data,
    input[31:0] reg2_data,
    //一堆使能信号this is used to control the regfile
    output reg reg1_read_o,
    output reg reg2_read_o,
    output reg[4:0] reg1_addr,
    output reg[4:0] reg2_addr,
    
    //this is used to send the message to exe
    output reg[7:0] aluop_o,
    output reg[2:0] alusel_o,
    output reg[31:0] reg1_o,
    output reg[31:0] reg2_o,
    output reg[4:0] wd_o,//写入的目标寄存器的地址
    output reg      wreg_o//译玛阶段是否有要写入的寄存器
);
    wire[5:0] op = inst_i[31:26];
    wire[4:0] op2 = inst_i[10:6];
    wire[5:0] op3 = inst_i[5:0];
    wire[4:0] op4 = inst_i[20:16];
    reg[15:0] imm;
    reg instvalid;
always @(*)begin
    if(rst == 1'b1)begin
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr <= 5'h0;
            reg2_addr <= 5'h0;
            aluop_o <= 8'h0;
            alusel_o <= 3'h0;
            //reg1_o <= 32'h0;
            //reg2_o <= 32'h0;
            //我尚且不清楚复位如果在不同的块和相同的块里面操作会怎么样
            wd_o <= 4'h0;
            wreg_o <= 1'b0;
            imm <= 32'h0;
            instvalid <= 1'b0;
    end
    else begin
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr <= inst_i[25:21];
            reg2_addr <= inst_i[20:16];
            aluop_o <= 8'h0;
            alusel_o <= 3'h0;
            wd_o <= inst_i[15:11];
            wreg_o <= 1'b0;
            imm <= 32'h0;
            instvalid <= 1'b0;
            
            case (op)
                6'b001101: begin
                    wreg_o <= 1'b1;
                    ////////////////////////////////////
                    aluop_o <= 1'b1; 
                    aiusel_o <= ;
                    ////////////////////////////////////
                    reg1_read_o <= 1'b1;
                    reg2_read_o <= 1'b0;

                    imm <= {16'h0,inst_i[15:0]};
                    wd_o <= inst_o[20:16];
                    instvalid <= 1'b1;
                end
                default :begin
                end
            endcase

    end
end    
always @(*)begin
    if(rst == 1'b1)begin
        reg1_o <= 32'h0;
        reg2_o <= 32'h0;
    end
end

endmodule
