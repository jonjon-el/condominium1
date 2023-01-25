unit unit_datamodule_pickRelation;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB;

type

  { TDataModule_pickRelation }

  TDataModule_pickRelation = class(TDataModule)
    SQLQuery1: TSQLQuery;
  private

  public
    procedure RunQuery(index: integer);
  end;

var
  DataModule_pickRelation: TDataModule_pickRelation;

implementation

{$R *.lfm}



{ TDataModule_pickRelation }

procedure TDataModule_pickRelation.RunQuery(index: integer);
begin
  SQLQuery1.Close();
  if index=0 then
  begin
    SQLQuery1.SQL.Text:='select persons.nic, persons.firstName, persons.lastName, properties.name' +
    ' from persons inner join propietaries on persons.id=propietaries.id_owner' +
    ' inner join properties on propietaries.id_property=properties.id';
  end;
  SQLQuery1.Open();
end;

end.

