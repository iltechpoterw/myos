# Makefile для сборки простой ОС
CXX = x86_64-elf-g++
LD = x86_64-elf-ld
AS = nasm

CXXFLAGS = -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld -nostdlib
ASFLAGS = -f elf32

OBJDIR = obj
SRCDIR = kernel
BOOTDIR = boot

OBJS = $(OBJDIR)/boot.o $(OBJDIR)/kernel.o

all: myos.bin

$(OBJDIR)/boot.o: $(BOOTDIR)/boot.asm
	mkdir -p $(OBJDIR)
	$(AS) $(ASFLAGS) -o $@ $<

$(OBJDIR)/kernel.o: $(SRCDIR)/kernel.cpp $(SRCDIR)/kernel.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

myos.bin: $(OBJS)
	$(LD) $(LDFLAGS) -o myos.bin $(OBJS)

clean:
	rm -rf $(OBJDIR) myos.bin

run: myos.bin
	qemu-system-x86_64 -kernel myos.bin
