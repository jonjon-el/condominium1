unit unit_datamodule_item;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, Generics.Collections;

type

  TItemDict = specialize TDictionary<string, string>;
  { TDataModule_item }

  TDataModule_item = class(TDataModule)
    SQLQuery1: TSQLQuery;
  private

  public
    procedure RunQuery(index: integer);

    procedure GetPerson(nic: string; out person: TItemDict);
    procedure GetBuilding(buildingName: string; out building: TItemDict);

    procedure ModifyPerson(person: TItemDict);
    procedure ModifyBuilding(building: TItemDict);

    procedure AppendPerson(person: TItemDict);
    procedure AppendBuilding(building: TItemDict);

    procedure DeletePerson(nic: string);
    procedure DeleteBuilding(buildingName: string);
  end;

var
  DataModule_item: TDataModule_item;

implementation

{$R *.lfm}

uses
  DateUtils;

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

procedure TDataModule_item.GetPerson(nic: string; out person: TItemDict);
begin

end;

procedure TDataModule_item.GetBuilding(buildingName: string; out
  building: TItemDict);
begin

end;

procedure TDataModule_item.ModifyPerson(person: TItemDict);
var
  nic: string;
  firstname: string;
  lastname: string;
  birthdayStr: string;
  birthday: TDate;
begin
  if SQLQuery1.Active then
  begin
    SQLQuery1.Close();
  end;

  //Try to btain values from person
  person.TryGetValue('nic', nic);
  person.TryGetValue('firstname', firstname);
  person.TryGetValue('lastname', lastname);
  person.TryGetValue('birthday', birthdayStr);
  birthday:=StrToDate(birthdayStr);

  SQLQuery1.SQL.Text:='UPDATE persons' +
  ' SET firstname=:firstname, lastname=:lastname, birthday=:birthday' +
  ' WHERE nic=:nic';

  //Assigning to SQLQuery
  SQLQuery1.ParamByName('nic').AsString:=nic;
  SQLQuery1.ParamByName('firstname').AsString:=firstname;
  SQLQuery1.ParamByName('lastname').AsString:=lastname;
  SQLQuery1.ParamByName('birthday').AsInteger:=DateTimeToUnix(birthday);

  try
    SQLQuery1.ExecSQL();
  finally
    SQLQuery1.Close();
  end;
end;

procedure TDataModule_item.ModifyBuilding(building: TItemDict);
var
  buildingName: string;
begin
  if SQLQuery1.Active then
  begin
    SQLQuery1.Close();
  end;
  SQLQuery1.SQL.Text:='';
end;

procedure TDataModule_item.AppendPerson(person: TItemDict);
var
  nic, firstname, lastname: string;
  birthday: TDate;
  birthdayStr: string;
begin
  if SQLQuery1.Active then
  begin
    SQLQuery1.Close();
  end;
  SQLQuery1.SQL.Text:='INSERT INTO persons(nic, firstname, lastname, birthday)' +
  ' VALUES(:nic, :firstname, :lastname, :birthday)';

  //Try to btain values from person
  person.TryGetValue('nic', nic);
  person.TryGetValue('firstname', firstname);
  person.TryGetValue('lastname', lastname);
  person.TryGetValue('birthday', birthdayStr);
  birthday:=StrToDate(birthdayStr);

  //Assigning to SQLQuery
  SQLQuery1.ParamByName('nic').AsString:=nic;
  SQLQuery1.ParamByName('firstname').AsString:=firstname;
  SQLQuery1.ParamByName('lastname').AsString:=lastname;
  SQLQuery1.ParamByName('birthday').AsInteger:=DateTimeToUnix(birthday);

  try
    SQLQuery1.ExecSQL();
  finally
    SQLQuery1.Close();
  end;

end;

procedure TDataModule_item.AppendBuilding(building: TItemDict);
begin

end;

procedure TDataModule_item.DeletePerson(nic: string);
begin
  if SQLQuery1.Active then
  begin
    SQLQuery1.Close();
  end;
  SQLQuery1.SQL.Text:='DELETE FROM persons' +
  ' WHERE persons.nic=:nic';

  //Assigning to SQLQuery
  SQLQuery1.ParamByName('nic').AsString:=nic;

  try
    SQLQuery1.ExecSQL();
  finally
    SQLQuery1.Close();
  end;

end;

procedure TDataModule_item.DeleteBuilding(buildingName: string);
begin

end;

end.

