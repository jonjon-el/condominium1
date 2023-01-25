unit unit_form_root;

{$mode objfpc}{$H+}

{ #todo : 1. Internationalization.
2. Translation.
3. Resource files.
4. Reports.
5. Help.
6. Schemas.
7. Tests.
8. Installer.
9. Porting to anther plattforms. }

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  unit_configIni, PQConnection;

type

  { TForm_root }

  TForm_root = class(TForm)
    Button_report: TButton;
    Button_items: TButton;
    Button_relations: TButton;
    Button_moves: TButton;
    StatusBar1: TStatusBar;
    procedure Button_itemsClick(Sender: TObject);
    procedure Button_movesClick(Sender: TObject);
    procedure Button_relationsClick(Sender: TObject);
    procedure Button_reportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

  public

  end;

var
  Form_root: TForm_root;

implementation

uses
  unit_datamodule_main, unit_form_items, unit_form_pickRelation, unit_form_report, unit_form_moves;

{$R *.lfm}

{ TForm_root }

procedure TForm_root.FormCreate(Sender: TObject);
begin
  StatusBar1.SimpleText:='Loading settings';
  unit_datamodule_main.DataModule_main.chosenConfig:=unit_configIni.TConfigIni.Create;

  //Reading the settings from permanent storage.
  unit_datamodule_main.DataModule_main.chosenConfig.ReadSettings(unit_configIni.pathToIni_defaultValue);

  StatusBar1.SimpleText:='Ready.';
end;

procedure TForm_root.Button_itemsClick(Sender: TObject);
var
  form_items: unit_form_items.TForm_items;
  mrResult: TModalResult;
begin
  form_items:=unit_form_items.TForm_items.Create(self);
  Self.Hide();
  mrResult:=form_items.ShowModal();
  if mrResult=mrOK then StatusBar1.SimpleText:='OK'
  else StatusBar1.SimpleText:='Cancel';
  FreeAndNil(form_items);
  Self.Show();
end;

procedure TForm_root.Button_movesClick(Sender: TObject);
var
  form_opened: unit_form_moves.TForm_moves;
  mrResult: TModalResult;
begin
  form_opened:=unit_form_moves.TForm_moves.Create(self);
  Self.Hide();
  mrResult:=form_opened.ShowModal();
  if mrResult=mrOK then StatusBar1.SimpleText:='OK'
  else StatusBar1.SimpleText:='Cancel';
  FreeAndNil(form_opened);
  Self.Show();
end;

procedure TForm_root.Button_relationsClick(Sender: TObject);
var
  form_opened: unit_form_pickRelation.TForm_pickRelation;
  mrResult: TModalResult;
begin
  form_opened:=unit_form_pickRelation.TForm_pickRelation.Create(self);
  Self.Hide();
  mrResult:=form_opened.ShowModal();
  if mrResult=mrOK then StatusBar1.SimpleText:='OK'
  else StatusBar1.SimpleText:='Cancel';
  FreeAndNil(form_opened);
  Self.Show();
end;

procedure TForm_root.Button_reportClick(Sender: TObject);
var
  form_opened: unit_form_report.TForm_report;
  mrResult: TModalResult;
begin
  form_opened:=unit_form_report.TForm_report.Create(self);
  Self.Hide();
  mrResult:=form_opened.ShowModal();
  if mrResult=mrOK then StatusBar1.SimpleText:='OK'
  else StatusBar1.SimpleText:='Cancel';
  FreeAndNil(form_opened);
  Self.Show();
end;

procedure TForm_root.FormDestroy(Sender: TObject);
begin
  StatusBar1.SimpleText:='Saving settings';
  unit_datamodule_main.DataModule_main.chosenConfig.WriteSettings(unit_configIni.pathToIni_defaultValue);
  FreeAndNil(unit_datamodule_main.DataModule_main.chosenConfig);
  StatusBar1.SimpleText:='Ready.';
end;

end.

