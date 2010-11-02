unit uFileObjectList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uLibro;

  type

    { TFileObjectList }

    TFileObjectList = class (TList)
    public
        destructor Destroy; override;
        procedure Clear;
        procedure SaveToStream(Stream: TStream);
        procedure LoadFromStream (Stream: TStream);
        procedure SaveToFile (const FileName: string);
        procedure LoadFromFile (const FileName: string);
    end;

implementation

{ TFileObjectList }

destructor TFileObjectList.Destroy;
begin
    Clear;
    inherited Destroy;
end;

procedure TFileObjectList.Clear;
var
    i : integer;
begin
    for i:=0 to Count - 1 do
    begin
        TObject(Items[i]).Free;
        Delete(0);
    end;
end;

procedure TFileObjectList.SaveToStream(Stream: TStream);
var
    Writer  : TWriter;
    i       : integer;
begin
    Writer := TWriter.Create(Stream, $ff);
    try
        Writer.WriteListBegin;
        for i:=0 to Count - 1 do
        begin
            if TObject(Items[i]) is TPersistent then
            begin
                Writer.WriteString(TPersistent(Items[i]).ClassName);
                if (TPersistent(Items[i]) is TLibro) then
                    TLibro(Items[i]).WriteData(Writer);
            end;
        end;
        Writer.WriteListEnd;
    finally
        Writer.Free;
    end;
end;

procedure TFileObjectList.LoadFromStream(Stream: TStream);
var
    Reader      :  TReader;
    Objeto      : TPersistent;
    TipoClase   : TPersistentClass;
    NombreClase : string;
    i           : integer;
begin
    Reader  := TReader.Create(Stream, $ff);
    try
        Reader.ReadListBegin;
        while not Reader.EndOfList do
        begin
            NombreClase := Reader.ReadString;
            TipoClase := GetClass(NombreClase);
            if Assigned (TipoClase) then
            begin
                Objeto := TipoClase.Create;
                try
                    if Objeto is TLibro then
                        TLibro(Objeto).ReadData(Reader);
                except
                    Objeto.Free;
                    raise;
                end;
                Add(Objeto);
            end;
        end;
        Reader.ReadListEnd;
    finally
    end;
end;

procedure TFileObjectList.SaveToFile(const FileName: string);
var
    FStream:  TFileStream;
begin
    FStream := TFileStream.Create(FileName, fmCreate or fmOpenWrite);
    try
        SaveToStream(FStream);
    finally
        FStream.Free;
    end;
end;

procedure TFileObjectList.LoadFromFile(const FileName: string);
var
    FStream : TFileStream;
begin
    FStream := TFileStream.Create(FileName, fmOpenRead);
    try
        Clear;
        LoadFromStream (FStream);
    finally
        FStream.Free;
    end;
end;

end.

