unit unit_datamodule_moves;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB;

type

  { TDataModule_moves }

  TDataModule_moves = class(TDataModule)
    SQLQuery1: TSQLQuery;
  private
    procedure ShowTable_Debts();
    procedure ShowTable_ContractedDebts();
    procedure ShowTable_Payments();
  public
    procedure RunQuery(index: integer);
  end;

var
  DataModule_moves: TDataModule_moves;

implementation

{$R *.lfm}

{ TDataModule_moves }

procedure TDataModule_moves.ShowTable_Debts;
begin
  SQLQuery1.Close();
  SQLQuery1.SQL.Text:='SELECT debts.id, properties.name, debts.amount, debts.date' +
  ' FROM debts' +
  ' INNER JOIN properties' +
  ' ON debts.id_property=properties.id';
  SQLQuery1.Open();
end;

procedure TDataModule_moves.ShowTable_ContractedDebts;
begin
  SQLQuery1.Close();
  SQLQuery1.SQL.Text:='SELECT debts_contracted.id, persons.nic, persons.firstname, persons.lastname, debts_contracted.amount, debts_contracted.date, debts_contracted.kind, debts_contracted.reason' +
  ' FROM debts_contracted' +
  ' INNER JOIN persons ON debts_contracted.id_person=persons.id';
  SQLQuery1.Open();
end;

procedure TDataModule_moves.ShowTable_Payments;
begin
  SQLQuery1.Close();
  SQLQuery1.SQL.Text:='SELECT payments.id, properties.name, persons.nic, persons.firstName, persons.lastName, amount, date, id_bank' +
  ' FROM payments' +
  ' INNER JOIN properties ON payments.id_property=properties.id' +
  ' INNER JOIN persons ON payments.id_person=persons.id';
  SQLQuery1.Open();
end;

procedure TDataModule_moves.RunQuery(index: integer);
begin
  //SQLQuery1.Close();
  if index=0 then
  begin
    ShowTable_Debts();
  end;
  if index=1 then
  begin
    ShowTable_Payments();
  end;
  if index=2 then
  begin
    ShowTable_ContractedDebts();
  end;
  SQLQuery1.Last();//For recordCount shows all the records.
  SQLQuery1.First();
end;

end.

