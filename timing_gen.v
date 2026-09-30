//==============================================================================
// Project Name : RTL_digital_alarm_clk
// File Name    : timing_gen.v
// Module Name  : timing_gen
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
 
 module timing_gen(clk,reset,reset_count,fast_watch,one_minute,one_second);

 input clk;
 input reset;
 input reset_count;
 input fast_watch;
 output one_minute;
 output one_second;
 

 reg [13:0] count;
 //reg [13:0] count_sec;
 reg one_second;
 reg one_minute;
 reg one_minute_reg;

 always @(posedge clk or posedge reset) begin
  if(reset) begin 
    count<=14'b0;
    one_minute_reg <=1'b0;
    one_second <=1'b0;
  end
  else if(reset_count) begin 
    count <=14'b0;
    one_minute_reg <=1'b0;
    one_second <= 1'b0;
  end

  else if(count[13:0]==14'd15359)
  begin 
    count <=14'b0;
    one_minute_reg <= 1'b1;
    one_second <= 1'b1;
  end
  else begin 
    count <= count + 1'b1;
    one_minute_reg <=1'b0;
    one_second <=1'b0;
  end
end


/*always @(posedge clk or posedge reset) begin 
   if(reset) begin 
    one_second <=1'b0;
  end
  else if(reset_count) begin 
    one_second <=1'b0;
  end
  else if(count[7:0]==8'd255) begin 
    one_second <=1'b1;
  end
  else one_second <=1'b0;
end */



  always @(*) begin
    if(fast_watch)
     one_minute=one_second;
   else one_minute =one_minute_reg;
  end
 endmodule