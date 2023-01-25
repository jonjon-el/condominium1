unit unit_form_modifyDebt;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls;

type

  { TForm_modifyDebt }

  TForm_modifyDebt = class(TForm)
    Button_OK: TButton;
    Button_cancel: TButton;
    Edit_nic: TEdit;
    Edit_amount: TEdit;
    Edit_date: TEdit;
    GroupBox_nic: TGroupBox;
    GroupBox_amount: TGroupBox;
    GroupBox_date: TGroupBox;
    StatusBar1: TStatusBar;
    procedure Button_cancelClick(Sender: TObject);
    procedure Button_OKClick(Sender: TObject);
  private

  public

  end;

var
  Form_modifyDebt: TForm_modifyDebt;

implementation

{$R *.lfm}

{ TForm_modifyDebt }

procedure TForm_modifyDebt.Button_OKClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TForm_modifyDebt.Button_cancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

end.

