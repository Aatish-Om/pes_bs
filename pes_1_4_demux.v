module pes_1_4_demux (output o0 , output o1, output o2 , output o3, input [1:0] sel  , input i);
reg [3:0]y_int;
assign {o3,o2,o1,o0} = y_int;
integer k;
always @ (*)
begin
y_int = 4'b0;
	case(sel)
		3'b00 : y_int[0] = i;
		3'b01 : y_int[1] = i;
		3'b10 : y_int[2] = i;
		3'b11 : y_int[3] = i;
	endcase

end
endmodule


