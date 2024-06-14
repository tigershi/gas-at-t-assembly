#cpuid.s Sample program to extract the processor Vendor ID
#build and output(编译和输出)
#as -o cpuid_x64.o cpuid_x64.s
#ld -o cpuid_x64 cpuid_x64.o
.code64
.section .data
output:
   .ascii "The processor Vendor ID is 'xxxxxxxxxxxx'\n"
   .equ len, . - output
.section .text
.globl _start
_start:
   movl $0, %eax
   cpuid
   movl $output, %edi
   movl %ebx, 28(%edi)
   movl %edx, 32(%edi)
   movl %ecx, 36(%edi)
# std print syscall
   movq $1, %rax
   movq $1, %rdi
   movq $output, %rsi
   movq $len, %rdx
   syscall

# SYS_EXIT syscall
   movq $0, %rdi
   movq $60,%rax
   syscall
