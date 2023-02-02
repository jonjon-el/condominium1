unit unit_datamodule_item;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB;

type

  { TDataModule_item }

  TDataModule_item = class(TDataModule)
    SQLQuery1: TSQLQuery;
  private

  public
    procedure RunQuery(index: integer);
  end;

var
  DataModule_item: TDataModule_item;

implementation

{$R *.lfm}

{ TDataModule_item }

procedure TDataModule_item.RunQuery(index: integer);
begin
  SQLQuery1.Close();
  if index=0 then
  begin
    SQLQuery1.SQL.Text:='SELECT persons.id, persons.nic, persons.firstname, persons.lastname, persons.birthday' +
    ' FROM persons';
  end;
  if index=1 then
  begin
    SQLQuery1.SQL.Text:='select * from properties';
  end;
  SQLQuery1.Open();
  SQLQuery1.Last();//For recordCount shows all the records.
  SQLQuery1.First();
end;

end.

