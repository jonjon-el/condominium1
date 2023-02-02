unit unit_form_moves;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Grids;

type

  { TForm_moves }

  TForm_moves = class(TForm)
    Button_delete: TButton;
    Button_modify: TButton;
    Button_add: TButton;
    Button_close: TButton;
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    TabSheet_contractedDebts: TTabSheet;
    TabSheet_debts: TTabSheet;
    TabSheet_payments: TTabSheet;
    procedure Button_closeClick(Sender: TObject);
    procedure Button_modifyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure FillGrid(bufferGrid: TStringGrid; dateIndex: integer);
  public

  end;

var
  Form_moves: TForm_moves;

implementation

uses
  DateUtils, unit_form_modifyDebt, unit_form_modifyPayment, unit_datamodule_moves, unit_datamodule_main;

{$R *.lfm}

{ TForm_moves }

procedure TForm_moves.Button_closeClick(Sender: TObject);
begin
  ModalResult:=mrClose;
end;

procedure TForm_moves.Button_modifyClick(Sender: TObject);
var
  openedForm: TForm;
  mrResult: TModalResult;
begin
  if PageControl1.ActivePageIndex=0 then
  begin
    openedForm:=unit_form_modifyDebt.TForm_modifyDebt.Create(Self);
  end;
  if PageControl1.ActivePageIndex=1 then
  begin
    openedForm:=unit_form_modifyPayment.TForm_modifyPayment.Create(Self);
  end;
  mrResult:=openedForm.ShowModal();
  if mrResult=mrOK then StatusBar1.SimpleText:='OK'
  else StatusBar1.SimpleText:='Cancel';
  FreeAndNil(openedForm);
  self.Show();
end;

procedure TForm_moves.FormCreate(Sender: TObject);
begin
  //StringGrid1.ColCount:=4;
  StringGrid2.ColCount:=8;
end;

procedure TForm_moves.FormShow(Sender: TObject);
begin
  //debts
  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  unit_datamodule_moves.DataModule_moves.RunQuery(0);
  Self.FillGrid(StringGrid1, 3);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();

  //payments
  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  unit_datamodule_moves.DataModule_moves.RunQuery(1);
  Self.FillGrid(StringGrid2, 6);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();

  //contractedDebts
  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  unit_datamodule_moves.DataModule_moves.RunQuery(2);
  Self.FillGrid(StringGrid3, 5);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();
end;

procedure TForm_moves.FillGrid(bufferGrid: TStringGrid; dateIndex: integer);
var
  i: integer=0;
  j: integer=0;
  bufferRow: TStringArray;
  colCount: integer=0;
  bufferDateInt: integer;
  bufferDate: Tdate;
begin
  bufferRow:=default(TStringArray);
  bufferGrid.RowCount:=1;
  i:=1;
  colCount:=bufferGrid.ColCount;
  while not unit_datamodule_moves.DataModule_moves.SQLQuery1.EOF do
  begin
    SetLength(bufferRow, bufferGrid.ColCount);
    j:=0;
    while j < bufferGrid.ColCount do
    begin
      if j=dateIndex then
      begin
        bufferDateInt:=unit_datamodule_moves.DataModule_moves.SQLQuery1.Fields[j].AsInteger;
        bufferDate:=UnixToDateTime(bufferDateInt);
        bufferRow[j]:=DateToStr(bufferDate);
      end
      else
      begin
        bufferRow[j]:=unit_datamodule_moves.DataModule_moves.SQLQuery1.Fields[j].AsString;
      end;
      inc(j);
    end;
    bufferGrid.InsertRowWithValues(i, bufferRow);
    unit_datamodule_moves.DataModule_moves.SQLQuery1.Next();
    inc(i);
  end;
end;

end.

