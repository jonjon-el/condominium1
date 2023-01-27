unit unit_datamodule_main;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLite3Conn, unit_configIni;

const
  pathToIni_defaultValue='settings.ini';

type

  { TDataModule_main }

  TDataModule_main = class(TDataModule)
    SQLConnector1: TSQLConnector;
    SQLScript1: TSQLScript;
    SQLTransaction1: TSQLTransaction;
  private

  public
    chosenConfig: unit_configIni.TConfigIni;//Stores the configuration.
    filename_dbScript: string;
    filename_db: string;
    procedure createDB();
  end;

var
  DataModule_main: TDataModule_main;

implementation

{$R *.lfm}

{ TDataModule_main }

procedure TDataModule_main.createDB;
begin
  SQLConnector1.DatabaseName:=filename_db;
  if not SQLTransaction1.Active then
  begin
    try
      SQLTransaction1.StartTransaction();
      SQLScript1.Script.LoadFromFile(filename_dbScript);
      SQLScript1.Execute();
      SQLTransaction1.Commit();
    finally
      if SQLTransaction1.Active then
      begin
        SQLTransaction1.Rollback();
      end;
    end;

  end;
end;

initialization
  //unit_datamodule_main.DataModule_main.chosenConfig:=unit_configIni.TConfigIni.Create;

finalization
  //FreeAndNil(unit_datamodule_main.DataModule_main.chosenConfig);

end.

