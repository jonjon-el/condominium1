unit unit_form_modifyPerson;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  ComCtrls, DateTimePicker;

type

  { TForm_modifyPerson }

  TForm_modifyPerson = class(TForm)
    Button_OK: TButton;
    Button_cancel: TButton;
    DateTimePicker_birthday: TDateTimePicker;
    Edit_nic: TEdit;
    Edit_firstName: TEdit;
    Edit_lastName: TEdit;
    GroupBox_nic: TGroupBox;
    GroupBox_firstName: TGroupBox;
    GroupBox_lastName: TGroupBox;
    GroupBox_birthDay: TGroupBox;
    StatusBar1: TStatusBar;
    procedure Button_cancelClick(Sender: TObject);
    procedure Button_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    role: string;
  end;

var
  Form_modifyPerson: TForm_modifyPerson;

implementation

uses
  unit_datamodule_main, unit_datamodule_item;

{$R *.lfm}

{ TForm_modifyPerson }

procedure TForm_modifyPerson.Button_OKClick(Sender: TObject);
var
  person: unit_datamodule_item.TItemDict;
  birthdayStr: string='';
begin
  person:=unit_datamodule_item.TItemDict.Create();
  if role='append' then
  begin
    person.AddOrSetValue('nic', Edit_nic.Text);
    person.AddOrSetValue('firstname', Edit_firstName.Text);
    person.AddOrSetValue('lastname', Edit_lastName.Text);
    birthdayStr:=DateToStr(DateTimePicker_birthday.Date);
    person.AddOrSetValue('birthday', birthdayStr);
  end
  else if role='modify' then
  begin

  end
  else
  begin
    StatusBar1.SimpleText:='ERROR: invalid role.';
  end;
  try
    unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
    unit_datamodule_item.DataModule_item.AppendPerson(person);
    unit_datamodule_main.DataModule_main.SQLTransaction1.Commit;
  finally
    if unit_datamodule_main.DataModule_main.SQLTransaction1.Active then
    begin
      unit_datamodule_main.DataModule_main.SQLTransaction1.Rollback();
    end;
  end;
  FreeAndNil(person);
  ModalResult:=mrOK;
end;

procedure TForm_modifyPerson.FormCreate(Sender: TObject);
begin

end;

procedure TForm_modifyPerson.FormShow(Sender: TObject);
var
  person: unit_datamodule_item.TItemDict;
  birthdayStr: string='';
begin
  //person:=unit_datamodule_item.TItemDict.Create();
  if role='append' then
  begin
    //person.AddOrSetValue('nic', Edit_nic.Text);
    //person.AddOrSetValue('firstname', Edit_firstName.Text);
    //person.AddOrSetValue('lastname', Edit_lastName.Text);
    //birthdayStr:=DateToStr(DateTimePicker_birthday.Date);
    //person.AddOrSetValue('birthday', birthdayStr);
  end
  else if role='modify' then
  begin

  end
  else
  begin
    StatusBar1.SimpleText:='ERROR: invalid role.';
  end;
  //try
  //  unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();
  //  unit_datamodule_item.DataModule_item.AppendPerson(person);
  //  unit_datamodule_main.DataModule_main.SQLTransaction1.Commit;
  //finally
  //  if unit_datamodule_main.DataModule_main.SQLTransaction1.Active then
  //  begin
  //    unit_datamodule_main.DataModule_main.SQLTransaction1.Rollback();
  //  end;
  //end;
end;

procedure TForm_modifyPerson.Button_cancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

end.

