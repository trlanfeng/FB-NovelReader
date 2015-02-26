unit U_HuaFen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_HuaFen = class(TForm)
    Edit_kaishi: TEdit;
    Button_huafen_quxiao: TButton;
    Button_huafen_queding: TButton;
    Edit_jieshu: TEdit;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    procedure Button_huafen_quedingClick(Sender: TObject);
    procedure Button_huafen_quxiaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_HuaFen: TForm_HuaFen;

implementation

uses
  U_Zhu;

{$R *.dfm}

procedure TForm_HuaFen.Button_huafen_quedingClick(Sender: TObject);
begin
  Form_Main.huafen_kaishi := Edit_kaishi.text;
  Form_Main.huafen_jieshu := Edit_jieshu.text;
  Form_HuaFen.Close;
end;

procedure TForm_HuaFen.Button_huafen_quxiaoClick(Sender: TObject);
begin
  Form_HuaFen.Close;
end;

end.
