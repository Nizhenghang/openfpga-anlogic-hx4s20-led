module hx4s20_led_chase(
    input  wire       CLOCK,
    output reg  [3:0] LED
);

    // HX4S20 has a 50 MHz clock on pin R7. Advance the LED every 0.2 s.
    localparam integer TICK_MAX = 10_000_000 - 1;

    reg [23:0] tick_cnt = 24'd0;
    reg [1:0]  phase    = 2'd0;

    always @(posedge CLOCK) begin
        if (tick_cnt == TICK_MAX[23:0]) begin
            tick_cnt <= 24'd0;
            phase <= phase + 2'd1;
        end else begin
            tick_cnt <= tick_cnt + 24'd1;
        end
    end

    always @(*) begin
        case (phase)
            2'd0: LED = 4'b0001;
            2'd1: LED = 4'b0010;
            2'd2: LED = 4'b0100;
            2'd3: LED = 4'b1000;
            default: LED = 4'b0000;
        endcase
    end

endmodule
