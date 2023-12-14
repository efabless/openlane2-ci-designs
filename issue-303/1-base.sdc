# Clock network
create_clock -period 15 -name clk [get_ports {clk}]
create_clock -period 15 -name clk_always_on [get_ports {clk_always_on}]

# Clock non-idealities
set_propagated_clock [all_clocks]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINTY) [all_clocks]
puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINTY)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [all_clocks]
puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"

# Maximum transition time for the design nets
set_max_transition 1.1 [current_design]
puts "\[INFO\]: Setting maximum transition to: 1.1"

# Maximum fanout
set_max_fanout 16 [current_design]
puts "\[INFO\]: Setting maximum fanout to: 16"

# Timing paths delays derate
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]
puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"

# Input delays
set_input_delay -max 10 -clock [get_clocks {clk}] [all_inputs]
set_input_delay -min 1 -clock [get_clocks {clk}] [all_inputs]
set_input_delay -max 10 -clock [get_clocks {clk_always_on}] [all_inputs]
set_input_delay -min 1 -clock [get_clocks {clk_always_on}] [all_inputs]

# Reset input delay
set_input_delay 4 -clock [get_clocks {clk}] [get_ports {rst_n}]
set_input_delay 4 -clock [get_clocks {clk_always_on}] [get_ports {rst_n}]

# Input Transition
set_input_transition -max 0.40  [all_inputs]
set_input_transition -min 0.05  [all_inputs]

# Output delays
set_output_delay -max 10 -clock [get_clocks {clk}] [all_outputs]
set_output_delay -min 1 -clock [get_clocks {clk}] [all_outputs]
set_output_delay -max 10 -clock [get_clocks {clk_always_on}] [all_outputs]
set_output_delay -min 1 -clock [get_clocks {clk_always_on}] [all_outputs]

# Output loads
set_load 0.19 [all_outputs]
