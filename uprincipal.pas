unit uPrincipal;

{$MODE Delphi}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, uLibro, uFileObjectList, Contnrs;

type

    { TForm1 }

    TForm1 = class(TForm)
        btAdd: TButton;
        btActualizar: TButton;
        btSave: TButton;
        btLoad: TButton;
        eTitulo: TEdit;
        eAutor: TEdit;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        lbMostrar: TListBox;
        Panel1: TPanel;
        Panel2: TPanel;
        Panel3: TPanel;
        procedure btAddClick(Sender: TObject);
        procedure btActualizarClick(Sender: TObject);
        procedure btLoadClick(Sender: TObject);
        procedure btSaveClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
    private
    { private declarations }
    public
    { public declarations }
    end;

var
  Form1: TForm1;
  Estante : TFileObjectList;

implementation

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    Estante := TFileObjectList.create();
end;

procedure TForm1.btAddClick(Sender: TObject);
var
    Libro : TLibro;
begin
    Libro := TLibro.Create;
    Estante.Add(Libro);
    Libro.Titulo := eTitulo.Text;
    Libro.Autor := eAutor.Text;
    eTitulo.Clear;
    eAutor.Clear;
    ShowMessage('Libro añadido con éxito');
end;

procedure TForm1.btActualizarClick(Sender: TObject);
var
    i : Integer;
    Libro : TLibro;
begin
    lbMostrar.Clear;
    for i:=0 to Estante.Count - 1 do
    begin
        Libro := TLibro(Estante.Items[i]);
        lbMostrar.Items.Add(Libro.Titulo + ' / ' + Libro.Autor);
    end;
end;

procedure TForm1.btLoadClick(Sender: TObject);
begin
    Estante.LoadFromFile('patatita.bin');
end;


procedure TForm1.btSaveClick(Sender: TObject);
begin
    Estante.SaveToFile('patatita.bin');
end;

initialization
  {$I uprincipal.lrs}

end.

