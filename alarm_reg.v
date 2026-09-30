//==============================================================================
// Project Name : RTL_digital_alarm_clk
// File Name    : alarm_reg.v
// Module Name  : alarm_reg
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

module alarm_reg(clk,reset,load_new_a,new_alarm_ms_hr,new_alarm_ms_min,new_alarm_ls_min,new_alarm_ls_hr,
                alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min);

input clk;
input reset;
input load_new_a;
input [3:0] new_alarm_ms_hr,
            new_alarm_ms_min,
            new_alarm_ls_hr,
            new_alarm_ls_min;

output reg [3:0] alarm_time_ms_hr,
                 alarm_time_ls_hr,
                 alarm_time_ms_min,
                 alarm_time_ls_min;

 always @(posedge clk or posedge reset) begin
  if(reset) begin 
    alarm_time_ms_hr <=0;
    alarm_time_ls_hr <=0;
    alarm_time_ms_min <=0;
    alarm_time_ls_min <=0;
  end
  else if(load_new_a) begin 
    alarm_time_ms_hr <= new_alarm_ms_hr;
    alarm_time_ls_hr <=new_alarm_ls_min;
    alarm_time_ms_min <=new_alarm_ms_min;
    alarm_time_ls_min <= new_alarm_ls_min;
  end
 end
endmodule