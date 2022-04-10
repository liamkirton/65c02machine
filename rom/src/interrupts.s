; ---------------------------------------------------------------------------
; interrupts.s
; ---------------------------------------------------------------------------
;
; Interrupt handling.
;

.import _brk, _init
.export initirq, doneirq

; ------------------------------------------------------------------------
; IRQ handling
; ------------------------------------------------------------------------

.segment "CODE"

; NMI and IRQ service routines

_nmi_isr:
    RTI                    ; Return from all NMI interrupts

_irq_isr:
    PHX                    ; Save X register contents to stack
    TSX                    ; Transfer stack pointer to X
    PHA                    ; Save accumulator contents to stack
    INX                    ; Increment X so it points to the status
    INX                    ;   register value saved on the stack
    LDA $100,X             ; Load status register contents
    AND #$10               ; Isolate B status bit
    BNE break              ; If B = 1, BRK detected

endirq:
    PLA
    PLX
    RTI

break:
    JSR _brk
    JMP endirq 

; ------------------------------------------------------------------------
; cc65 IRQ handling stubs
; ------------------------------------------------------------------------

.segment "ONCE"

initirq:
    RTS

.segment "CODE"

doneirq:
    RTS

; ---------------------------------------------------------------------------
; Defines the interrupt vector table.
; ---------------------------------------------------------------------------

.segment  "VECTORS"

.addr      _nmi_isr    ; NMI vector
.addr      _init       ; Reset vector
.addr      _irq_isr    ; IRQ/BRK vector
