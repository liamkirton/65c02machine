////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

constexpr uint32_t PIN_ADDR[] = { 23, 25, 27, 29, 31, 33, 35, 37, 22, 24, 26, 28, 30, 32, 34, 36 };
constexpr uint32_t PIN_DATA[] = { 39, 41, 43, 45, 47, 49, 51, 53 };
constexpr uint32_t PIN_CLK = 2;
constexpr uint32_t PIN_RWB = 38;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
    for (auto p : PIN_ADDR) {
        pinMode(p, INPUT);
    }
    for (auto p : PIN_DATA) {
        pinMode(p, INPUT);
    }

    pinMode(PIN_CLK, INPUT);
    pinMode(PIN_RWB, INPUT);

    attachInterrupt(digitalPinToInterrupt(PIN_CLK), clock, RISING);

    Serial.begin(57600);
    Serial.println("busmon");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void clock() {
    static uint32_t tick{ 0 };
    static char output[25]{ 0 };

    uint16_t addr{ 0 };
    for(uint16_t i = 0; i < 16; ++i) {
        uint16_t bit = digitalRead(PIN_ADDR[i]) ? 1 : 0;
        addr |= (bit << i);
    }

    uint16_t value{ 0 };
    for(uint16_t i = 0; i < 8; ++i) {
        uint16_t bit = digitalRead(PIN_DATA[i]) ? 1 : 0;
        value |= (bit << i);
    }

    bool write = digitalRead(PIN_RWB) == LOW;

    snprintf(output, sizeof(output) - 1, "<%08lx> [%04hx] %c %02hx\n", tick++, addr, (write ? 'w' : 'r'), value);
    Serial.print(output);

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void loop() {

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
