unit unit_configTable;

{$mode ObjFPC}{$H+}{$J-}
{$M+}

interface

uses
  Classes, SysUtils, Generics.Collections;

type

  { TConfigTable }

  TConfigTable=class(TPersistent)
    public
    name: string;
    columnNames: TStringList;
    columnTypes: TStringList;
    constructor Create();
    destructor Destroy(); override;
    procedure Assign(Source: TPersistent); override;
  end;

  TConfigTables= specialize TObjectList<TConfigTable>;

  function GetTableNames(configTables: TConfigTables): TStringList;

implementation

function GetTableNames(configTables: TConfigTables): TStringList;
var
  i: integer=0;
  //retval: TStringList;
begin
  result:=TStringList.Create();
  while i<configTables.Count do
  begin
    result.Add(configTables[i].name);
    inc(i);
  end;
end;

{ TConfigTable }

constructor TConfigTable.Create;
begin
  name:='';
  columnNames:=TStringList.Create();
  columnTypes:=TStringList.Create();
end;

destructor TConfigTable.Destroy;
begin
  inherited Destroy();
  FreeAndNil(columnNames);
  FreeAndNil(columnTypes);
end;

procedure TConfigTable.Assign(Source: TPersistent);
var
  configTable: TConfigTable;
begin
  if Source is TConfigTable then
  begin
    configTable:=TConfigTable(Source);
    name:=configTable.name;
    columnNames:=configTable.columnNames;
    columnTypes:=configTable.columnTypes;
  end
  else
  begin
    inherited Assign(Source);
  end;
end;

end.

