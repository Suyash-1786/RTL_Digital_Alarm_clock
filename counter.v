//==============================================================================
// Project Name : RTL_digital_alarm_clk
// File Name    : counter.v
// Module Name  : counter
//
// Description  : <Brief description of what this module/file does>
//
// Author       : Suyash Anil Jore
// Roll No.     : 612507153
// Organization : COEP Technological University
//
// Created On   :30/9/2026
// Last Updated : <DD-MM-YYYY>
//
// Tools        : ModelSim / QuestaSim / Quartus Prime
// Language     : Verilog-2001
//
//==============================================================================

module counter(one_minute,new_current_time_ms_hr,new_current_time_ms_min,new_current_time_ls_hr,new_current_time_ls_min,load_new_c,clk,reset,
current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min);

input one_minute;
input reset,clk;
input [3:0] new_current_time_ls_hr,new_current_time_ms_hr,new_current_time_ms_min,new_current_time_ls_min;
input load_new_c;

output reg [3:0] current_time_ms_hr,
                 current_time_ls_hr,
                 current_time_ms_min,
                 current_time_ls_min; 

always @(posedge clk or posedge reset) begin
 if(reset) begin 
    current_time_ms_hr <= 4'd0;
    current_time_ls_hr <=4'd0;
    current_time_ms_min <= 4'd0;
    current_time_ls_min <= 4'd0; 
end
else if(load_new_c) begin 
    current_time_ms_hr <= new_current_time_ms_hr;
    current_time_ls_hr <=new_current_time_ls_hr;
    current_time_ms_min <= new_current_time_ms_min;
    current_time_ls_min <= new_current_time_ls_min;
end

else if(one_minute==1) begin 
    if(current_time_ms_hr==4'd2 && current_time_ls_hr==4'd3 && current_time_ms_min==4'd5 && current_time_ls_min==4'd9) begin 
        current_time_ms_hr <=4'd0;
        current_time_ls_hr <=4'd0;
        current_time_ms_min <= 4'd0;
        current_time_ls_min <= 4'd0;
    end
    else if(current_time_ls_hr==4'd9 && current_time_ms_min==4'd5 && current_time_ls_min==4'd9) begin
       current_time_ms_hr <= current_time_ms_hr +1'd1;
       current_time_ls_hr <=4'd0;
       current_time_ms_min <= 4'd0;
       current_time_ls_min <= 4'd0;
     end
     else if(current_time_ms_min==4'd5 && current_time_ls_min==4'd9) begin
       current_time_ls_hr <=current_time_ls_hr +1'd1;
       current_time_ms_min <= 4'd0;
       current_time_ls_min <= 4'd0;
     end
     else if(current_time_ls_min==4'd9) begin
       current_time_ms_min <= current_time_ms_min +1'd1;
       current_time_ls_min <= 4'd0;
     end
     else current_time_ls_min <= current_time_ls_min +1'd1;
    end
end
endmodule