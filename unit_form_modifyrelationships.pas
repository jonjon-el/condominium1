unit unit_form_modifyRelationships;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  CheckLst, ComCtrls;

type

  { TForm_modifyRelationships }

  TForm_modifyRelationships = class(TForm)
    Button_OK: TButton;
    Button_Cancel: TButton;
    CheckListBox_owned: TCheckListBox;
    ListBox_owner: TListBox;
    StatusBar1: TStatusBar;
    procedure Button_CancelClick(Sender: TObject);
    procedure Button_OKClick(Sender: TObject);
  private

  public

  end;

var
  Form_modifyRelationships: TForm_modifyRelationships;

implementation

{$R *.lfm}

{ TForm_modifyRelationships }

procedure TForm_modifyRelationships.Button_OKClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TForm_modifyRelationships.Button_CancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

end.

