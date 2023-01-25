unit unit_form_modifyPayment;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls;

type

  { TForm_modifyPayment }

  TForm_modifyPayment = class(TForm)
    Button_OK: TButton;
    Button_cancel: TButton;
    Edit_propertyName: TEdit;
    Edit_NIC: TEdit;
    Edit_firstName: TEdit;
    Edit_lastName: TEdit;
    Edit_amount: TEdit;
    Edit_date: TEdit;
    GroupBox_propertyName: TGroupBox;
    GroupBox_NIC: TGroupBox;
    GroupBox_firstName: TGroupBox;
    GroupBox_lastName: TGroupBox;
    GroupBox_amount: TGroupBox;
    GroupBox_date: TGroupBox;
    StatusBar1: TStatusBar;
    procedure Button_cancelClick(Sender: TObject);
    procedure Button_OKClick(Sender: TObject);
  private

  public

  end;

var
  Form_modifyPayment: TForm_modifyPayment;

implementation

{$R *.lfm}

{ TForm_modifyPayment }

procedure TForm_modifyPayment.Button_OKClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TForm_modifyPayment.Button_cancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

end.

