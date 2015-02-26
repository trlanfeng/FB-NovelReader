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
    procedure shezhi_baocun_xianshi;                                             // ����[��ʾ]����
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm_Zhu.SheZhi_BaoCun_xianshi;
begin
  shezhi_file.WriteString('��ʾ','����',listbox_ziti.Items[listbox_ziti.ItemIndex]);
  shezhi_file.WriteString('��ʾ','�������',inttostr(listbox_ziti.ItemIndex));
  shezhi_file.WriteString('��ʾ','�ֺ�',edit_zihao.Text);
  shezhi_file.WriteString('��ʾ','������ɫ',colortostring(colorlistbox_wenzi.Selected));
  shezhi_file.WriteString('��ʾ','������ɫ',colortostring(colorlistbox_beijing.Selected));
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
  huafen_kaishi := '��';
  huafen_jieshu := '��';
  MM_351.Checked := True;
  FileListBox_wenjianClick(Sender);
end;

// ********** ��ʼ����ť�¼� ********** //

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
    ShowMessage('��ѡ�����壡');
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

// ********** ��������ť�¼� ********** //

procedure TForm_Zhu.SheZhi_JiaZai;
begin
  if panel_shezhi.visible = true then
  begin
    listbox_ziti.ItemIndex := StrToInt(shezhi_file.ReadString('��ʾ','�������','0'));
    edit_zihao.Text := shezhi_file.ReadString('��ʾ','�ֺ�','-16');
    ColorListBox_wenzi.Selected := StringToColor(shezhi_file.ReadString('��ʾ','������ɫ','clWhite'));
    ColorListBox_beijing.Selected := StringToColor(shezhi_file.ReadString('��ʾ','������ɫ','clBlack'));
  end
  else
  begin
    richedit_xiaoshuo.Font.Name := shezhi_file.ReadString('��ʾ','����','����');
    richedit_xiaoshuo.Font.Height := StrToInt(shezhi_file.ReadString('��ʾ','�ֺ�','-16')) + 8;
    richedit_xiaoshuo.Font.Color := StringToColor(shezhi_file.ReadString('��ʾ','������ɫ','clWhite'));
    richedit_xiaoshuo.Color := StringToColor(shezhi_file.ReadString('��ʾ','������ɫ','clBlack'));
    filelistbox_wenjian.Directory := shezhi_file.ReadString('�ϴ��Ķ�','Ŀ¼',ExtractFileDir(Application.ExeName));
    filelistbox_wenjian.FileName := shezhi_file.ReadString('�ϴ��Ķ�','�ļ�','');
  end;
end;

end.
