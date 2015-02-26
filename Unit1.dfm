object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 416
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 24
    Top = 27
    Width = 60
    Height = 13
    Caption = #25991#23383#39068#33394#65306
  end
  object Label3: TLabel
    Left = 190
    Top = 27
    Width = 60
    Height = 13
    Caption = #32972#26223#39068#33394#65306
  end
  object Label1: TLabel
    Left = 547
    Top = 27
    Width = 60
    Height = 13
    Caption = #25928#26524#39044#35272#65306
  end
  object Label_1: TLabel
    Left = 368
    Top = 27
    Width = 36
    Height = 13
    Caption = #23383#20307#65306
  end
  object Label_2: TLabel
    Left = 366
    Top = 372
    Width = 36
    Height = 13
    Caption = #23383#21495#65306
  end
  object ColorListBox_wenzi: TColorListBox
    Left = 24
    Top = 50
    Width = 145
    Height = 341
    Style = [cbStandardColors, cbExtendedColors, cbPrettyNames]
    TabOrder = 0
  end
  object ColorListBox_beijing: TColorListBox
    Left = 190
    Top = 50
    Width = 158
    Height = 341
    Style = [cbStandardColors, cbExtendedColors, cbPrettyNames]
    TabOrder = 1
  end
  object Memo_yulan: TMemo
    Left = 547
    Top = 50
    Width = 160
    Height = 293
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 22
    Font.Name = 'Tahoma'
    Font.Style = []
    ImeName = #20013#25991' - '#32043#20809#21326#23431#25340#38899#36755#20837#27861'V6'
    Lines.Strings = (
      #36825#37324#26159#39044#35272#21306#22495
      ''
      #31532#19968#31456'   '#24187#34013#23567#35828
      #38405#35835
      #22120#20316#32773#30340#20256#22855#25925#20107
      ''
      #8220#31165#20861#65281#8221#19968#20010#32654#22899
      #27463#26031
      #24213#37324#30340#21483#30528#12290
      ''
      #23567#34013#32456#20110#24525#19981#19979#21435
      #20102#65292
      #23545#30528#32654#22899#24456#35802#24691#30340
      #35828#65306#8220
      #25105#19981#26159#31165#20861#65292#25105#30495
      #30340#19981
      #26159#31165#20861#65292#25105#26159#24503#40065
      #20234#65281#8221)
    ParentFont = False
    TabOrder = 2
  end
  object Button_yanse_queding: TButton
    Left = 547
    Top = 366
    Width = 68
    Height = 25
    Caption = #30830#23450
    TabOrder = 3
  end
  object Button_yanse_quxiao: TButton
    Left = 637
    Top = 366
    Width = 62
    Height = 25
    Caption = #21462#28040
    TabOrder = 4
  end
  object ListBox_ziti: TListBox
    Left = 368
    Top = 50
    Width = 158
    Height = 314
    ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
    ItemHeight = 13
    TabOrder = 5
  end
  object Edit_zihao: TEdit
    Left = 405
    Top = 370
    Width = 121
    Height = 21
    ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 6
    Text = '14'
  end
end
