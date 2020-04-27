unit frontafinal;

interface

const max_length=maxint;

type
     
   komp_ptr=^komp;
   komp=record
        id:integer;
        rank:integer;
        next:komp_ptr;
   end;

   data=record
   ohodnoceni,cislohrany,vrchol1,vrchol2:integer;
   kostra:boolean;
   end;
   
   pole=array[1..10000] of data; 

   item_ptr=^item; 

   item=record 
     dta:data;
     next,prev:item_ptr;
    end;
    
    mstlist_ptr=^mstlist;
    mstlist=record
    hrana:integer;
    next:mstlist_ptr;
    end;

   queue=object
     length:0..max_length; 
     head, stop:item_ptr; 
     constructor create;
     function empty:boolean;
     function full:boolean; 
     procedure insert(d:data); 
     procedure delete(var d:data);  
     destructor done;
   end;

implementation

constructor queue.create;
begin
  length:=0;
  new(head); 
  stop:=head; 
  head^.next:=nil;
end;

function queue.full:boolean;
begin
  if length=max_length then
    full:=true else
    full:=false;
end;

function queue.empty:boolean;
begin
  if length=0 then
  empty:=true else
  empty:=false;
end;

procedure queue.insert(d:data);
begin
 if not full then
   begin
    stop^.dta:=d; 
    new(stop^.next); 
    stop:=stop^.next; 
    stop^.next:=nil;
    inc(length); 
   end;
end;

procedure queue.delete(var d:data);
var temp:item_ptr;
begin
  if empty then
    begin
      writeln('Fronta je prazdna');
    end else
    begin
      d:=head^.dta; 
      temp:=head;
      if temp=stop then stop:=head; 
      head:=head^.next; 
      dispose(temp);
      dec(length);
    end;
end;

destructor queue.done;

var tmp:item_ptr;

begin
  while head<>nil do
    begin
      tmp:=head;
      head:=head^.next;
      dispose(tmp);
    end;
  length:=0;
end; 
end.
