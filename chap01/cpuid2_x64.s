#cpuid2.s View the CPUID Vendor ID string using C library calls
#build and output(编译和输出)
#as -o cpuid2_x64.o cpuid2_x64.s
#ld -o cpuid2_x64  cpuid2_x64.o -lc -I /lib64/ld-linux-x86-64.so.2
.code64
.section .data
output:
    .asciz "The processor Vendor ID is '%s'\n"
.section .bss
    .lcomm buffer, 12
.section .text
.globl _start
_start:
    movl $0, %eax
    cpuid
    movq $buffer, %rdi
    movl %ebx, (%rdi)
    movl %edx, 4(%rdi)
    movl %ecx, 8(%rdi)

 #change the parameter to register
    movq $buffer, %rsi
    movq $output, %rdi
    call printf
 #use the c library exit
    movq $0, %rdi
    call exit
