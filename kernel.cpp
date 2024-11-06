// kernel/kernel.h
#pragma once

void kernel_main();

// kernel/kernel.cpp
#include "kernel.h"

const int VGA_WIDTH = 80;
const int VGA_HEIGHT = 25;
char* vga_buffer = (char*)0xb8000;  // Адрес видео-памяти

int terminal_row = 0;
int terminal_column = 0;
char terminal_color = 0x07;  // Серый текст на черном фоне

void terminal_putchar(char c) {
    if (c == '\n') {
        terminal_row++;
        terminal_column = 0;
    } else {
        const int index = (VGA_WIDTH * terminal_row + terminal_column) * 2;
        vga_buffer[index] = c;
        vga_buffer[index + 1] = terminal_color;
        terminal_column++;
        if (terminal_column >= VGA_WIDTH) {
            terminal_column = 0;
            terminal_row++;
        }
    }
}

void terminal_write(const char* str) {
    for (size_t i = 0; str[i] != '\0'; i++)
        terminal_putchar(str[i]);
}

extern "C" void kernel_main() {
    terminal_write("Hello, World from C++ Kernel!\n");
    while (1) {
        __asm__("hlt");  // Останавливаем процессор, чтобы ОС не завершилась
    }
}
