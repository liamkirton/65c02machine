;
; IRQ handling stub
;

        .export         initirq, doneirq

; ------------------------------------------------------------------------

.segment        "ONCE"

initirq:
        rts

; ------------------------------------------------------------------------

.code

doneirq:
        rts
