unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
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
  private
    { Private declarations }
    procedure shezhi_baocun_xianshi;                                             // 保存[显示]设置
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm_Zhu.SheZhi_BaoCun_xianshi;
begin
  shezhi_file.WriteString('显示','字体',listbox_ziti.Items[listbox_ziti.ItemIndex]);
  shezhi_file.WriteString('显示','字体序号',inttostr(listbox_ziti.ItemIndex));
  shezhi_file.WriteString('显示','字号',edit_zihao.Text);
  shezhi_file.WriteString('显示','字体颜色',colortostring(colorlistbox_wenzi.Selected));
  shezhi_file.WriteString('显示','背景颜色',colortostring(colorlistbox_beijing.Selected));
end;

procedure TForm_Zhu.ListBox_zitiClick(Sender: TObject);
begin
  Memo_yulan.font.Name := ListBox_ziti.Items[ListBox_ziti.ItemIndex];
end;

procedure TForm_Zhu.FormShow(Sender: TObject);
var
  liebiao_ziti : TStrings;
  I: Integer;
begin
  SheZhi_JiaZai;
  Width := 720;
  liebiao_ziti := TStrings.Create;
  liebiao_ziti := Screen.Fonts;
  for I := 0 to liebiao_ziti.Count-1 do
  begin
    if copy(liebiao_ziti.Strings[i],0,1) <> '@' then
    ListBox_ziti.Items.Add(liebiao_ziti.Strings[i]);
  end;
  //FileListBox_wenjian.Directory := ExtractFileDir(Application.ExeName);
  huafen_kaishi := '第';
  huafen_jieshu := '章';
  MM_351.Checked := True;
  FileListBox_wenjianClick(Sender);
end;

// ********** 开始：按钮事件 ********** //

procedure TForm_Zhu.ColorListBox_beijingClick(Sender: TObject);
begin
  Memo_yulan.Color := ColorListBox_beijing.Selected;
end;

procedure TForm_Zhu.ColorListBox_wenziClick(Sender: TObject);
begin
  Memo_yulan.Font.Color := ColorListBox_wenzi.Selected;
end;

procedure TForm_Zhu.Edit_zihaoChange(Sender: TObject);
begin
  Memo_yulan.font.Height := StrToInt(Edit_zihao.Text)+8;
end;

procedure TForm_Zhu.Button_yanse_quedingClick(Sender: TObject);
begin
  if ListBox_ziti.ItemIndex < 0 then
  begin
    ShowMessage('请选择字体！');
    Exit;
  end;
  Panel1.Visible := True;
  Panel2.Visible := True;
  Panel_shezhi.Visible := False;
  Splitter1.Visible := True;
  RichEdit_xiaoshuo.Color := ColorListBox_beijing.Selected;
  RichEdit_xiaoshuo.Font.Color := ColorListBox_wenzi.Selected;
  RichEdit_xiaoshuo.Font.Name := ListBox_ziti.Items[ListBox_ziti.ItemIndex];
  RichEdit_xiaoshuo.font.Height := StrToInt(Edit_zihao.Text) + 8;
  SheZhi_BaoCun_xianshi;
end;

procedure TForm_Zhu.Button_yanse_quxiaoClick(Sender: TObject);
begin
  Panel1.Visible := True;
  Panel2.Visible := True;
  Panel_shezhi.Visible := False;
  Splitter1.Visible := True;
end;

// ********** 结束：按钮事件 ********** //

procedure TForm_Zhu.SheZhi_JiaZai;
begin
  if panel_shezhi.visible = true then
  begin
    listbox_ziti.ItemIndex := StrToInt(shezhi_file.ReadString('显示','字体序号','0'));
    edit_zihao.Text := shezhi_file.ReadString('显示','字号','-16');
    ColorListBox_wenzi.Selected := StringToColor(shezhi_file.ReadString('显示','字体颜色','clWhite'));
    ColorListBox_beijing.Selected := StringToColor(shezhi_file.ReadString('显示','背景颜色','clBlack'));
  end
  else
  begin
    richedit_xiaoshuo.Font.Name := shezhi_file.ReadString('显示','字体','宋体');
    richedit_xiaoshuo.Font.Height := StrToInt(shezhi_file.ReadString('显示','字号','-16')) + 8;
    richedit_xiaoshuo.Font.Color := StringToColor(shezhi_file.ReadString('显示','字体颜色','clWhite'));
    richedit_xiaoshuo.Color := StringToColor(shezhi_file.ReadString('显示','背景颜色','clBlack'));
    filelistbox_wenjian.Directory := shezhi_file.ReadString('上次阅读','目录',ExtractFileDir(Application.ExeName));
    filelistbox_wenjian.FileName := shezhi_file.ReadString('上次阅读','文件','');
  end;
end;

end.
