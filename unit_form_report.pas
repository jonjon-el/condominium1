unit unit_form_report;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  CheckLst, ExtDlgs, EditBtn, DateTimePicker, Generics.Collections;

type

  TMemoStrings = specialize TDictionary<string, string>;

  { TForm_report }

  TForm_report = class(TForm)
    Button_save: TButton;
    Button_generate1: TButton;
    Button_generate2: TButton;
    Button_close: TButton;
    CheckListBox1: TCheckListBox;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Button_closeClick(Sender: TObject);
    procedure Button_generate1Click(Sender: TObject);
    procedure Button_generate2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Memo1Strings: TMemoStrings;
    procedure UpdateUI();
  public

  end;

var
  Form_report: TForm_report;

implementation

{$R *.lfm}

uses
  unit_dataModule_report, unit_datamodule_main;

{ TForm_report }

procedure TForm_report.Button_closeClick(Sender: TObject);
begin
  ModalResult:=mrClose;
end;

procedure TForm_report.Button_generate1Click(Sender: TObject);
begin

end;

procedure TForm_report.Button_generate2Click(Sender: TObject);
var
  i: integer=0;
  line: string='';
  phrase: string='';
  previousContractedDebt, previousCredit, previousBalance: double;
  contractedDebt, balance: double;
  contractedDebts: unit_dataModule_report.TValueTable;
  propietariesNumber: integer;
  avgSharedDebt: double;
begin
  Memo2.Clear();
  line:='__________ __________ __________ __________ __________';
  Memo2.Append(line);
  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  try
    //Calculating...
    //Previous contracted debt
    previousContractedDebt:=unit_dataModule_report.DataModule_report.GetTotalContractedDebt_previous(DateTimePicker1.Date);
    Memo1Strings.TryGetValue('previousContractedDebt', phrase);
    line:=phrase+': '+FloatToStr(previousContractedDebt);
    Memo2.Append(line);
    //Previous credit
    previousCredit:=unit_dataModule_report.DataModule_report.GetTotalPayment_previous(DateTimePicker1.Date);
    Memo1Strings.TryGetValue('previousCredit', phrase);
    line:=phrase+': '+FloatToStr(previousCredit);
    Memo2.Append(line);
    //Previous balance
    previousBalance:=previousCredit-previousContractedDebt;
    Memo1Strings.TryGetValue('previousBalance', phrase);
    line:=phrase+': '+FloatToStr(previousBalance);
    Memo2.Append(line);
    //Contracted debts
    contractedDebts:=unit_dataModule_report.TValueTable.Create();
    unit_dataModule_report.DataModule_report.GetContractedDebts(DateTimePicker1.Date, contractedDebts);
    Memo1Strings.TryGetValue('contractedDebts', phrase);
    line:=phrase+': ';
    Memo2.Append(line);
    i:=0;
    while i<contractedDebts.Count do
    begin
      line:='    '+contractedDebts[i];
      Memo2.Append(line);
      inc(i);
    end;
    FreeAndNil(contractedDebts);

    //Contracted debt
    contractedDebt:=unit_dataModule_report.DataModule_report.GetTotalContractedDebt(DateTimePicker1.Date);
    Memo1Strings.TryGetValue('contractedDebt', phrase);
    line:=phrase+': '+FloatToStr(contractedDebt);
    Memo2.Append(line);

    //Number of propietaries
    propietariesNumber:=unit_dataModule_report.DataModule_report.GetPropietariesNumber();
    Memo1Strings.TryGetValue('propietariesNumber', phrase);
    line:=phrase+': '+IntToStr(propietariesNumber);
    Memo2.Append(line);

    //Balance
    balance:=previousBalance-contractedDebt;
    Memo1Strings.TryGetValue('balance', phrase);
    line:=phrase+': '+FloatToStr(balance);
    Memo2.Append(line);

    //Shared debt
    avgSharedDebt:=balance/propietariesNumber;
    Memo1Strings.TryGetValue('avgSharedDebt', phrase);
    line:=phrase+': '+FloatToStr(avgSharedDebt);
    Memo2.Append(line);
  except
    on E: Exception do
    begin
      StatusBar1.SimpleText:=E.Message;
    end;
  end;
  line:='__________ __________ __________ __________ __________';
  Memo2.Append(line);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();
end;

procedure TForm_report.FormCreate(Sender: TObject);
begin
  Memo1Strings:=TMemoStrings.Create();
  Memo1Strings.AddOrSetValue('previousContractedDebt', 'Previous contracted debt');
  Memo1Strings.AddOrSetValue('previousCredit', 'Previous credit');
  Memo1Strings.AddOrSetValue('previousBalance', 'Previous balance');
  Memo1Strings.AddOrSetValue('contractedDebts', 'Contracted Debts');
  Memo1Strings.AddOrSetValue('contractedDebt', 'Contracted debt');
  Memo1Strings.AddOrSetValue('debts', 'Debts');
  Memo1Strings.AddOrSetValue('credits', 'Credits');
  Memo1Strings.AddOrSetValue('debt', 'Debt');
  Memo1Strings.AddOrSetValue('credit', 'Credit');
  Memo1Strings.AddOrSetValue('balance', 'Balance');
  Memo1Strings.AddOrSetValue('aliquot', 'Aliquot');
  Memo1Strings.AddOrSetValue('share', 'Share');
  Memo1Strings.AddOrSetValue('propietariesNumber', 'Number of propietaries');
  Memo1Strings.AddOrSetValue('avgSharedDebt', 'Average shared debt');
  UpdateUI();
end;

procedure TForm_report.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Memo1Strings);
end;

procedure TForm_report.UpdateUI();
var
  list: TStringList;
begin
  //Loading list of persons.
  list:=TStringList.Create();
  list.OwnsObjects:=True;
  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  unit_dataModule_report.DataModule_report.Get_propietaries(list);
  CheckListBox1.Items:=list;
  FreeAndNil(list);
  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();
end;

end.

