module fpga_rom(
    input CLK100MHZ,
    input oeb,
    input [13:0] rom_addr,
    output reg [7:0] rom_data,
    output reg [7:0] led_data,
    output led_oeb,
    output led_reset_vector,
    output led_spi,
    input spi_clk,
    output reg [0:0] spi_cipo,
    input spi_copi,
    input spi_cs
    );
    
    integer rom_index;
    localparam [16:0] ROM_SIZE=16384;

    reg [3:0] clk_scaler;

    reg [7:0] rom[0:ROM_SIZE];
    
    reg [0:0] spi_flag_active;
    reg [0:0] spi_flag_copi_clk_read;

    reg [2:0] spi_read_bit_index;
    reg [1:0] spi_read_byte_index;
    reg [13:0] spi_read_addr;
    reg [7:0] spi_read_value;

    initial begin
        for (rom_index = 0; rom_index < ROM_SIZE; rom_index = rom_index + 1) begin
            rom[rom_index] = 0;
        end

        clk_scaler <= 0;
        
        spi_flag_active = 0;
        spi_flag_copi_clk_read = 0;

        spi_read_bit_index = 0;
        spi_read_byte_index = 0;
        spi_read_addr = 0;
        spi_read_value = 0;
    end
    
    assign led_oeb = oeb == 0;
    assign led_reset_vector = (rom_addr == 14'h3ffc) || (rom_addr == 14'h3ffd);
    assign led_spi = spi_flag_active == 1;
    
    always @(posedge CLK100MHZ) begin
        clk_scaler <= clk_scaler + 1;
        if (clk_scaler == 4'hf) begin
            if (~spi_cs) begin
                if (spi_flag_active == 0) begin
                    spi_flag_active <= 1;
                    spi_flag_copi_clk_read <= 0;
                    
                    spi_read_bit_index <= 0;
                    spi_read_byte_index <= 0;
                    spi_read_addr <= 0;
                    spi_read_value <= 0;
                end else begin
                    if (spi_clk) begin
                        if (spi_flag_copi_clk_read == 0) begin
                            spi_flag_copi_clk_read <= 1;
                            spi_read_value <= spi_read_value | (spi_copi << (7 - spi_read_bit_index));
                        end
                    end else begin
                        if (spi_flag_copi_clk_read == 1) begin
                            spi_flag_copi_clk_read <= 0;
                            if (spi_read_bit_index == 7) begin
                                case (spi_read_byte_index)
                                    0: begin
                                           spi_read_addr <= (spi_read_value << 8);
                                           spi_read_byte_index <= 1;
                                       end                                
                                   1: begin
                                           spi_read_addr <= spi_read_addr | spi_read_value;
                                           spi_read_byte_index <= 2;
                                      end
                                   2: begin
                                          rom[spi_read_addr] <= spi_read_value;
                                          led_data <= spi_read_value;
                                          rom_data <= spi_read_value;
                                          spi_read_byte_index <= 0;
                                      end
                                endcase
                                spi_read_value <= 0;
                            end
                            spi_read_bit_index <= spi_read_bit_index + 1;
                        end
                    end
                end
            end else begin
                if (spi_flag_active == 1) begin
                    spi_flag_active <= 0;
                    spi_flag_copi_clk_read <= 0;
    
                    spi_read_bit_index <= 0;
                    spi_read_byte_index <= 0;
                    spi_read_addr <= 0;
                    spi_read_value <= 0;
                end else begin
                    if (oeb == 0) begin
                        led_data <= rom[rom_addr];
                        rom_data <= rom[rom_addr];
                    end else begin
                        led_data <= 0;
                        rom_data <= 0;
                    end
                end
            end
        end
    end
    
endmodule
