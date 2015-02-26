unit U_SheZhi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm_SheZhi = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label_1: TLabel;
    Label_2: TLabel;
    ColorListBox_wenzi: TColorListBox;
    ColorListBox_beijing: TColorListBox;
    Memo_yulan: TMemo;
    Button_yanse_queding: TButton;
    Button_yanse_quxiao: TButton;
    ListBox_ziti: TListBox;
    Edit_zihao: TEdit;
    procedure Button_yanse_quedingClick(Sender: TObject);
    procedure Button_yanse_quxiaoClick(Sender: TObject);
    procedure ListBox_zitiClick(Sender: TObject);
    procedure ColorListBox_beijingClick(Sender: TObject);
    procedure ColorListBox_wenziClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit_zihaoChange(Sender: TObject);
  private
    { Private declarations }
    procedure shezhi_baocun_xianshi;                                             // 保存[显示]设置
    procedure shezhi_jiazai;
  public
    { Public declarations }
  end;

var
  Form_SheZhi: TForm_SheZhi;

implementation

uses
  U_Zhu;

{$R *.dfm}

procedure TForm_SheZhi.SheZhi_BaoCun_xianshi;
begin
  shezhi_file.WriteString('显示','字体',listbox_ziti.Items[listbox_ziti.ItemIndex]);
  shezhi_file.WriteString('显示','字体序号',inttostr(listbox_ziti.ItemIndex));
  shezhi_file.WriteString('显示','字号',edit_zihao.Text);
  shezhi_file.WriteString('显示','字体颜色',colortostring(colorlistbox_wenzi.Selected));
  shezhi_file.WriteString('显示','背景颜色',colortostring(colorlistbox_beijing.Selected));
end;

procedure TForm_SheZhi.ListBox_zitiClick(Sender: TObject);
begin
  Memo_yulan.font.Name := ListBox_ziti.Items[ListBox_ziti.ItemIndex];
end;

procedure TForm_SheZhi.FormShow(Sender: TObject);
var
  liebiao_ziti : TStrings;
  I: Integer;
begin
  SheZhi_JiaZai;
  liebiao_ziti := TStrings.Create;
  liebiao_ziti := Screen.Fonts;
  for I := 0 to liebiao_ziti.Count-1 do
  begin
    if copy(liebiao_ziti.Strings[i],0,1) <> '@' then
    ListBox_ziti.Items.Add(liebiao_ziti.Strings[i]);
  end;
  //FileListBox_wenjian.Directory := ExtractFileDir(Application.ExeName);
end;

// ********** 开始：按钮事件 ********** //

procedure TForm_SheZhi.ColorListBox_beijingClick(Sender: TObject);
begin
  Memo_yulan.Color := ColorListBox_beijing.Selected;
end;

procedure TForm_SheZhi.ColorListBox_wenziClick(Sender: TObject);
begin
  Memo_yulan.Font.Color := ColorListBox_wenzi.Selected;
end;

procedure TForm_SheZhi.Edit_zihaoChange(Sender: TObject);
begin
  Memo_yulan.font.Height := StrToInt(Edit_zihao.Text)+8;
end;

// ********** 结束：按钮事件 ********** //

procedure TForm_SheZhi.SheZhi_JiaZai;
begin
    listbox_ziti.ItemIndex := StrToInt(shezhi_file.ReadString('显示','字体序号','0'));
    edit_zihao.Text := shezhi_file.ReadString('显示','字号','-16');
    ColorListBox_wenzi.Selected := StringToColor(shezhi_file.ReadString('显示','字体颜色','clWhite'));
    ColorListBox_beijing.Selected := StringToColor(shezhi_file.ReadString('显示','背景颜色','clBlack'));
end;

procedure TForm_SheZhi.Button_yanse_quedingClick(Sender: TObject);
begin
  if ListBox_ziti.ItemIndex < 0 then
  begin
    ShowMessage('请选择字体！');
    Exit;
  end;
  Form_Main.RichEdit_xiaoshuo.Color := ColorListBox_beijing.Selected;
  Form_Main.RichEdit_xiaoshuo.Font.Color := ColorListBox_wenzi.Selected;
  Form_Main.RichEdit_xiaoshuo.Font.Name := ListBox_ziti.Items[ListBox_ziti.ItemIndex];
  Form_Main.RichEdit_xiaoshuo.font.Height := StrToInt(Edit_zihao.Text) + 8;
  SheZhi_BaoCun_xianshi;
  Form_SheZhi.Close;
end;

procedure TForm_SheZhi.Button_yanse_quxiaoClick(Sender: TObject);
begin
  Form_SheZhi.Close;
end;

end.
