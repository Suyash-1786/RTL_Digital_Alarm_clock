//==============================================================================
// Project Name : RTL_digital_alarm_clk
// File Name    : alarm_clk_top.v
// Module Name  : alarm_clk_top
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


module alarm_clk_top(clock,key,reset,time_button,alarm_button,fastwatch,ms_hour,ls_hour,ms_minute,ls_minute,alarm_sound);

input clock,reset,time_button,alarm_button,fastwatch;

input [3:0] key;

output [7:0] ms_hour,ls_hour,ms_minute,ls_minute;

output alarm_sound;

wire one_second,one_minute,load_new_c,show_current_time,show_a,shift,reset_count;

wire [7:0] display_ms_hr,display_ls_hr,display_ms_min,display_ls_min;

wire [3:0] key_buffer_ms_hr,
           key_buffer_ls_hr,
           key_buffer_ms_min,
           key_buffer_ls_min,
           current_time_ms_hr,
           current_time_ls_hr,
           current_time_ls_min,
           current_time_ms_min,
           alarm_time_ms_hr,
           alarm_time_ls_hr,
           alarm_time_ms_min,
           alarm_time_ls_min;

timing_gen tgen1(.clk(clock),
                 .reset(reset),
                 .one_second(one_second),
                 .one_minute(one_minute),
                 .reset_count(reset_count),
                 .fast_watch(fastwatch));

counter count1(.one_minute(one_minute),
               .new_current_time_ms_hr(key_buffer_ms_hr),
               .new_current_time_ls_hr(key_buffer_ls_hr),
               .new_current_time_ms_min(key_buffer_ms_min),
               .new_current_time_ls_min(key_buffer_ls_min),
               .load_new_c(load_new_c),
               .clk(clock),
               .reset(reset),
               .current_time_ms_hr(current_time_ms_hr),
               .current_time_ls_hr(current_time_ls_hr),
               .current_time_ms_min(current_time_ms_min),
               .current_time_ls_min(current_time_ls_min)
);

alarm_reg areg1(.new_alarm_ms_hr(key_buffer_ms_hr),
                .new_alarm_ls_hr(key_buffer_ls_hr),
                .new_alarm_ms_min(key_buffer_ms_min),
                .new_alarm_ls_min(key_buffer_ls_min),
                .load_new_a(load_new_a),
                .clk(clock),
                .reset(reset),
                .alarm_time_ms_hr(alarm_time_ms_hr),
                .alarm_time_ls_hr(alarm_time_ls_hr),
                .alarm_time_ms_min(alarm_time_ms_min),
                .alarm_time_ls_min(alarm_time_ls_min)
);

aclk_keyreg keyreg1(.reset(reset),
                    .clk(clock),
                    .shift(shift),
                    .key(key),
                    .key_buffer_ms_hr(key_buffer_ms_hr),
                    .key_buffer_ls_hr(key_buffer_ls_hr),
                    .key_buffer_ms_min(key_buffer_ms_min),
                    .key_buffer_ls_min(key_buffer_ls_min)
);

fsm_control fsm1(.clk(clock),
                 .reset(reset),
                 .one_second(one_second),
                 //.one_minute(one_minute),
                 .time_button(time_button),
                 .alarm_button(alarm_button),
                 .key(key),
                 .load_new_a(load_new_a),
                 .show_a(show_a),
                 .reset_count(reset_count),
                 .show_new_time(show_current_time),
                 .load_new_c(load_new_c),
                 .shift(shift)
);

display_driver_4 lcd_disp(.alarm_time_ms_hr(alarm_time_ms_hr),
                          .alarm_time_ls_hr(alarm_time_ls_hr),
                          .alarm_time_ms_min(alarm_time_ms_min),
                          .alarm_time_ls_min(alarm_time_ls_min),
                          .current_time_ms_hr(current_time_ms_hr),
                          .current_time_ls_hr(current_time_ls_hr),
                          .current_time_ms_min(current_time_ms_min),
                          .current_time_ls_min(current_time_ls_min),
                          .key_ms_hr(key_buffer_ms_hr),
                          .key_ls_hr(key_buffer_ls_hr),
                          .key_ms_min(key_buffer_ms_min),
                          .key_ls_min(key_buffer_ls_min),
                          .show_alarm(show_a),
                          .show_current_time(show_current_time),
                          .display_ms_hr(ms_hour),
                          .display_ls_hr(ls_hour),
                          .display_ms_min(ms_minute),
                          .display_ls_min(ls_minute),
                          .sound_a(alarm_sound));

endmodule