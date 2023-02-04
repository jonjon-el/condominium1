unit unit_form_modifyPerson;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  ComCtrls, DateTimePicker, unit_datamodule_item;

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
    person: TItemDict;
  end;

var
  Form_modifyPerson: TForm_modifyPerson;

implementation

uses
  unit_datamodule_main;

{$R *.lfm}

{ TForm_modifyPerson }

procedure TForm_modifyPerson.Button_OKClick(Sender: TObject);
var
  //person: unit_datamodule_item.TItemDict;
  birthdayStr: string='';
begin
  person:=unit_datamodule_item.TItemDict.Create();

  person.AddOrSetValue('nic', Edit_nic.Text);
  person.AddOrSetValue('firstname', Edit_firstName.Text);
  person.AddOrSetValue('lastname', Edit_lastName.Text);
  birthdayStr:=DateToStr(DateTimePicker_birthday.Date);
  person.AddOrSetValue('birthday', birthdayStr);

  try
    unit_datamodule_main.DataModule_main.SQLTransaction1.StartTransaction();

    if role='append' then
    begin
      unit_datamodule_item.DataModule_item.AppendPerson(person);
    end
    else if role='modify' then
    begin
      unit_datamodule_item.DataModule_item.ModifyPerson(person);
    end
    else
    begin
      StatusBar1.SimpleText:='ERROR: invalid role.';
    end;

    unit_datamodule_main.DataModule_main.SQLTransaction1.Commit();
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
  nic: string;
  firstname: string;
  lastname: string;
  birthdayStr: string;
  birthday: TDate;
begin
  if role='modify' then
  begin
    //Try to btain values from person
    person.TryGetValue('nic', nic);
    person.TryGetValue('firstname', firstname);
    person.TryGetValue('lastname', lastname);
    person.TryGetValue('birthday', birthdayStr);
    birthday:=StrToDate(birthdayStr);

    //Filling fields in the form.
    Edit_nic.Text:=nic;
    Edit_firstName.Text:=firstname;
    Edit_lastName.Text:=lastname;
    DateTimePicker_birthday.Date:=birthday;

    //Marking Edit_nic as read only.
    Edit_nic.ReadOnly:=True;
    Edit_nic.Enabled:=False;
  end;
end;

procedure TForm_modifyPerson.Button_cancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

end.

