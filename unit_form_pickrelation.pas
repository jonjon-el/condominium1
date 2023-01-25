unit unit_form_pickRelation;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Grids;

type

  { TForm_pickRelation }

  TForm_pickRelation = class(TForm)
    Button_back: TButton;
    Button_person2property: TButton;
    Button_property2person: TButton;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    procedure Button_backClick(Sender: TObject);
    procedure Button_person2propertyClick(Sender: TObject);
    procedure Button_property2personClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure FillGrid(bufferGrid: TStringGrid);
  public

  end;

var
  Form_pickRelation: TForm_pickRelation;

implementation

uses
  unit_datamodule_pickRelation, unit_datamodule_main,unit_form_modifyRelationships;

{$R *.lfm}

{ TForm_pickRelation }

procedure TForm_pickRelation.FillGrid(bufferGrid: TStringGrid);
var
  i: integer=0;
  j: integer=0;
  bufferRow: array of string;
begin
  bufferGrid.RowCount:=1;
  i:=1;
  while not unit_datamodule_pickRelation.DataModule_pickRelation.SQLQuery1.EOF do
  begin
    SetLength(bufferRow, bufferGrid.ColCount);
    j:=0;
    while j < bufferGrid.ColCount do
    begin
      bufferRow[j]:=unit_datamodule_pickRelation.DataModule_pickRelation.SQLQuery1.Fields[j].AsString;
      inc(j);
    end;
    bufferGrid.InsertRowWithValues(i, bufferRow);
    unit_datamodule_pickRelation.DataModule_pickRelation.SQLQuery1.Next();
    inc(i);
  end;
end;

procedure TForm_pickRelation.Button_backClick(Sender: TObject);
begin
  ModalResult:=mrClose;
end;

procedure TForm_pickRelation.Button_person2propertyClick(Sender: TObject);
var
  form_opened: unit_form_modifyRelationships.TForm_modifyRelationships;
  mrResult: TModalResult;
begin
  form_opened:=unit_form_modifyRelationships.TForm_modifyRelationships.Create(self);
  Self.Hide();
  mrResult:=form_opened.ShowModal();
  if mrResult=mrOK then StatusBar1.SimpleText:='OK'
  else StatusBar1.SimpleText:='Cancel';
  FreeAndNil(form_opened);
  Self.Show();
end;

procedure TForm_pickRelation.Button_property2personClick(Sender: TObject);
var
  form_opened: unit_form_modifyRelationships.TForm_modifyRelationships;
  mrResult: TModalResult;
begin
  form_opened:=unit_form_modifyRelationships.TForm_modifyRelationships.Create(self);
  Self.Hide();
  mrResult:=form_opened.ShowModal();
  if mrResult=mrOK then StatusBar1.SimpleText:='OK'
  else StatusBar1.SimpleText:='Cancel';
  FreeAndNil(form_opened);
  Self.Show();
end;

procedure TForm_pickRelation.FormShow(Sender: TObject);
begin
  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  unit_datamodule_pickRelation.DataModule_pickRelation.RunQuery(0);
  Self.FillGrid(StringGrid1);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();
end;

end.

