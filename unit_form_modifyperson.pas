unit unit_form_modifyPerson;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  ComCtrls;

type

  { TForm_modifyPerson }

  TForm_modifyPerson = class(TForm)
    Button_OK: TButton;
    Button_cancel: TButton;
    DateEdit_birthDay: TDateEdit;
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
  private

  public

  end;

var
  Form_modifyPerson: TForm_modifyPerson;

implementation

{$R *.lfm}

{ TForm_modifyPerson }

procedure TForm_modifyPerson.Button_OKClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TForm_modifyPerson.Button_cancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

end.

