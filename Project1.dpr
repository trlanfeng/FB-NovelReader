program Project1;

uses
  Forms,
  U_Zhu in 'U_Zhu.pas' {Form_Main},
  U_SheZhi in 'U_SheZhi.pas' {Form_SheZhi},
  U_HuaFen in 'U_HuaFen.pas' {Form_HuaFen},
  U_RiZhi in 'U_RiZhi.pas' {Form_RiZhi};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '»ÃÀ¶Ð¡ËµÔÄ¶ÁÆ÷';
  Application.CreateForm(TForm_Main, Form_Main);
  Application.CreateForm(TForm_SheZhi, Form_SheZhi);
  Application.CreateForm(TForm_HuaFen, Form_HuaFen);
  Application.CreateForm(TForm_RiZhi, Form_RiZhi);
  Application.Run;

end.
