//==============================================================================
// Project Name : RTL_digital_alarm_clk
// File Name    : fsm_control.v
// Module Name  : fsm_control
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


module fsm_control(one_second,reset_count,clk,reset,alarm_button,time_button,key,load_new_c,show_new_time,show_a,load_new_a,shift);
 
input one_second;
//input reset_count;
input clk,reset;
input alarm_button;
input time_button;
input [3:0] key;

output load_new_a,
       load_new_c,
       shift,
       show_a,
       show_new_time,
       reset_count;

    reg [2:0] pre_state,next_state;
    wire timeout;
    reg [3:0] count1,count2;

parameter SHOW_TIME = 3'b000;
parameter KEY_ENTRY = 3'b001;
parameter KEY_STORED = 3'b010;
parameter SHOW_ALARM = 3'b011;
parameter SET_ALARM_TIME = 3'b100;
parameter SET_CURRENT_TIME = 3'b101;
parameter KEY_WAITED = 3'b110;
parameter NOKEY = 10;

always @(posedge clk or posedge reset) begin 
    if(reset)
    count1 <= 4'd0;

    else if(!(pre_state==KEY_ENTRY))
    count1 <=0;

    else if(count1==9)
    count1 <= 4'd0;

    else if(one_second)
    count1 <= count1 + 1'b1;
end

always @(posedge clk or posedge reset) begin 
    if(reset)
    count2 <= 4'd0;

    else if(!(pre_state==KEY_WAITED))
    count2 <=4'd0;

    else if(count2==9)
    count2 <= 4'd0;

    else if(one_second)
    count2 <= count2 + 1'b1;
end

assign time_out = ((count1==9) || (count2==9))?0:1;

always @(posedge clk or posedge reset) begin 
    if(reset)
     pre_state <= SHOW_TIME;
    else pre_state <= next_state; 
end

always @(pre_state or key or alarm_button or time_button or time_out) begin 
    case(pre_state) 
    SHOW_TIME : begin 
        if(alarm_button) next_state = SHOW_ALARM;
        else if(key != NOKEY) next_state = KEY_STORED;
        else next_state=SHOW_TIME;
    end
    KEY_STORED : begin 
        next_state =KEY_WAITED;
    end
    KEY_WAITED : begin 
        if(key == NOKEY) next_state = KEY_ENTRY;
        else if(time_out==0) next_state = SHOW_TIME;
        else next_state = KEY_WAITED;
    end
    KEY_ENTRY : begin 
        if(alarm_button) next_state = SET_ALARM_TIME;
        else if(time_button) next_state = SET_CURRENT_TIME;
        else if(time_out == 0) next_state = SHOW_TIME;
        else if(key != NOKEY) next_state = KEY_STORED;
        else next_state = KEY_ENTRY;
    end
    SHOW_ALARM : begin 
        if(!alarm_button) next_state = SHOW_TIME;
        else next_state = SHOW_TIME;
    end
    SET_ALARM_TIME : begin 
        next_state = SHOW_TIME;
    end
    SET_CURRENT_TIME : next_state = SHOW_TIME;
    default : next_state = SHOW_TIME;

    endcase
end

assign show_new_time = (pre_state == KEY_ENTRY ||
                        pre_state == KEY_STORED||
                        pre_state == KEY_WAITED)? 1 : 0;

assign show_a = (pre_state == SHOW_ALARM) ? 1: 0;
assign load_new_a =(pre_state == SET_ALARM_TIME) ? 1 :0;
assign load_new_c =(pre_state == SET_CURRENT_TIME) ? 1 :0;
assign reset_count = (pre_state == SET_CURRENT_TIME) ? 1 :0;
assign shift = (pre_state == KEY_STORED) ? 1 :0;                    

endmodule