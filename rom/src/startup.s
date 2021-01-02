; ---------------------------------------------------------------------------
; crt0.s
; ---------------------------------------------------------------------------
;
; Startup code for cc65 (Single Board Computer version)

.export   _init, _exit
.import   _main

.export   __STARTUP__ : absolute = 1        ; Mark as startup
.import   __RAM_START__, __RAM_SIZE__       ; Linker generated

.include  "zeropage.inc"

; ---------------------------------------------------------------------------
; Place the startup code in a special segment

.segment  "STARTUP"

; ---------------------------------------------------------------------------
; A little light 6502 housekeeping

_init:    LDX     #$FF                 ; Initialize stack pointer to $01FF
          TXS
          CLD                          ; Clear decimal mode

; ---------------------------------------------------------------------------
; Set cc65 argument stack pointer

          LDA     #<(__RAM_START__ + __RAM_SIZE__)
          STA     sp
          LDA     #>(__RAM_START__ + __RAM_SIZE__)
          STA     sp+1

; ---------------------------------------------------------------------------
; Initialize memory storage

          ; JSR     zerobss              ; Clear BSS segment
          ; JSR     copydata             ; Initialize DATA segment
          ; JSR     initlib              ; Run constructors

; ---------------------------------------------------------------------------
; Call main()

PORTB = $8000
PORTA = $8001
DDRB = $8002
DDRA = $8003

E  = %00000100
RW = %00000010
RS = %00000001

    lda #%11111111
    sta DDRB

    lda #%00000111
    sta DDRA

    ;
    ; Clear display
    ;

    lda #%00000001
    sta PORTB

    lda #0
    sta PORTA

    lda #E
    sta PORTA

    lda #0
    sta PORTA

    ;
    ; Set 8-bit mode, 2-line display, 5x8 font
    ;

    lda #%00111000
    sta PORTB

    lda #0
    sta PORTA

    lda #E
    sta PORTA

    lda #0
    sta PORTA

    ;
    ; Display on, cursor on, blink off
    ;

    lda #%00001110
    sta PORTB

    lda #0
    sta PORTA

    lda #E
    sta PORTA

    lda #0
    sta PORTA

    ;
    ; Increment and shift cursor, don't shift display
    ;

    lda #%00000110
    sta PORTB

    lda #0
    sta PORTA

    lda #E
    sta PORTA

    lda #0
    sta PORTA

    JSR     _main

; ---------------------------------------------------------------------------
; Back from main (this is also the _exit entry):  force a software break

_exit:
    JMP _exit