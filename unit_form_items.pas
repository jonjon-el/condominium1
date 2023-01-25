unit unit_form_items;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Grids;

type

  { TForm_items }

  TForm_items = class(TForm)
    Button_delete: TButton;
    Button_add: TButton;
    Button_modify: TButton;
    Button_OK: TButton;
    PageControl_items: TPageControl;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    TabSheet_persons: TTabSheet;
    TabSheet_properties: TTabSheet;
    procedure Button_CancelClick(Sender: TObject);
    procedure Button_modifyClick(Sender: TObject);
    procedure Button_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl_itemsChange(Sender: TObject);
  private
    procedure FillGrid(bufferGrid: TStringGrid);
  public

  end;

var
  Form_items: TForm_items;

implementation

uses
  unit_form_modifyPerson, unit_form_modifyProperty, unit_datamodule_main, unit_datamodule_item;
{$R *.lfm}

{ TForm_items }

procedure TForm_items.Button_OKClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TForm_items.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount:=5;
  StringGrid2.ColCount:=3;
end;

procedure TForm_items.FormShow(Sender: TObject);
begin
  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  unit_datamodule_item.DataModule_item.RunQuery(0);
  Self.FillGrid(StringGrid1);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();

  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  unit_datamodule_item.DataModule_item.RunQuery(1);
  Self.FillGrid(StringGrid2);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();
end;

procedure TForm_items.PageControl_itemsChange(Sender: TObject);
begin
  //Self.UpdateUI();
end;

procedure TForm_items.FillGrid(bufferGrid: TStringGrid);
var
  i: integer=0;
  j: integer=0;
  bufferRow: TStringArray;
begin
  bufferRow:=default(TStringArray);
  bufferGrid.RowCount:=1;
  i:=1;
  while not unit_datamodule_item.DataModule_item.SQLQuery1.EOF do
  begin
    SetLength(bufferRow, bufferGrid.ColCount);
    j:=0;
    while j < bufferGrid.ColCount do
    begin
      bufferRow[j]:=unit_datamodule_item.DataModule_item.SQLQuery1.Fields[j].AsString;
      inc(j);
    end;
    bufferGrid.InsertRowWithValues(i, bufferRow);
    unit_datamodule_item.DataModule_item.SQLQuery1.Next();
    inc(i);
  end;
end;

procedure TForm_items.Button_CancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TForm_items.Button_modifyClick(Sender: TObject);
var
  form_modifyItem: TForm;
  mrResult: TModalResult;
begin
  if Self.PageControl_items.ActivePageIndex=0 then
  begin
    form_modifyItem:=unit_form_modifyPerson.TForm_modifyPerson.Create(Self);
  end;
  if Self.PageControl_items.ActivePageIndex=1 then
  begin
    form_modifyItem:=unit_form_modifyProperty.TForm_modifyProperty.Create(Self);
  end;
  self.Hide();
  mrResult:=form_modifyItem.ShowModal();
  if mrResult=mrOK then StatusBar1.SimpleText:='OK'
  else StatusBar1.SimpleText:='Cancel';
  FreeAndNil(form_modifyItem);
  self.Show();
end;

end.

