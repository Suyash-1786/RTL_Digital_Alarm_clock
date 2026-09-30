# RTL_Digital_Alarm_clock

A modular digital alarm clock designed using Verilog HDL and developed using Intel Quartus Prime.

## Features

- Digital timekeeping
- Alarm setting and triggering
- Timing generation
- Counter-based time management
- FSM-based control
- Seven-segment display interface
- Reset functionality
- Fast-watch/testing mode

## RTL Architecture

             ┌─────────────────┐
             │   Clock Input   │
             └────────┬────────┘
                      ↓
             ┌─────────────────┐
             │   Timing Gen    │
             └────────┬────────┘
                      ↓
        ┌─────────────┴─────────────┐
        ↓                           ↓
 ┌──────────────┐           ┌──────────────┐
 │ Time Counter │           │ Alarm Register│
 └──────┬───────┘           └──────┬───────┘
        │                          │
        └──────────┬───────────────┘
                   ↓
          ┌─────────────────┐
          │ Control / FSM   │
          └────────┬────────┘
                   ↓
          ┌─────────────────┐
          │ Display Driver  │
          └────────┬────────┘
                   ↓
            7-Segment Display


## Modules

| Module | Function |
|---|---|
| `alarm_clk_top` | Top-level integration |
| `timing_gen` | Generates timing pulses |
| `counter` | Maintains current time |
| `alarm_reg` | Stores alarm time |
| `fsm_control` | Controls system operation |
| `display_driver_4` | Controls four-digit display |
| `display_time` | Handles digit/display output |

## Tools

- Modelsim
- VS Code
- Verilog HDL
- Intel Quartus Prime

## Design Flow

Requirements → Code -> RTL Design → Module Integration → Compilation/Synthesis
