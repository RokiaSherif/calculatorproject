org 100h

LetsGo:
    lea dx,hello
    mov ah,9
    int 21h
    
    lea dx,msg
    mov ah,9
    int 21h
    ;determine the operation
    mov ah,0
    int 16h 
    
    cmp al,"+"
    je Addition
    cmp al,"-"
    je Subtraction
    cmp al,"*"
    je Multiplication
    cmp al,"/"
    je Division 
    
    ;if there is something error
    lea dx,msg3
    mov ah,9
    int 21h
    mov ah,0
    int 16h
    jmp LetsGo
    
Addition: 
     lea dx,msg6
     mov ah,9
     int 21h
     lea dx,msg1
     mov ah,9
     int 21h
     mov cx,0 ;counter for digits
     call EnterNumber
     push dx
     lea dx,msg2
     mov ah,9
     int 21h 
     mov cx,0
     call EnterNumber
     pop bx
     add dx,bx
     push dx
     lea dx,msg4
     mov ah,9
     int 21h
     pop dx
     ;view on screen
     ;the maximum number can calculate 10000
     mov cx,10000
     call ShowResult
     jmp end 

            
Subtraction:
     lea dx,msg7
     mov ah,9
     int 21h
     lea dx,msg1
     mov ah,9
     int 21h
     mov cx,0 ;counter for digits
     call EnterNumber
     push dx
     lea dx,msg2
     mov ah,9
     int 21h 
     mov cx,0
     call EnterNumber
     pop bx
     sub bx,dx
     mov dx,bx
     push dx
     lea dx,msg4
     mov ah,9
     int 21h
     pop dx
     ;view on screen
     ;the maximum number can calculate 10000
     mov cx,10000
     call ShowResult
     jmp end 
    
Multiplication:
     lea dx,msg8
     mov ah,9
     int 21h
     lea dx,msg1
     mov ah,9
     int 21h
     mov cx,0 ;counter for digits
     call EnterNumber
     push dx
     lea dx,msg2
     mov ah,9
     int 21h 
     mov cx,0
     call EnterNumber
     pop bx
     mov ax,dx
     mul bx
     mov dx,ax
     push dx
     lea dx,msg4
     mov ah,9
     int 21h
     pop dx
     ;view on screen
     ;the maximum number can calculate 10000
     mov cx,10000
     call ShowResult
     jmp end 

Division:
     lea dx,msg9
     mov ah,9
     int 21h
     lea dx,msg1
     mov ah,9
     int 21h
     mov cx,0 ;counter for digits
     call EnterNumber
     push dx
     lea dx,msg2
     mov ah,9
     int 21h 
     mov cx,0
     call EnterNumber
     pop bx 
     mov ax,bx
     mov cx,dx
     mov dx,0
     div cx
     mov dx,ax
     push dx
     lea dx,msg4
     mov ah,9
     int 21h
     pop dx
     ;view on screen
     ;the maximum number can calculate 10000
     mov cx,10000
     call ShowResult
     jmp end 

EnterNumber:
          ;accept number from user
          mov ah,0
          int 16h
          mov dx,0
          mov bx,1
          ;to check if user press enter 
          cmp al,0dh
          je  MakeNumber
          ;convert from ascii to decimal
          sub ax,30h
          call ShowNumber
          mov ah,0
          push ax
          inc cx
          jmp Enternumber
          
MakeNumber:
         ;we store each number seprately in stack like (659) 9*1+0=9 5*10+9=59 6*100+59=659
         pop ax
         push dx
         mul bx
         pop dx
         add dx,ax
         mov ax,bx
         mov bx,10 
         push dx
         mul bx 
         pop dx
         mov bx,ax
         dec cx
         cmp cx,0
         jne MakeNumber
         RET  

ShowNumber:
        push ax
        push dx
        mov dx,ax
        ;convert back into ascii
        add dl,30h
        mov ah,2
        int 21h
        pop dx
        pop ax
        RET

ShowResult:
       mov ax,dx
       mov dx,0
       div cx
       call ShowNumber
       mov bx,dx
       mov dx,0
       mov ax,cx
       mov cx,10
       div cx
       mov dx,bx
       mov cx,ax
       cmp ax,0
       jne ShowResult
       RET
       
end: 
    lea dx,msg5
    mov ah,9
    int 21h 
    lea dx,team
    mov ah,9
    int 21h
    RET   
     
  
hello: db "Start To Use The Simple Calculator$"  
msg: db 0dh,0ah, "+ for Addition",0dh,0ah,"- for Subtraction",0dh,0ah,"* for Multiplication",0dh,0ah,"/ for Division",0dh,0ah,"$"
msg1: db 0dh,0ah,"Enter The First Number: $"
msg2: db 0dh,0ah,"Enter The Second number: $"
msg3: db 0dh,0ah,"Error In Your Choice$" 
msg4: db 0dh,0ah,"The Result: $"
msg5: db 0dh,0ah,"Thank You For Using The Calculator$"     
team: db 0dh,0ah,"Our Team:",0dh,0ah,"Rokia Sherif",0dh,0ah,"Rawan Elshenawy",0dh,0ah,"Rawan Wael",0dh,0ah,"$"
msg6: db 0dh,0ah,"The Selected operation is Addition$"    
msg7: db 0dh,0ah,"The Selected operation is Subtraction$"                                                       
msg8: db 0dh,0ah,"The Selected operation is Multiplication$"
msg9: db 0dh,0ah,"The Selected operation is Division$"                                                       
ret




