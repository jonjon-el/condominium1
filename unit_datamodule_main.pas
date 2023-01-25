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
    SQLTransaction1: TSQLTransaction;
  private

  public
    chosenConfig: unit_configIni.TConfigIni;//Stores the configuration.

  end;

var
  DataModule_main: TDataModule_main;

implementation

{$R *.lfm}

initialization
  //unit_datamodule_main.DataModule_main.chosenConfig:=unit_configIni.TConfigIni.Create;

finalization
  //FreeAndNil(unit_datamodule_main.DataModule_main.chosenConfig);

end.

