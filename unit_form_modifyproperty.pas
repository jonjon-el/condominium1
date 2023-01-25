unit unit_form_modifyProperty;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls;

type

  { TForm_modifyProperty }

  TForm_modifyProperty = class(TForm)
    Button_OK: TButton;
    Button_Cancel: TButton;
    Edit_name: TEdit;
    Edit_sharing: TEdit;
    GroupBox_name: TGroupBox;
    GroupBox_sharing: TGroupBox;
    StatusBar1: TStatusBar;
    procedure Button_CancelClick(Sender: TObject);
    procedure Button_OKClick(Sender: TObject);
    procedure Edit_nameChange(Sender: TObject);
  private

  public

  end;

var
  Form_modifyProperty: TForm_modifyProperty;

implementation

{$R *.lfm}

{ TForm_modifyProperty }

procedure TForm_modifyProperty.Edit_nameChange(Sender: TObject);
begin

end;

procedure TForm_modifyProperty.Button_OKClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TForm_modifyProperty.Button_CancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

end.

