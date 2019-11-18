program MyStek;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

type
  StekElPT=^TStek;

  TStek=record
    Elem:Char;
    Next:StekElPT;
  end;


var Rang:Integer;

Procedure AddSteck (var st:StekElPT;value:Char);
var
  x :StekElPT;
begin
  new(x);
  x^.Elem:=value;
  x^.next:=st;
  st:=x;
end;


function GetSteck(var st:StekElPT):Char;
begin
  if st<> nil then
  begin
    GetSteck:=st^.Elem;
    st := st^.next;
  end
  else
    GetSteck:=#0;
end;


function StekPriority (c:Char):Integer;
begin
  case c of
    '+','-' : Result := 2;
    '*','/' : Result := 4;
    '^' : Result := 5;
    'a'..'z','A'..'Z' : Result := 8;
    '(' : Result := 0;
  else
      Result := 10;
  end;
end;


function InpPriority (c:Char):Integer;
begin
  case c of
    '+','-' : Result := 1;
    '*','/' : Result := 3;
    '^' : Result := 6;
    'a'..'z','A'..'Z' : Result := 7;
    '(' : Result := 9;
    ')' : Result := 0;
  else
    Result := 10;
  end;
end;


function CharRang(c:Char):integer;
begin
  if c in ['a'..'z','A'..'Z'] then
    Result:=1
  else
    Result:=-1;
end;

function SteckWrite(St:StekElPT):string;
var
str,s:string;
i:Integer;
 begin
   if St=nil then s:='-|'
   else begin
   str:='';
   s:='';
    while St<>nil do
     begin
       str:=str+St^.Elem;
       St:=St^.Next;
     end;
     for i:=1 to Length(str) do
     begin
        s:=s+str[Length(str)-i+1];
     end;
       end;
     for i:=1 to 10-Length(s) do s:=s+' ';

     result:=S;
 end;

function FindNotation(input:string):string;
var
  st,Head:StekElPT;
  output:string;
  i:Integer;
  t:Char;
begin
  st:=nil;
  Head:=st;
  Rang:=0;
  output:='';
   i:=1;
  while i<= Length(input) do
   begin
    if  (st=nil) or (InpPriority(Input[i]) > StekPriority(st^.Elem)) then
    begin
      if Input[i] <> ')' then
        AddSteck(st,input[i]);
         Writeln(Input[i],'|',SteckWrite(st),'|',output);
        inc(i)
    end

    else
    begin
      t:=GetSteck(st);
      if t <> '(' then
      begin
        output:=output+t;
        Rang := Rang + CharRang(t);
      end;

    end;
    end;
   

  while not (st = nil) do
  begin
    t:=GetSteck(st);
    if t <> '(' then
      output:=output+t;
  end;
     Writeln(Input[i],'|',SteckWrite(st),'|',output);
  result:=output;
end;

var
  input,str:string;
begin

  Write('Write your expression: ');
  Readln(input);
  str:=FindNotation(input);
  Writeln;
  Write('Poland notation: ');
  Writeln(str);
  Write('Rang of expression: ');
  Writeln(Rang);
  Readln;
end.
