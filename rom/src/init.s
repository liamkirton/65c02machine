; ---------------------------------------------------------------------------
; init.s
; ---------------------------------------------------------------------------
;
; Init code for cc65 (Single Board Computer version)

.export   _init, _exit
.import   _main, init_interrupts

.export   __STARTUP__ : absolute = 1        ; Mark as startup
.import   __RAM_START__, __RAM_SIZE__       ; Linker generated

.import    copydata, zerobss, initlib, donelib

.include  "zeropage.inc"

; ---------------------------------------------------------------------------
; Place the init code in a special segment

.segment  "STARTUP"

; ---------------------------------------------------------------------------
; A little light 6502 housekeeping

_init:
    LDA #$01
    LDX #$00

short_loop:
    STA $A000,X
    INX
    CPX #$80
    BEQ next
    JMP short_loop

next:
    INA
    JMP short_loop

    LDX #$FF
    TXS
    CLD
    CLI

; ---------------------------------------------------------------------------
; Set cc65 argument stack pointer

    LDA #<(__RAM_START__ + __RAM_SIZE__)
    STA sp
    LDA #>(__RAM_START__ + __RAM_SIZE__)
    STA sp+1

; ---------------------------------------------------------------------------
; Initialisation

    JSR zerobss              ; Clear BSS segment
    JSR copydata             ; Initialize DATA segment
    JSR initlib              ; Run constructors
    JSR _main

; ---------------------------------------------------------------------------
; Back from main (this is also the _exit entry)

_exit:
    JMP _exit

; ---------------------------------------------------------------------------
