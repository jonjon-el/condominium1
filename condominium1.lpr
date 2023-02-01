program condominium1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, unit_form_root, unit_datamodule_main, unit_configTable,
  unit_form_items, unit_form_modifyPerson, unit_form_modifyRelationships,
  unit_form_pickRelation, unit_form_report,
unit_form_moves, unit_form_modifyProperty, unit_form_modifyPayment,
unit_form_modifyDebt, unit_datamodule_item, unit_datamodule_pickRelation,
unit_datamodule_moves, unit_dataModule_report, unit_form_contractedDebts;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDataModule_main, DataModule_main);
  Application.CreateForm(TForm_root, Form_root);
  Application.CreateForm(TDataModule_item, DataModule_item);
  Application.CreateForm(TDataModule_pickRelation, DataModule_pickRelation);
  Application.CreateForm(TDataModule_moves, DataModule_moves);
  Application.CreateForm(TDataModule_report, DataModule_report);
  Application.CreateForm(Tform_contractedDebts, form_contractedDebts);
  Application.Run;
end.

