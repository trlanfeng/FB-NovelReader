unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Edit_kaishi: TEdit;
    Button_huafen_quxiao: TButton;
    Button_huafen_queding: TButton;
    Edit_jieshu: TEdit;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm_Zhu.Button_huafen_quedingClick(Sender: TObject);
begin
  Panel1.Visible := True;
  Panel2.Visible := True;
  Panel_shezhi.Visible := False;
  Splitter1.Visible := True;
  huafen_kaishi := Edit_kaishi.text;
  huafen_jieshu := Edit_jieshu.text;
end;

procedure TForm_Zhu.Button_huafen_quxiaoClick(Sender: TObject);
begin
  Panel1.Visible := True;
  Panel2.Visible := True;
  Panel_shezhi.Visible := False;
  Splitter1.Visible := True;
end;

end.
