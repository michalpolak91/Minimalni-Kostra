program vstupnidata;
const max=maxint;
type hrana=record
     v1,v2:integer;
     end;

     var f:text;
    i,k,x,z,y,n,o,p:integer;
    pole:array[1..maxint] of hrana;

function multi(p:hrana):boolean;
var zjisteno:boolean;
    k,l,m:integer;
begin
k:=1;
zjisteno:=false;
multi:=false;
while (k<i) and (not zjisteno) do
 begin
    if (k<>i) then
     begin
     l:=p.v1;
     m:=p.v2;
     if ( (pole[k].v1=l) and (pole[k].v2=m) ) or ((pole[k].v1=m) and (pole[k].v2=l)) then
      begin
        multi:=true;
        zjisteno:=true;
      end;
     end;
k:=k+1;
end;
end;       



begin
assign(f,'vstup.txt');
rewrite(f);
randomize;
readln(n,o,p);
wriTeln(f,o);
i:=1;
k:=1;
for i:=1 to o do
begin
     x:=i;                {random(n)+1; }
     y:=random(n)+1; 
     while x=y do y:=random(n)+1;
     pole[i].v1:=x;
     pole[i].v2:=y;
     {while multi(pole[i]) do
       begin
          x:=random(n)+1;
          pole[i].v1:=x;
      end;  }
     writeln(f,x,' ',y,' ',(random(p)+1));
     
end;
close(f);
end.