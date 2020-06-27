 ;https://en.wikibooks.org/wiki/X86_Disassembly/Functions_and_Stack_Frames
 ;https://msdn.microsoft.com/en-us/library/zxk0tw93.aspx
 ;https://msdn.microsoft.com/en-us/library/zkwh89ks.aspx
 global Main
    extern  _GetStdHandle@4
    extern  _WriteFile@20
    extern  _ExitProcess@4

    section .text
; message, length
PrintMessage:
    push ebp
    mov ebp, esp
    ;DWORD bytes
    sub esp, 4    
    ; hStdOut = __stdcall GetstdHandle(STD_OUTPUT_HANDLE)
    push    -11
    call    _GetStdHandle@4
    mov     ebx, eax
    ; __stdcall WriteFile(hstdOut, message, length(message), &bytes, 0);
    push    0
    lea     eax, [ebp-4]
    push    eax
    push    DWORD [ebp + 12]
    push    DWORD [ebp + 8]
    push    ebx
    call    _WriteFile@20

    mov esp, ebp
    pop ebp
    ret 4
Main:
    mov     ebp, esp
    sub     esp, 0

    ; __cdecl PrintMessage(message1_end - message1, message1)
    push    (message1_end - message1)
    push    message1
    call PrintMessage
    pop eax
    pop eax

    ; __cdecl PrintMessage(message2_end - message2, message2)
    push    (message2_end - message2)
    push    message2
    call PrintMessage
    pop eax
    pop eax

    ; __stdcall ExitProcess(0)
    push    0
    call    _ExitProcess@4

    ; never here
    hlt
message1:
    db      'Hello, World', 10
message1_end:
message2:
    db      'Awesome!', 10
message2_end: