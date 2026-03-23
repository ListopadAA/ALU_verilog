`timescale 1ns/1ps
module alu_register_tb();

localparam WIDTH = 8;

reg              clk_i;
reg              arstn_i = 1'b1;
reg  [WIDTH-1:0] first_i;
reg  [WIDTH-1:0] second_i;
reg        [2:0] opcode_i;
wire [WIDTH-1:0] result_o;


alu_register #(
    .WIDTH(WIDTH)
) alu_register_inst (
    .clk_i   (clk_i   ), 
    .arstn_i (arstn_i ), 
    .first_i (first_i ),
    .second_i(second_i),
    .opcode_i(opcode_i),
    .result_o(result_o)
);

always begin 
    clk_i = 1'b0; #1;
    clk_i = 1'b1; #1;
end

initial begin
    $dumpvars;
    @(posedge clk_i); #0.5;
    arstn_i = 1'b0;
    #3;
    @(posedge clk_i); #0.5;
    arstn_i = 1'b1;

    // NOR
    first_i  = 8'b10101010;
    second_i = 8'b11001100;
    opcode_i = 3'b000;
    @(posedge clk_i); #0.5;
    
    // AND
    opcode_i = 3'b001;
    @(posedge clk_i); #0.5;
    
    // Signed addition
    first_i  = 8'b11111110;
    second_i = 8'b00000001;
    opcode_i = 3'b010;
    @(posedge clk_i); #0.5;
    
    // Unsigned addition
    opcode_i = 3'b011;
    @(posedge clk_i); #0.5;
    
    // NOT second
    first_i  = 8'bxxxxxxxx; 
    second_i = 8'b11001100;
    opcode_i = 3'b100;
    @(posedge clk_i); #0.5;

    // NOT XOR
    first_i  = 8'b10101010;
    second_i = 8'b11001100;
    opcode_i = 3'b101;
    @(posedge clk_i); #0.5;
    
    // Equality (equal)
    first_i  = 8'b10101010;
    second_i = 8'b10101010;
    opcode_i = 3'b110;
    @(posedge clk_i); #0.5;
    
    // Equality (not equal)
    second_i = 8'b11001100;
    @(posedge clk_i); #0.5;
    
    // Shift right
    first_i  = 8'b10101010;
    second_i = 8'b00000010;
    opcode_i = 3'b111;
    @(posedge clk_i); #0.5;

    @(posedge clk_i); #0.5;

    $finish;
end
endmodule