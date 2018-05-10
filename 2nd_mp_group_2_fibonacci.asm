org 100h 
]

.data
msg1 db , 0dh , 0ah , "please enter the number of elements in the sequence :$"
msg2 db , 0dh , 0ah , "please enter suitable number in the range of [1-25] :$"
N   dw ?           ; the number enterd by user
N1  dw ?   
N2  dw ?
N3  dw ?           
 X  DB ?
 Y  DB ?                  
 Z  Dw ?
 
.code       
 
start:
lea  dx ,  msg1     ; print msg1
mov  ah ,  9h
int  21h
jmp  input


again:
lea  dx,  msg2      ; print msg2
mov  ah,  9h
int  21h


input:    
 ;mov  sp , 0 
mov  cl , 0

entering_num:
         
mov  ah , 1h        
int  21h            ; enter the firt digit 
cmp  al , 0Dh 
je   fullnum
sub  al , 48  
mov  ah , 0
push ax
 
inc  cl 
jmp  entering_num

fullnum:
mov  ah , 0
mov  Z  , 1
mov  ax , Z 
mov  bX , 0
mov  N  , 0

repet:
pop  bx
mul  bx
add  ax , N 
mov  N  , ax
mov  ax ,Z 
dec  cl 
cmp  cl , 0 
je   comparison: 
mov  dx , 10
mul  dx
mov  Z , ax   
jmp  repet  
 
comparison:

cmp  N , 25        ; N ) 25
ja   again        
cmp  N , 0         ; N ( 0
jb   again       
je   finish        ; N = 0
           
mov  ah , 0eh       ;new_line
mov  al , 0dh   
int  10h    
mov  al , 0ah
int  10h


;fibonacci 


mov  dl , 0
add  dl , 48      
mov  ah , 2h        
int  21h            ;print 0
dec  N 
cmp  N  , 0  
je   new_line

mov  dl , 44        ;comma
mov  ah , 2h
int  21h
 
mov  dx , 1
add  dx , 48
mov  ah , 2h        
int  21h            ;print 1
dec  N 
cmp  N  , 0 
je   new_line  

mov  dl , 44        
mov  ah , 2h
int  21h            ;comma

mov  N1 , 0
mov  N2 , 1        
mov  N3 , 0         ;clear N3

fibonacci:
mov  cx , N1
mov  bx , N2 
mov  dx , N3
mov  N1 , bx
add  bx , cx
mov  N2 , bx
mov  dx , bx
mov  N3 , dx 
   ;mov  sp , 0h
mov  cl , 0         ;counter for the stack

branch1:
mov  ax , 0
mov  ax , dx
mov  bx , 10
mov  dx , 0 
div  bx
add  dx , 48  
push dx             
inc  cl   
cmp  ax , 0
mov  dx , ax  
ja   branch1 

branch2:            
pop  dx  
mov  ah , 2h     
int  21h            ;print the output of the fibonacci
dec  cl   
cmp  cl , 0 
ja   branch2
dec  N 
cmp  N  , 0
ja   comma 
je   new_line   

new_line:   
mov  ah , 0eh      
mov  al , 0d 
int  10h
mov  al , 0ah
int  10h

je   start 
   
comma:   
mov  dl,44       
mov  ah,2h
int  21h
jmp  fibonacci  

finish:  
int  20h

ret