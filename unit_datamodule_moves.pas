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

  public
    procedure RunQuery(index: integer);
  end;

var
  DataModule_moves: TDataModule_moves;

implementation

{$R *.lfm}

{ TDataModule_moves }

procedure TDataModule_moves.RunQuery(index: integer);
begin
  SQLQuery1.Close();
  if index=0 then
  begin
    //SQLQuery1.SQL.Text:='SELECT * from debts';
    SQLQuery1.SQL.Text:='SELECT debts.id, properties.name, debts.amount, debts.date' +
    ' FROM debts' +
    ' INNER JOIN properties' +
    ' ON debts.id_property=properties.id';
  end;
  if index=1 then
  begin
    SQLQuery1.SQL.Text:='SELECT payments.id, properties.name, persons.nic, persons.firstName, persons.lastName, amount, date, id_bank'
    +' FROM payments'
    +' INNER JOIN properties ON payments.id_property=properties.id'
    +' INNER JOIN persons ON payments.id_person=persons.id';
  end;
  SQLQuery1.Open();
  SQLQuery1.Last();//For recordCount shows all the records.
  SQLQuery1.First();
end;

end.

