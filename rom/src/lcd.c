////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const unsigned char E =  0b00000100;
const unsigned char RW = 0b00000010;
const unsigned char RS = 0b00000001;

const char msg[] = "liam at int3.ws";

unsigned char *PORTB = (unsigned char *)0x8000;
unsigned char *PORTA = (unsigned char *)0x8001;
unsigned char *DDRB = (unsigned char *)0x8002;
unsigned char *DDRA = (unsigned char *)0x8003;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void message() {
    // unsigned char i;

    // *DDRB = 0b11111111;
    // *DDRA = 0b00000111;

    // // Clear display
    // *PORTB = 0b00000001;
    // *PORTA = 0;
    // //hackdelay();
    // *PORTA = E;
    // //hackdelay();
    // *PORTA = 0;

    // // Set 8-bit mode, 2-line display, 5x8 font
    // *PORTB = 0b00111000;
    // *PORTA = 0;
    // //hackdelay();
    // *PORTA = E;
    // //hackdelay();
    // *PORTA = 0;

    // // Display on, cursor on, blink off
    // *PORTB = 0b00001110;
    // *PORTA = 0;
    // //hackdelay();
    // *PORTA = E;
    // //hackdelay();
    // *PORTA = 0;

    // // Increment and shift cursor, don't shift display
    // *PORTB = 0b00000110;
    // *PORTA = 0;
    // //hackdelay();
    // *PORTA = E;
    // //hackdelay();
    // *PORTA = 0;

    // for (i = 0; i < sizeof(msg) - 1; ++i) {
    //     *PORTB = msg[i];
    //     *PORTA = RS;
    //     //hackdelay();
    //     *PORTA = RS | E;
    //     //hackdelay();
    //     *PORTA = RS;
    // }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
