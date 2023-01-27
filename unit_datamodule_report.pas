unit unit_dataModule_report;

{$mode ObjFPC}{$H+}
{$modeSwitch advancedRecords}

interface

uses
  Classes, SysUtils, SQLDB, Generics.Collections;

type

  { TValueTable }

  TValueItem = record
    title: string;
    subtitle: string;
    value: double;
    function ToString(sep1: string): string;
  end;
  TValueTable= TStringList;

  TStringList2D = specialize TObjectList<TStringList>;

  { TDataModule_report }

  TDataModule_report = class(TDataModule)
    SQLQuery1: TSQLQuery;
  private

  public
    function GetTotalPayment_propietary(nic: string): double;
    function GetTotalDebt_propietary(nic: string): double;
    function GetTotalContractedDebt_previous(date: TDate): double;//2nd
    procedure GetContractedDebts(date: TDate; out valueTable: TValueTable);//2nd
    function GetTotalContractedDebt(date: TDate): double;//2nd
    function GetTotalPayment_previous(date: TDate): double;//2nd
    procedure Get_propietaries(out list: TStringList);
    function GetPropietariesNumber(): integer;
  end;

var
  DataModule_report: TDataModule_report;

implementation

{$R *.lfm}

{ TValueTable }

function TValueItem.ToString(sep1: string): string;
begin
  result:=title+sep1+FloatToStr(value);
end;

{ TDataModule_report }

procedure TDataModule_report.GetContractedDebts(date: TDate; out valueTable: TValueTable);
var
  item: TValueItem;
begin
  SQLQuery1.SQL.Text:='SELECT kinds.description, debts_contracted.amount' +
  ' FROM debts_contracted' +
  ' INNER JOIN kinds' +
  ' ON debts_contracted.kind=kinds.id' +
  ' WHERE debts_contracted.date=strftime("%s", :date)';
  SQLQuery1.Params.ParamByName('date').AsString:=FormatDateTime('YYYY-MM-DD', date);

  //valueTable:=TValueTable.Create();
  try
    SQLQuery1.Open();
    while not SQLQuery1.EOF do
    begin
      item.title:=SQLQuery1.Fields[0].AsString;
      item.value:=SQLQuery1.Fields[1].AsFloat;
      valueTable.Add(item.ToString(': '));
      SQLQuery1.Next();
    end;
  finally
    if SQLQuery1.Active then
    begin
      SQLQuery1.Close();
    end;
  end;
end;

function TDataModule_report.GetTotalContractedDebt(date: TDate): double;
begin
  SQLQuery1.SQL.Text:='SELECT sum(debts_contracted.amount)' +
  ' FROM debts_contracted' +
  ' WHERE debts_contracted.date=strftime("%s", :date)';
  SQLQuery1.Params.ParamByName('date').AsString:=FormatDateTime('YYYY-MM-DD', date);
  try
    SQLQuery1.Open();
    if SQLQuery1.Fields[0].IsNull then
    begin
      result:=0;
    end
    else
    begin
      result:=SQLQuery1.Fields[0].AsFloat;
    end;
  finally
    if SQLQuery1.Active then
    begin
      SQLQuery1.Close();
    end;
  end;
end;

function TDataModule_report.GetTotalPayment_propietary(nic: string): double;
begin
  SQLQuery1.SQL.Text:='SELECT sum(t1.amount)' +
  ' FROM (' +
  ' SELECT payments.amount' +
  ' FROM persons' +
  ' INNER JOIN payments ON persons.id=payments.id_person' +
  ' WHERE persons.nic=:nic) as t1';
  SQLQuery1.Params.ParamByName('nic').AsString:=nic;
  SQLQuery1.Open();
  result:=SQLQuery1.Fields[0].AsFloat;
  SQLQuery1.Close();
end;

function TDataModule_report.GetTotalDebt_propietary(nic: string): double;
begin
  SQLQuery1.SQL.Text:='SELECT sum(t1.amount)' +
  ' FROM (' +
  ' SELECT debts.amount' +
  ' FROM persons' +
  ' INNER JOIN debts ON persons.id=debts.id_person' +
  ' WHERE persons.nic=:nic) as t1';
  SQLQuery1.Params.ParamByName('nic').AsString:=nic;
  SQLQuery1.Open();
  result:=SQLQuery1.Fields[0].AsFloat;
  SQLQuery1.Close();
end;

function TDataModule_report.GetTotalContractedDebt_previous(date: TDate): double;
var
  strDate: string='';
begin
  SQLQuery1.SQL.Text:='SELECT sum(amount) FROM debts_contracted WHERE date<strftime("%s", :date)';
  //processing date
  strDate:=FormatDateTime('yyyy"-"mm"-"dd', date);
  SQLQuery1.Params.ParamByName('date').AsString:=strDate;
  try
    SQLQuery1.Open();
    if SQLQuery1.Fields[0].IsNull then
    begin
      result:=0;
    end
    else
    begin
      result:=SQLQuery1.Fields[0].AsFloat;
    end;
  finally
    if SQLQuery1.Active then
    begin
      SQLQuery1.Close();
    end;
  end;
end;

function TDataModule_report.GetTotalPayment_previous(date: TDate): double;
var
  strDate: string='';
begin
  SQLQuery1.SQL.Text:='SELECT sum(amount)' +
  ' FROM payments WHERE date<strftime("%s", :date)';

  //processing date
  strDate:=FormatDateTime('yyyy"-"mm"-"dd', date);
  SQLQuery1.Params.ParamByName('date').AsString:=strDate;
  try
    SQLQuery1.Open();
    if SQLQuery1.Fields[0].IsNull then
    begin
      result:=0;
    end
    else
    begin
      result:=SQLQuery1.Fields[0].AsFloat;
    end;
  finally
    if SQLQuery1.Active then
    begin
      SQLQuery1.Close();
    end;
  end;
end;

procedure TDataModule_report.Get_propietaries(out list: TStringList);
begin
  SQLQuery1.SQL.Text:='SELECT persons.nic|| " " ||persons.firstName|| " " ||persons.lastName' +
  ' FROM persons';
  try
    SQLQuery1.Open();
    while not SQLQuery1.EOF do
    begin
      list.Add(SQLQuery1.Fields[0].AsString);
      SQLQuery1.Next;
    end;
  finally
    SQLQuery1.Close();
  end;
end;

function TDataModule_report.GetPropietariesNumber: integer;
begin
  SQLQuery1.SQL.Text:='SELECT count(persons.id)' +
  ' FROM persons' +
  ' INNER JOIN propietaries' +
  ' ON persons.id=propietaries.id_owner';
  try
    SQLQuery1.Open();
    result:=SQLQuery1.Fields[0].AsInteger;
  finally
    SQLQuery1.Close();
  end;
end;

end.

