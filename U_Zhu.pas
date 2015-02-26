{ ----------------------------------------------------------------------------
  变量说明：
  a,b,c ：用来存储pos出来的数据，判断是否成功匹配
  i,j,k ：各个循环中使用
  d ：用来存储是否需要向RichEidt中添加数据－0：需要，1：不需要
  e ：用来存储章节是否划分成功－0：失败，1：成功
  ----------------------------------------------------------------------------- }

unit U_Zhu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Menus, XPMan, ToolWin,
  Buttons,
  ImgList, FileCtrl, IniFiles, ActnMan, ActnList;

type
  TForm_Main = class(TForm)
    MainMenu1: TMainMenu;
    PopupMenu1: TPopupMenu;
    XPManifest1: TXPManifest;
    MM_1: TMenuItem;
    MM_11: TMenuItem;
    MM_12: TMenuItem;
    N4: TMenuItem;
    MM_15: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    RichEdit_xiaoshuo: TRichEdit;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListBox_zhangjie: TListBox;
    Splitter1: TSplitter;
    MM_2: TMenuItem;
    MM_42: TMenuItem;
    MM_5: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    MM_3: TMenuItem;
    MM_31: TMenuItem;
    MM_32: TMenuItem;
    CoolBar1: TCoolBar;
    StatusBar1: TStatusBar;
    Toolbar_biaozhun: TToolBar;
    ToolButton_shang: TToolButton;
    ToolButton_xia: TToolButton;
    ToolButton_wenjian: TToolButton;
    ToolButton6: TToolButton;
    ToolButton_shuqian: TToolButton;
    ToolButton_wenjianjia: TToolButton;
    ToolButton11: TToolButton;
    ToolButton_guanyu: TToolButton;
    ToolButton1: TToolButton;
    ImageList_tubiao: TImageList;
    ToolButton2: TToolButton;
    ToolButton_shezhi: TToolButton;
    ToolButton_quanping: TToolButton;
    ToolButton_suoping: TToolButton;
    N6: TMenuItem;
    MM_33: TMenuItem;
    MM_34: TMenuItem;
    N22: TMenuItem;
    MM_35: TMenuItem;
    MM_351: TMenuItem;
    MM_352: TMenuItem;
    MM_353: TMenuItem;
    MM_354: TMenuItem;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    FileListBox_wenjian: TFileListBox;
    MM_355: TMenuItem;
    MM_4: TMenuItem;
    MM_21: TMenuItem;
    MM_23: TMenuItem;
    MM_13: TMenuItem;
    MM_43: TMenuItem;
    MM_356: TMenuItem;
    MM_N1: TMenuItem;
    MM_36: TMenuItem;
    MM_14: TMenuItem;
    MM_44: TMenuItem;
    procedure ListBox_zhangjieClick(Sender: TObject);
    procedure FileListBox_wenjianClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MM_351Click(Sender: TObject);
    procedure MM_352Click(Sender: TObject);
    procedure MM_353Click(Sender: TObject);
    procedure MM_354Click(Sender: TObject);
    procedure MM_355Click(Sender: TObject);
    procedure RichEdit_xiaoshuoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N15Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MM_43Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure MM_11Click(Sender: TObject);
    procedure MM_12Click(Sender: TObject);
    procedure MM_21Click(Sender: TObject);
    procedure MM_23Click(Sender: TObject);
    procedure MM_31Click(Sender: TObject);
    procedure MM_32Click(Sender: TObject);
    procedure MM_33Click(Sender: TObject);
    procedure MM_34Click(Sender: TObject);
    procedure MM_42Click(Sender: TObject);
  private
    { Private declarations }
    procedure Action_OpenFile(lujing: string);
    procedure Action_Open;
    procedure Action_OpenFolder;
    procedure Action_NightMode;
    procedure Action_EyeMode;
    procedure Action_Previous;
    procedure Action_Next;
    procedure Action_Option;
    procedure Action_OptionSave;
    procedure Action_OptionLoad;
    procedure Action_ToolBar;
    procedure Action_StatusBar;
    procedure Action_Close;
  public
    xiaoshuo: TStringList;
    hang: TStringList;
    huafen_kaishi, huafen_jieshu : string;
  end;

var
  Form_Main: TForm_Main;
  hang_dangqian, hang_shangye: Integer;
  shezhi_file: TIniFile;
  shezhi_lujing: string;
  ini_zhangjie:Integer;
  lastposition : string;
  is_firstopen :Integer;

implementation

uses
  U_HuaFen,U_SheZhi,U_RiZhi;

{$R *.dfm}

// ********** 开始：自定义函数 ********** //

// 加载ini文件设置 - Edit by Trlanfeng @ 2011-10-22
procedure TForm_Main.Action_OptionLoad;
begin
  Form_Main.Width := StrToInt(shezhi_file.ReadString('窗口','宽度','720'));
  Form_Main.Height := StrToInt(shezhi_file.ReadString('窗口','高度','550'));
  //全屏
  if shezhi_file.ReadString('窗口','置顶','0') = '0'
  then Form_Main.FormStyle := fsNormal
  else Form_Main.FormStyle := fsStayOnTop ;
  if shezhi_file.ReadString('界面','工具栏','0') = '-1'
  then
    begin
      MM_21.Checked := True ;
      Toolbar_biaozhun.Visible := True ;
    end
  else
    begin
     MM_21.Checked := False ;
     Toolbar_biaozhun.Visible := False ;
    end;
  if shezhi_file.ReadString('界面','状态栏','0') = '-1'
  then
    begin
      MM_23.Checked := True ;
      StatusBar1.Visible := True ;
    end
  else
    begin
     MM_23.Checked := False ;
     StatusBar1.Visible := False ;
    end;

  richedit_xiaoshuo.Font.Name := shezhi_file.ReadString('显示','字体','宋体');
  richedit_xiaoshuo.Font.Height := StrToInt(shezhi_file.ReadString('显示','字号','-16')) + 8;
  richedit_xiaoshuo.Font.Color := StringToColor(shezhi_file.ReadString('显示','字体颜色','clWhite'));
  richedit_xiaoshuo.Color := StringToColor(shezhi_file.ReadString('显示','背景颜色','clBlack'));
  huafen_kaishi := shezhi_file.ReadString('阅读','划分开始','第');
  huafen_jieshu := shezhi_file.ReadString('阅读','划分结束','章');
  filelistbox_wenjian.Directory := shezhi_file.ReadString('上次阅读','目录',ExtractFileDir(Application.ExeName));
  filelistbox_wenjian.FileName := shezhi_file.ReadString('上次阅读','文件','');
  ini_zhangjie := StrToInt(shezhi_file.ReadString('上次阅读','章节','0'));
  lastposition := shezhi_file.ReadString('上次阅读','位置','0');
end;

// 保存ini文件设置 - Edit by Trlanfeng @ 2011-10-22
procedure TForm_Main.Action_OptionSave;
begin
  shezhi_file.WriteString('窗口','宽度',inttostr(Form_Main.Width));
  shezhi_file.WriteString('窗口','高度',inttostr(Form_Main.Height));
  shezhi_file.WriteString('窗口','全屏',booltostr(MM_44.Checked));
  shezhi_file.WriteString('窗口','置顶',booltostr(MM_43.Checked));
  shezhi_file.WriteString('界面','工具栏',booltostr(MM_21.Checked));
  shezhi_file.WriteString('界面','状态栏',booltostr(MM_23.Checked));
  shezhi_file.WriteString('阅读','护眼模式',booltostr(MM_32.Checked));
  shezhi_file.WriteString('阅读','夜间模式',booltostr(MM_31.Checked));
  shezhi_file.WriteString('阅读','划分开始',huafen_kaishi);
  shezhi_file.WriteString('阅读','划分结束',huafen_jieshu);
  shezhi_file.WriteString('上次阅读','目录',filelistbox_wenjian.Directory);
  shezhi_file.WriteString('上次阅读','文件',filelistbox_wenjian.FileName);
  if (listbox_zhangjie.ItemIndex > 0) then
    shezhi_file.WriteString('上次阅读','章节',inttostr(listbox_zhangjie.ItemIndex));
  shezhi_file.WriteString('上次阅读','位置',lastposition);
end;

// 打开小说文件 - Edit by Trlanfeng @ 2011-10-22
procedure TForm_Main.Action_OpenFile(lujing: string);
var
  i, j: Integer;
  a, b, c, e: Integer;
  ID : THandle;
begin
  e := 0;
  xiaoshuo := TStringList.Create;
  hang := TStringList.Create;
  ListBox_zhangjie.Items.Clear;
  RichEdit_xiaoshuo.Lines.Clear;

  xiaoshuo.LoadFromFile(lujing);
  // 如果总行数大于300则进行章节划分，否则直接显示
  if xiaoshuo.Count > 300 then
  begin
    for i := 0 to 300 do
    begin
      b := pos(huafen_jieshu, xiaoshuo.Strings[i]);
      a := pos(huafen_kaishi, xiaoshuo.Strings[i]);
      a := pos(huafen_kaishi, Copy(xiaoshuo.Strings[i], a + 1, b - a)) + a;
      c := b - a;
      if (a > 0) and (c > 0) and (c < 15) then
      begin
        e := 1;
        ListBox_zhangjie.Items.Add(Trim(xiaoshuo.Strings[0]));
        for j := 0 to i - 1 do
        begin
          RichEdit_xiaoshuo.Lines.Add(xiaoshuo.Strings[j]);
        end;
        Break;
      end;
    end;
    // 如果章节划分成功（e=1）则将所有章节加入列表框
    if e = 1 then
    begin
      for i := 0 to xiaoshuo.Count - 1 do
      begin
        b := pos(huafen_jieshu, xiaoshuo.Strings[i]);
        a := pos(huafen_kaishi, xiaoshuo.Strings[i]);
        a := pos(huafen_kaishi, Copy(xiaoshuo.Strings[i], a + 1, b - a)) + a;
        c := b - a;
        if (a > 0) and (c > 0) and (c < 15) then
        begin
          hang.Add(IntToStr(i));
          ListBox_zhangjie.Items.Add(Trim(xiaoshuo.Strings[i]));
        end;
      end;
      PageControl1.ActivePageIndex := 1;
      if is_firstopen = 1 then
      begin
        ListBox_zhangjie.ItemIndex := ini_zhangjie;
        ListBox_zhangjieClick(nil);
        is_firstopen := 0;
      end;
    end;
    // 如果章节划分失败（e=0）则取消章节划分，并按每页300行显示
    if e = 0 then
    begin
      ShowMessage('章节划分失败，请调整划分模式后再尝试。' + #13 + '当前显示模式：每页300行。');
      for i := 0 to 299 do
      begin
        RichEdit_xiaoshuo.Lines.Add(xiaoshuo.Strings[i]);
      end;
    end;
  end
  // 当总行数小于300时，取消章节划分，直接显示
  else
  begin
    ShowMessage('当前文件行数不足300行，不进行分页显示，以便快速加载。');
    RichEdit_xiaoshuo.Lines.LoadFromFile(lujing);
  end;
end;

// 加载上一章节 - Edit by Trlanfeng @ 2011-10-22
procedure TForm_Main.Action_Previous;
var
  a, b: Integer;
begin
  if ListBox_zhangjie.ItemIndex = 0 then
  begin
    ShowMessage('已经到了第一页，不能再往前了。');
    Exit;
  end;
  ListBox_zhangjie.ItemIndex := ListBox_zhangjie.ItemIndex - 1;
  a := ListBox_zhangjie.ItemIndex;
  RichEdit_xiaoshuo.Clear;
  if a = 0 then
  begin
    for b := 0 to StrToInt(hang[a]) - 1 do
    begin
      RichEdit_xiaoshuo.Lines.Add(xiaoshuo.Strings[b]);
    end;
  end
  else
  begin
    for b := StrToInt(hang[a - 1]) to StrToInt(hang[a]) - 1 do
    begin
      RichEdit_xiaoshuo.Lines.Add(xiaoshuo.Strings[b]);
    end;
  end;
  RichEdit_xiaoshuo.Focused;
  RichEdit_xiaoshuo.SelStart := 0;
  SendMessage(RichEdit_xiaoshuo.Handle, EM_SCROLLCARET, 0, 0);
end;

// 加载下一章节 - Edit by Trlanfeng @ 2011-10-22
procedure TForm_Main.Action_Next;
var
  a, b: Integer;
begin
  if ListBox_zhangjie.ItemIndex < 0 then
    ListBox_zhangjie.ItemIndex := 0;
  if ListBox_zhangjie.ItemIndex = ListBox_zhangjie.Count - 1 then
  begin
    ShowMessage('已经到了最后一页，不能再往后了。');
    Exit;
  end;
  ListBox_zhangjie.ItemIndex := ListBox_zhangjie.ItemIndex + 1;
  a := ListBox_zhangjie.ItemIndex;
  RichEdit_xiaoshuo.Clear;
  if ListBox_zhangjie.ItemIndex = ListBox_zhangjie.Count - 1 then               //判断是否为加载最后一章
  begin
    for b := StrToInt(hang[a - 1]) to xiaoshuo.Count - 1 do
    begin
      RichEdit_xiaoshuo.Lines.Add(xiaoshuo.Strings[b]);
    end;
  end
  else
  begin
    for b := StrToInt(hang[a - 1]) to StrToInt(hang[a]) - 1 do
    begin
      RichEdit_xiaoshuo.Lines.Add(xiaoshuo.Strings[b]);
    end;
  end;
  RichEdit_xiaoshuo.Focused;
  RichEdit_xiaoshuo.SelStart := 0;
  SendMessage(RichEdit_xiaoshuo.Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TForm_Main.Action_Open;
var
  geshu: Integer;
begin
  if OpenDialog1.Execute() then
  begin
    Action_OpenFile(OpenDialog1.FileName);
    FileListBox_wenjian.Directory := OpenDialog1.FileName;
    PageControl1.ActivePageIndex := 1;
    geshu := shezhi_file.ReadInteger('zuijinwenjian', 'geshu', 0);
    if geshu < 11 then
    begin

    end;
  end;
end;

procedure TForm_Main.Action_OpenFolder;
var
  lujing: string;
begin
  if SelectDirectory('选择小说所在文件夹', '', lujing) then
    FileListBox_wenjian.Directory := lujing;
end;

procedure TForm_Main.Action_Close;
begin
  Application.Terminate;
end;

procedure TForm_Main.Action_ToolBar;
begin
  if MM_21.Checked = False then
  begin
    Toolbar_biaozhun.Visible := True ;
    MM_21.Checked := True ;
  end
  else
  begin
    Toolbar_biaozhun.Visible := False ;
    MM_21.Checked := False ;
  end;
end;

procedure TForm_Main.Action_NightMode;
begin
  RichEdit_xiaoshuo.Color := clBlack;
  RichEdit_xiaoshuo.Font.Color := clGray;
  shezhi_file.WriteString('显示','字体颜色',colortostring(clGray));
  shezhi_file.WriteString('显示','背景颜色',colortostring(clBlack));
  MM_31.Checked := True ;
  MM_32.Checked := False ;
end;

procedure TForm_Main.Action_Option;
begin
  Form_SheZhi.Show;
end;

procedure TForm_Main.Action_StatusBar;
begin
  if MM_23.Checked = False then
  begin
    StatusBar1.Visible := True ;
    MM_23.Checked := True ;
  end
  else
  begin
    StatusBar1.Visible := False ;
    MM_23.Checked := False ;
  end;
end;

procedure TForm_Main.Action_EyeMode;
begin
  RichEdit_xiaoshuo.Color := RGB(204, 232, 207);
  RichEdit_xiaoshuo.Font.Color := clBlack;
  shezhi_file.WriteString('显示','字体颜色',colortostring(clBlack));
  shezhi_file.WriteString('显示','背景颜色',colortostring(RGB(204, 232, 207)));
  MM_31.Checked := False ;
  MM_32.Checked := True ;
end;

// ********** 结束：ActionList 动作定义 ********** //



procedure TForm_Main.FileListBox_wenjianClick(Sender: TObject);
begin
  if FileListBox_wenjian.Count > 0 then
    Action_OpenFile(FileListBox_wenjian.Items[FileListBox_wenjian.ItemIndex]);
end;

procedure TForm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  lastposition := IntToStr(GetScrollPos(RichEdit_xiaoshuo.Handle,SB_VERT));
  Action_OptionSave;
  Application.Terminate;
end;

procedure TForm_Main.FormCreate(Sender: TObject);
begin
  shezhi_lujing := ExtractFilePath(Application.ExeName) + 'shezhi.ini';
  shezhi_file := TIniFile.Create(shezhi_lujing);
end;

procedure TForm_Main.FormShow(Sender: TObject);
var
  liebiao_ziti : TStrings;
  I: Integer;
begin
  is_firstopen := 1;
  Action_OptionLoad;
  FileListBox_wenjianClick(Sender);
  SetScrollPos(RichEdit_xiaoshuo.Handle,SB_VERT,StrToInt(lastposition),True);
end;

procedure TForm_Main.ListBox_zhangjieClick(Sender: TObject);
var
  i : Integer;
begin
  RichEdit_xiaoshuo.Lines.Clear;
  if ListBox_zhangjie.ItemIndex = 0 then
  begin
    for i := 0 to StrToInt(hang[0]) do
    begin
      RichEdit_xiaoshuo.Lines.Add(xiaoshuo.Strings[i]);
    end;
  end
  else if ListBox_zhangjie.ItemIndex = ListBox_zhangjie.Count - 1 then
  begin
    for i := StrToInt(hang[hang.Count-1]) to (xiaoshuo.Count-1) do
    begin
      RichEdit_xiaoshuo.Lines.Add(xiaoshuo.Strings[i]);
    end;
  end
  else
  begin
    for i := StrToInt(hang[ListBox_zhangjie.ItemIndex-1]) to (StrToInt(hang[ListBox_zhangjie.ItemIndex]) - 1) do
    begin
      RichEdit_xiaoshuo.Lines.Add(xiaoshuo.Strings[i]);
    end;
  end;
end;



procedure TForm_Main.N13Click(Sender: TObject);
begin
  Form_RiZhi.ShowModal;
end;

procedure TForm_Main.N15Click(Sender: TObject);
begin
  Application.MessageBox('作者：孤月蓝风' + #13#10#13#10 + '邮箱：trlanfeng@foxmail.com' +
    #13#10#13#10 + '网站：http://fengyu.name', '关于', MB_OK);
end;

procedure TForm_Main.RichEdit_xiaoshuoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 37 then
  begin
    Action_Previous;
  end;
  if Key = 38 then
  begin
    SendMessage(RichEdit_xiaoshuo.Handle, WM_VSCROLL, SB_LINEUP, 0);
  end;
  if Key = 39 then
  begin
    Action_Next;
  end;
  if Key = 40 then
  begin
    SendMessage(RichEdit_xiaoshuo.Handle, WM_VSCROLL, SB_LINEDOWN ,1);
  end;
  if Key = 32 then
  begin
    SendMessage(RichEdit_xiaoshuo.Handle, WM_VSCROLL, SB_PAGEDOWN, 0);
  end;
end;

procedure TForm_Main.MM_355Click(Sender: TObject);
begin
  Form_HuaFen.ShowModal;
  if RichEdit_xiaoshuo.Text <> ''
  then Action_OpenFile(FileListBox_wenjian.Items[FileListBox_wenjian.ItemIndex]);
  MM_355.Caption := '自定义→' + huafen_kaishi + '...' + huafen_jieshu;
  MM_355.Checked := True;
  MM_352.Checked := False;
  MM_353.Checked := False;
  MM_354.Checked := False;
  MM_351.Checked := False;
end;

procedure TForm_Main.MM_42Click(Sender: TObject);
begin
  Action_Option;
end;

procedure TForm_Main.MM_43Click(Sender: TObject);
begin
  if MM_43.Checked then
  begin
    MM_43.Checked := False ;
    Form_Main.FormStyle := fsNormal ;
  end
  else
  begin
    MM_43.Checked := True ;
    Form_Main.FormStyle := fsStayOnTop ;
  end;
end;

procedure TForm_Main.MM_11Click(Sender: TObject);
begin
  Action_Open;
end;

procedure TForm_Main.MM_12Click(Sender: TObject);
begin
  Action_OpenFolder;
end;

procedure TForm_Main.MM_21Click(Sender: TObject);
begin
  Action_ToolBar;
end;

procedure TForm_Main.MM_23Click(Sender: TObject);
begin
  Action_StatusBar;
end;

procedure TForm_Main.MM_31Click(Sender: TObject);
begin
  Action_NightMode;
end;

procedure TForm_Main.MM_32Click(Sender: TObject);
begin
  Action_EyeMode;
end;

procedure TForm_Main.MM_33Click(Sender: TObject);
begin
  Action_Previous;
end;

procedure TForm_Main.MM_34Click(Sender: TObject);
begin
  Action_Next;
end;

procedure TForm_Main.MM_351Click(Sender: TObject);
begin
  huafen_kaishi := '第';
  huafen_jieshu := '章';
  MM_351.Checked := True;
  MM_352.Checked := False;
  MM_353.Checked := False;
  MM_354.Checked := False;
  MM_355.Checked := False;
  if RichEdit_xiaoshuo.Text <> ''
  then Action_OpenFile(FileListBox_wenjian.Items[FileListBox_wenjian.ItemIndex]);
end;

procedure TForm_Main.MM_352Click(Sender: TObject);
begin
  huafen_kaishi := '第';
  huafen_jieshu := '节';
  MM_352.Checked := True;
  MM_351.Checked := False;
  MM_353.Checked := False;
  MM_354.Checked := False;
  MM_355.Checked := False;
  if RichEdit_xiaoshuo.Text <> ''
  then Action_OpenFile(FileListBox_wenjian.Items[FileListBox_wenjian.ItemIndex]);
end;

procedure TForm_Main.MM_353Click(Sender: TObject);
begin
  huafen_kaishi := '第';
  huafen_jieshu := '回';
  MM_353.Checked := True;
  MM_352.Checked := False;
  MM_351.Checked := False;
  MM_354.Checked := False;
  MM_355.Checked := False;
  if RichEdit_xiaoshuo.Text <> ''
  then Action_OpenFile(FileListBox_wenjian.Items[FileListBox_wenjian.ItemIndex]);
end;

procedure TForm_Main.MM_354Click(Sender: TObject);
begin
  huafen_kaishi := '第';
  huafen_jieshu := '集';
  MM_354.Checked := True;
  MM_352.Checked := False;
  MM_353.Checked := False;
  MM_351.Checked := False;
  MM_355.Checked := False;
  if RichEdit_xiaoshuo.Text <> ''
  then Action_OpenFile(FileListBox_wenjian.Items[FileListBox_wenjian.ItemIndex]);
end;

end.
