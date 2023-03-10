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
    procedure Button_addClick(Sender: TObject);
    procedure Button_CancelClick(Sender: TObject);
    procedure Button_deleteClick(Sender: TObject);
    procedure Button_modifyClick(Sender: TObject);
    procedure Button_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl_itemsChange(Sender: TObject);
  private
    procedure FillGrid(bufferGrid: TStringGrid; dateIndex: integer);
    procedure UpdateUI();
  public

  end;

var
  Form_items: TForm_items;

implementation

uses
  DateUtils, unit_form_modifyPerson, unit_form_modifyProperty, unit_datamodule_main, unit_datamodule_item;
{$R *.lfm}

{ TForm_items }

procedure TForm_items.Button_OKClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TForm_items.FormCreate(Sender: TObject);
begin

end;

procedure TForm_items.FormShow(Sender: TObject);
begin
  UpdateUI();

end;

procedure TForm_items.PageControl_itemsChange(Sender: TObject);
begin

end;

procedure TForm_items.FillGrid(bufferGrid: TStringGrid; dateIndex: integer);
var
  i: integer=0;
  j: integer=0;
  bufferRow: TStringArray;
  bufferDateInt: integer;
  bufferDate: TDate;
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
      if j=dateIndex then
      begin
        bufferDateInt:=unit_datamodule_item.DataModule_item.SQLQuery1.Fields[j].AsInteger;
        bufferDate:=UnixToDateTime(bufferDateInt);
        bufferRow[j]:=DateToStr(bufferDate);
      end
      else
      begin
        bufferRow[j]:=unit_datamodule_item.DataModule_item.SQLQuery1.Fields[j].AsString;
      end;
      inc(j);
    end;
    bufferGrid.InsertRowWithValues(i, bufferRow);
    unit_datamodule_item.DataModule_item.SQLQuery1.Next();
    inc(i);
  end;
end;

procedure TForm_items.UpdateUI;
begin
  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  unit_datamodule_item.DataModule_item.RunQuery(0);
  Self.FillGrid(StringGrid1, 4);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();

  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  unit_datamodule_item.DataModule_item.RunQuery(1);
  Self.FillGrid(StringGrid2, -1);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();
end;

procedure TForm_items.Button_CancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TForm_items.Button_deleteClick(Sender: TObject);
var
  row: integer;
  col: integer;
  nic: string;
  isDeleted: Boolean=False;
begin
  col:=1;//Corresponding to the nic in the grid.
  row:=StringGrid1.Row;
  nic:=StringGrid1.Cells[col, row];
  try
    unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
    unit_datamodule_item.DataModule_item.DeletePerson(nic);
    unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();
    isDeleted:=True;
  finally
    if unit_datamodule_main.DataModule_main.SQLTransaction1.Active then
    begin
      unit_datamodule_main.DataModule_main.SQLTransaction1.Rollback();
    end;
  end;
  if isDeleted=True then
  begin
    UpdateUI();
  end;
end;

procedure TForm_items.Button_addClick(Sender: TObject);
var
  form_modifyItem: TForm;
  mrResult: TModalResult;
begin
  if Self.PageControl_items.ActivePageIndex=0 then
  begin
    form_modifyItem:=unit_form_modifyPerson.TForm_modifyPerson.Create(Self);
    (form_modifyItem As unit_form_modifyPerson.TForm_modifyPerson).role:='append';
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

procedure TForm_items.Button_modifyClick(Sender: TObject);
var
  form_modifyItem: TForm;
  mrResult: TModalResult;

  //for item
  cellValue: string;
  item: TItemDict;
begin
  if Self.PageControl_items.ActivePageIndex=0 then
  begin
    form_modifyItem:=unit_form_modifyPerson.TForm_modifyPerson.Create(Self);
    (form_modifyItem As unit_form_modifyPerson.TForm_modifyPerson).role:='modify';

    //Get item from selected row in Grid and assign to dictionary called item.
    item:=TItemDict.Create();
    //NIC
    cellValue:=StringGrid1.Cells[1, StringGrid1.Row];
    item.AddOrSetValue('nic', cellValue);
    //firstname
    cellValue:=StringGrid1.Cells[2, StringGrid1.Row];
    item.AddOrSetValue('firstname', cellValue);
    //lastname
    cellValue:=StringGrid1.Cells[3, StringGrid1.Row];
    item.AddOrSetValue('lastname', cellValue);
    //birthdayStr
    cellValue:=StringGrid1.Cells[4, StringGrid1.Row];
    item.AddOrSetValue('birthday', cellValue);

    //Setting person item in the opening form.
    (form_modifyItem As unit_form_modifyPerson.TForm_modifyPerson).person:=item;
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

