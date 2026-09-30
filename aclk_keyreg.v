//==============================================================================
// Project Name : RTL_digital_alarm_clk
// File Name    : aclk_keyreg.v
// Module Name  : aclk_keyreg
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

module aclk_keyreg(clk,reset,key,shift,key_buffer_ms_hr,key_buffer_ms_min,key_buffer_ls_hr,key_buffer_ls_min);

input clk;
input reset;
input shift;
input [3:0] key;
output reg [3:0] key_buffer_ls_hr,
                 key_buffer_ls_min,
                 key_buffer_ms_hr,
                 key_buffer_ms_min;

    always @(posedge clk or posedge reset)
    begin
     if(reset)
     begin
     key_buffer_ls_hr <=0;
     key_buffer_ls_min <=0;
     key_buffer_ms_hr <=0;
     key_buffer_ms_min <=0;
     end

     else if(shift == 1'b1)
      begin 
        key_buffer_ms_hr <=key_buffer_ls_hr;
        key_buffer_ls_hr <=key_buffer_ms_min;
        key_buffer_ms_min <=key_buffer_ls_min;
        key_buffer_ls_min <=key;
      end
    end
endmodule



