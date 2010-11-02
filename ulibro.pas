unit uLibro;

{$mode objfpc}{$H+}

interface

    uses
      Classes, SysUtils;

    type

        { TLibro }

        TLibro = class(TPersistent)
        private
            FAutor: String;
            FTitulo: String;
        published
            property Titulo: String read FTitulo write FTitulo;
            property Autor : String read FAutor write FAutor;
        public
            constructor Create;
            procedure WriteData(Writer: TWriter);  dynamic;
            procedure ReadData(Reader: TReader); dynamic;
        end;


implementation

{ TLibro }

constructor TLibro.Create;
begin
    FTitulo := '';
    FAutor := '';
end;

procedure TLibro.WriteData(Writer: TWriter);
begin
    Writer.WriteString(FTitulo);
    Writer.WriteString(FAutor);

end;

procedure TLibro.ReadData(Reader: TReader);
begin
    FTitulo := Reader.ReadString;
    FAutor := Reader.ReadString;
end;

initialization
    RegisterClass(TLibro);

end.

