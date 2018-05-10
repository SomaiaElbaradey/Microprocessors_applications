org 100h
include 'emu8086.inc'  
define_scan_num
define_print_num_uns   
DEFINE_GET_STRING
.data 
   
msg1 db , 0dh , 0ah , "please enter the number of elementsin the array to be sorted or press 0 to terminate  :$"
msg2 db , 0dh , 0ah , "please enter suitable number in the range of [1-25] :$"
msg3 db , 0dh , 0ah , "please enter elements of the array to be sorted :$"
msg4 db , 0dh , 0ah , "enter a for ascending order or d to for descending order :$"
msg5 db , 0dh , 0ah , "the sorted array is :$"
buffer db 10,?, 10 dup(' ')  
n db ?  
y db ?  
z db ?
array dw 25 dup (?)
two db 2 
		
.code 
		
start:    

lea  dx ,  msg1
mov  ah ,  9h          ;print msg1
int  21h
jmp  input


again:                 ;print msg2
lea  dx , msg2
mov  ah , 9h
int  21h

input:		
lea  dx , buffer
mov  ah , 0ah           ;int to enter in buffer
int  21h		
mov  bx , 0	
mov  bl , buffer[1]  
cmp  bl , 1
je   label2 
cmp  bl,2
ja   again

label1:
mov  cl , buffer[bx+1]
  ;mov  n  , cl
sub  cl , 30h      
dec  bl
  ;cmp  bx , 0
  ;je   finish 
mov  al , buffer[bx+1] 
sub  al , 30h
mov  dl , 10
mul  dl 	  
add  al , cl   
mov  dl , al  

jmp  comparison
	                          
label2:
mov  dl , buffer[bx+1] 
sub  dl , 30h
	   
comparison: 
mov  n  , dl  
mov  y  , dl       ;num for sort 
mov  z  , dl       ;num for print
cmp  dl , 0
jb   again
je   finish
cmp  dl , 25
ja   again

printn

lea  dx , msg3      ;print msg3
mov  ah , 9h
int  21h 	
mov  bx , 0 
printn
       
elements:  
call  scan_num
cmp   al , 13       ;every digit entered in al , the total num in cl
je    newline


newline: 
   
mov  array[bx],cx
add  bx , 2    
mov  ah , 0eh       ;new_line
mov  al , 0dh   
int  10h    
mov  al , 0ah
int  10h    
dec  n 
cmp  n,0   
ja   elements 
  
  
lea  dx , msg4
mov  ah ,  9h        ;print msg4
int  21h
        
call get_string      ;the string in dx
   
cmp  dx,61h
je   ascending
cmp  dx,64h
je   decsending


ascending:
mov  ch,0  
mov  cl,y 

sub  cx,1 
mov  ax,cx
mul  two           
mov  cx,ax
mov  si,0

sort: 
cmp  cx, si
je   nextloop
mov  ax,array[si]
mov  bx,array[si+2]  
cmp  ax,bx 
ja   swap   
add  si,2
jmp  sort

swap:
mov  array[si],bx
mov  array[si+2] ,ax
add  si,2 
jmp  sort  

nextloop:
mov  si,0
sub  cx,2 
  
cmp  cx,0
je   print
jmp  sort



          
          
decsending:  

mov ch , 0  
mov cl , y 

sub cx , 1 
mov ax , cx
mul two  
mov cx , ax
mov si , 0

sort2: 
cmp cx , si
je  nextloop2
mov ax , array[si]
mov bx , array[si+2]  
cmp ax , bx 
jb  swap2   
add si , 2
jmp sort2


swap2:
mov array[si],bx
mov array[si+2] ,ax
add si,2 
jmp sort2  


nextloop2:
mov si , 0
sub cx , 2 
  
cmp cx , 0
je  print
jmp sort2
              
              



print:
   
lea dx,  msg5
mov ah,  9h        ;print msg5
int 21h          


mov  ah , 0eh       ;new_line    
mov  al , 0dh   
int  10h    
mov  al , 0ah
int  10h        

mov si,0 
mov dh,0            
mov dl, z  
sdnum:  
mov ax ,array[si]
                                   
call print_num_uns  

 
sub dx,1
cmp dx,0
je return 
putc ','
add si,2
ja sdnum  


               

return:
printn
jmp start



 

finish:  
printn
 end         
 
 
 
 
	
	
	
	