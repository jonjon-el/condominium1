unit unit_form_relationships;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls,
  ComCtrls;

type

  { TForm_relationships }

  TForm_relationships = class(TForm)
    Button_modify: TButton;
    Button_OK: TButton;
    Button_Cancel: TButton;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    procedure Button_CancelClick(Sender: TObject);
    procedure Button_modifyClick(Sender: TObject);
    procedure Button_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure FillGrid(bufferGrid: TStringGrid);
  public

  end;

var
  Form_relationships: TForm_relationships;

implementation

uses
  unit_datamodule_relationships, unit_form_modifyRelationships;

{$R *.lfm}

{ TForm_relationships }

procedure TForm_relationships.Button_OKClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TForm_relationships.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount:=5;
end;

procedure TForm_relationships.FillGrid(bufferGrid: TStringGrid);
var
  i: integer=0;
  j: integer=0;
begin
  i:=1;
  while not unit_datamodule_relationships.DataModule_relationships.SQLQuery1.EOF do
  begin
    j:=0;
    while j < bufferGrid.ColCount do
    begin
      bufferGrid.Cells[j, i]:=unit_datamodule_relationships.DataModule_relationships.SQLQuery1.Fields[j].AsString;
      inc(j);
    end;
    unit_datamodule_relationships.DataModule_relationships.SQLQuery1.Next();
    inc(i);
  end;
end;

procedure TForm_relationships.Button_CancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TForm_relationships.Button_modifyClick(Sender: TObject);
var
  form_opened: unit_form_modifyRelationships.TForm_modifyRelationships;
begin

end;

end.

