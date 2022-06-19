#include "SPI.h"

const uint32_t SPI_SPEED = 1000000 / 16;

void write_rom(uint16_t addr, uint8_t *data, uint16_t size);

void setup() {
    SPI.begin();

    pinMode(PIN_SPI_SS, OUTPUT);
    digitalWrite(PIN_SPI_SS, HIGH);

    Serial.begin(115200);
}

void loop() {
    if (Serial.available() > 0) {
        auto cmd = Serial.read();

        uint16_t address{ 0 };
        uint16_t size{ 1 };
        static uint8_t value[1024]{ 0 };

        switch(cmd) {
            case 0x00:
                Serial.readBytes(reinterpret_cast<char *>(&address), sizeof(address));
                Serial.readBytes(reinterpret_cast<char *>(&value), sizeof(value[0]));
                write_rom(address, value, 1);
                Serial.write(1);
                break;

            case 0x01:
                Serial.readBytes(reinterpret_cast<char *>(&address), sizeof(address));
                Serial.readBytes(reinterpret_cast<char *>(&size), sizeof(size));
                if (size <= sizeof(value)) {
                    Serial.readBytes(reinterpret_cast<char *>(&value), size);
                    write_rom(address, value, size);
                }
                Serial.write(1);
                break;

            case 0xff:
                Serial.write(0xfe);
                break;
        }
    }
}

void write_rom(uint16_t addr, uint8_t *data, uint16_t size) {
    SPI.beginTransaction(SPISettings(SPI_SPEED, MSBFIRST, SPI_MODE0));
    digitalWrite(PIN_SPI_SS, LOW);

    for(uint16_t i = 0; i < size; i++) {
        SPI.transfer(static_cast<uint8_t>(((addr + i) & 0xff00) >> 8));
        SPI.transfer(static_cast<uint8_t>((addr + i) & 0x00ff));
        SPI.transfer(static_cast<uint8_t>(data[i]));
    }

    digitalWrite(PIN_SPI_SS, HIGH);
    SPI.endTransaction();
}
