.section .boot
boot:
@ these are actually jump instructions
	ldr pc,reset_handler
	ldr pc,undef_handler
	ldr pc,swint_handler
	ldr pc,epref_handler
	ldr pc,edata_handler
	ldr pc,resvd_handler
	ldr pc,doirq_handler
	ldr pc,dofiq_handler
@ these are jump targets
reset_handler: .word init
undef_handler: .word here
swint_handler: .word here
epref_handler: .word here
edata_handler: .word here
resvd_handler: .word here
doirq_handler: .word irqh
dofiq_handler: .word here
init:
@ moving (overriding) interrupt vector table
	mov r0,#0x8000
	mov r1,#0x0000
@ copying the jmp instructions
	ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
	stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
@ copying the jmp targets
	ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
	stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
doit:
@ get to business
	mov sp,#0x00008000
	bl main
here:
	b here

.globl enable_irq
enable_irq:
	mrs r0,cpsr
	bic r0,r0,#0x80
	msr cpsr_c,r0
	bx lr

irqh:
	push {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
	bl irq_handler
	pop  {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
	subs pc,lr,#4