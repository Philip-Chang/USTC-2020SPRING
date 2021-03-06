`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB
// Engineer: Huang Yifan (hyf15@mail.ustc.edu.cn)
// 
// Design Name: RV32I Core
// Module Name: ALU
// Tool Versions: Vivado 2017.4.1
// Description: Arithmetic and logic computation module
// 
//////////////////////////////////////////////////////////////////////////////////

//  功能说明
    //  算数运算和逻辑运算功能部件
// 输入
    // op1               第一个操作数
    // op2               第二个操作数
    // ALU_func          运算类型
// 输出
    // ALU_out           运算结果
// 实验要求
    // 补全模块

`include "Parameters.v"   
module ALU(
    input wire [31:0] op1,
    input wire [31:0] op2,
    input wire [3:0] ALU_func,
    output reg [31:0] ALU_out
    );

    wire signed [31:0] op1Signed = $signed(op1);
    wire signed [31:0] op2Signed = $signed(op2);

    always@(*)
    begin
        case(ALU_func)
            `SLL: ALU_out <= (op1 << (op2[4:0]));
            `SRL: ALU_out <= (op1 >> (op2[4:0]));
            `SRA: ALU_out <= (op1Signed >>> (op2[4:0]));
            /*
            `SRA:
                begin
                    if(op1[31] == 1)
                        begin
                            ALU_out <= (op1 >> op2[4:0]) ^~ (32'b1 >> op2[4:0]);
                        end
                    else
                        begin
                            ALU_out <= op1 >> op2[4:0];
                        end
                end
            */
            `ADD: ALU_out <= op1 + op2;
            `SUB: ALU_out <= op1 - op2;
            `XOR: ALU_out <= op1 ^ op2;
            `OR:  ALU_out <= op1 | op2;
            `AND: ALU_out <= op1 & op2;
            `SLT: ALU_out <= op1Signed < op2Signed ? 32'd1 : 32'd0;
            `SLTU:ALU_out <= op1 < op2 ? 32'd1 : 32'd0;
            /*
                begin
                    if((op1[31]==1 && op2[31]==0) || (op1[31]==1 && op2[31]==1 && op1>op2) || (op1[31]==0 && op2[31]==0 && op1<op2))
                        begin
                            ALU_out <= 32'd1;
                        end
                    else
                        begin
                            ALU_out <= 32'd0;
                        end
                end
            `SLTU:
                begin
                    if(op1 < op2)
                        begin
                            ALU_out <= 32'd1;
                        end
                    else
                        begin
                            ALU_out <= 32'd0;
                        end
                end
            */
            `LUI: ALU_out <= op2;
            default: ALU_out <= 32'hxxxxxxxx;
        endcase
    end
    // TODO: Complete this module

endmodule

