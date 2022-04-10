module fpga_rom(
    input CLK100MHZ,
    input oeb,
    input [13:0] addr,
    output reg [7:0] data,
    output reg [7:0] out,
    output reg led_oeb
    );
    
    reg [7:0] rom[0:16384];    
    reg [13:0] addr_value;
    reg [7:0] data_value;
    
    initial begin
        $readmemh("rom.hex", rom);
    end
    
    always @(posedge CLK100MHZ) begin
        if (oeb == 0) begin
            led_oeb <= 1;
            addr_value <= addr;
            data_value <= rom[addr_value];
        end else begin
            led_oeb <= 0;
            data_value <= 0;
        end
        data = data_value;
        out = data_value;
    end
endmodule
