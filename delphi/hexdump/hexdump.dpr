program hexdump;

{$APPTYPE CONSOLE}

uses
  System.SysUtils
  , System.Classes
  ;

var
  FileStream: TFileStream;
  Column, I: Integer;
  ReadLength: Longint;
  Buffer: array [0..255] of Byte;

begin
  (* �R�}���h���C��������������ΏI�� *)
  if ParamCount = 0 then
  begin
    Writeln(Format('%s <filepath>', [ExtractFileName(ParamStr(0))]));
    Exit;
  end;
  (* �t�@�C����ǂݍ��ݐ�p�ŊJ�� *)
  FileStream := TFileStream.Create(ParamStr(1), fmOpenRead);
  try
    Column := 0;
    while True do
    begin
      ReadLength := FileStream.Read(Buffer, SizeOf(Buffer));
      if ReadLength = 0 then
        Break;
      for I := 0 to ReadLength - 1 do
      begin
        (* ���s *)
        if Column = 16 then
        begin
          Column := 0;
          Writeln('');
        end;
        (* 16�i���ŉ�ʂɏo�� *)
        Write(Format('%.2x ', [Buffer[I]]));
        Inc(Column);
      end;
    end;
  finally
    (* �t�@�C������� *)
    FreeAndNil(FileStream);
  end;
end.
