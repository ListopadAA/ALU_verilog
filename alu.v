module alu_register #(
    parameter WIDTH = 8
)(
    input clk_i,
    input arstn_i,
    input [WIDTH-1:0] first_i,
    input [WIDTH-1:0] second_i,
    input [2:0] opcode_i,
    output [WIDTH-1:0] result_o
);

reg [WIDTH-1:0] d_ff;

always @(posedge clk_i or negedge arstn_i)
begin
    if (!arstn_i) begin
        d_ff <= {WIDTH{1'b0}};
    end else begin
        case (opcode_i)
        3'b000: d_ff <= ~(first_i | second_i);
        3'b001: d_ff <= (first_i & second_i);
        3'b010: d_ff <= $signed(first_i) + $signed(second_i);
        3'b011: d_ff <= first_i + second_i;
        3'b100: d_ff <= ~(second_i);
        3'b101: d_ff <= ~(first_i ^ second_i);
        3'b110: d_ff <= (first_i == second_i);
        3'b111: d_ff <= (first_i >> second_i);
        endcase
    end
end

assign result_o = d_ff;

endmodule