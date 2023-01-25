unit unit_configIni;

{$mode ObjFPC}{$H+}{$J-}
{$M+}

interface

uses
  Classes, SysUtils;

const
  pathToIni_defaultValue='settings.ini';
  connectorType_defaultValue='PostgreSQL';
  databaseName_defaultValue='condominium';
  hostName_defaultValue='localhost';
  userName_defaultValue='alfredo';
  password_defaultValue='jonjon';

  connectorType_keyName='connectorType';
  databaseName_keyName='databaseName';
  hostName_keyName='hostName';
  userName_keyName='userName';
  password_keyName='password';

  section_name='connection';

type

  { TConfigIni }

  TConfigIni = class
    Public
      //m_pathToIni: string;
      m_connectorType: string;
      m_databaseName: string;
      m_hostName: string;
      m_userName: string;
      m_password: string;
      procedure ReadSettings(pathToIni: string);
      procedure WriteSettings(pathToIni: string);
      procedure SetDefaultSettings();
  end;

implementation

uses
  IniFiles;

{ TConfigIni }

procedure TConfigIni.ReadSettings(pathToIni: string);
var
  iniReader: IniFiles.TIniFile;
begin
  iniReader:=IniFiles.TIniFile.Create(pathToIni,TEncoding.UTF8);
  m_connectorType:=iniReader.ReadString(section_name, connectorType_keyName, connectorType_defaultValue);
  m_databaseName:=iniReader.ReadString(section_name, databaseName_keyName, databaseName_defaultValue);
  m_hostName:=iniReader.ReadString(section_name, hostName_keyName, hostName_defaultValue);
  m_userName:=iniReader.ReadString(section_name, userName_keyName, userName_defaultValue);
  m_password:=iniReader.ReadString(section_name, password_keyName, password_defaultValue);
  FreeANdNil(iniReader);
end;

procedure TConfigIni.WriteSettings(pathToIni: string);
var
  iniWriter: IniFiles.TIniFile;
begin
  iniWriter:=IniFiles.TIniFile.Create(pathToIni,TEncoding.UTF8);
  iniWriter.WriteString(section_name, connectorType_keyName, m_connectorType);
  iniWriter.WriteString(section_name, databaseName_keyName, m_databaseName);
  iniWriter.WriteString(section_name, hostName_keyName, m_hostName);
  iniWriter.WriteString(section_name, userName_keyName, m_userName);
  iniWriter.WriteString(section_name, password_keyName, m_password);
  FreeAndNil(iniWriter)
end;

procedure TConfigIni.SetDefaultSettings;
begin
  m_connectorType:=connectorType_defaultValue;
  m_databaseName:=databaseName_defaultValue;
  m_hostName:=hostName_defaultValue;
  m_userName:=userName_defaultValue;
  m_password:=password_defaultValue;
end;

end.

