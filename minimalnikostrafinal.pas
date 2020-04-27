program minimalniKostra;
uses  frontafinal;

const n=1000;
const v=1000;

var a:array[1..n] of data;
    komponenty:array[1..n] of komp_ptr;
    i,k,x,y,z,j:integer;
    f,g:text;
    tempkomp:komp_ptr;
    root1,root2:komp_ptr;

procedure list;
var k:integer;
begin
 writeln;
  for k:=1 to n do
    if (a[k].kostra) then
    begin
      	writeln(a[k].ohodnoceni,' ',a[k].vrchol1,' ',a[k].vrchol2);
    end;
  writeln;
end;

procedure list_function(var g:text);
var k:integer;
begin
 Writeln(g,' ');
  for k:=1 to n do
    if (a[k].kostra) then
    begin
      	Writeln(g,a[k].ohodnoceni,' ',a[k].vrchol1,' ',a[k].vrchol2);
    end;
  Writeln(g,' ');
end;

procedure sort;
var boxes: array[1..v] of queue;
    i:integer;
    j:integer;

begin
  for i:=1 to v do boxes[i].create;
   for j:=1 to n do
    boxes[a[j].ohodnoceni].insert(a[j]);
  j:=0;
  for i:=1 to V do
   while not boxes[i].empty do
     begin
       inc(j);
       boxes[i].delete(a[j]);
     end;
  for i:=1 to V do boxes[i].done;
end;

function root(var node:komp_ptr):komp_ptr;
var temp:komp_ptr;
begin
 temp:=node;
     while (node^.next<>nil) do
           node:=node^.next;
     root:=node;

     if (temp^.next<>nil) and (node<>temp^.next) then
     temp^.next:=node;
end;

begin
assign(f,'vstup.txt');
{$I-}
reset(f);
{$I+}
if ioresult <> 0 then begin
 writeln('Soubor se nepodarilo otevrit');
 halt;
end;
for i:= 1 to n do
 begin
  read(f,x,y,z);
  a[i].kostra:=false;
  a[i].vrchol1:=x;
  a[i].vrchol2:=y;
  a[i].ohodnoceni:=z;
 end;
 close(f);

 sort;

x:=0;
for i:=1 to n do
    komponenty[i]:=nil;
for i := 1 to n do
begin
     if ((komponenty[a[i].vrchol1]=nil) and (komponenty[a[i].vrchol2]=nil)) then
     begin
          inc(x);
          new(tempkomp);
          tempkomp^.id:=x;
          tempkomp^.next:=nil;
          tempkomp^.rank:=0;
          komponenty[a[i].vrchol1]:=tempkomp;
          komponenty[a[i].vrchol2]:=tempkomp;
          a[i].kostra:=true;
     end
     else if komponenty[a[i].vrchol1]=nil then
     begin
          komponenty[a[i].vrchol1]:=root(komponenty[a[i].vrchol2]);
          a[i].kostra:=true;
     end
     else if komponenty[a[i].vrchol2]=nil then
     begin
          komponenty[a[i].vrchol2]:=root(komponenty[a[i].vrchol1]);
          a[i].kostra:=true;
     end
     else
     begin
          root1:=root(komponenty[a[i].vrchol1]);
          root2:=root(komponenty[a[i].vrchol2]);
          if root1^.id<>root2^.id then
          begin
           if root1^.rank<root2^.rank then
             begin
                    root2^.next:=root1;
                    a[i].kostra:=true;
             end
           else if root2^.rank<root1^.rank then
             begin
                    root1^.next:=root2;
                    a[i].kostra:=true;
             end
            else if root2^.rank=root1^.rank then
             begin
                    root1^.next:=root2;
                    root2^.rank:=root2^.rank+1;
                    a[i].kostra:=True;
             end;
          end;
     end;
end;

assign(g,'vystup.txt');
rewrite(g);
writeln(g,'Minimalni Kostra po Komponentach');
writeln(g);
writeln(g,'Komponenta, Vrchol1, Vrchol2');
list_function(g);
close(g);
end.
