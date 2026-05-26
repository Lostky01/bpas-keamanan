unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ActnList, ExtCtrls, Grids;

type
  TReport = record
    id: integer;
    nama: string;
    lokasi: string;
    kejadian: string;
    jam: string;
    prioritas: integer;
    status: string;
  end;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CbPriority: TComboBox;
    Label8: TLabel;
    StringGrid1: TStringGrid;
    TextNama: TEdit;
    TextLokasi: TEdit;
    TextKejadian: TEdit;
    TextJam: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PanelQueue: TPanel;
    PanelStatistik: TPanel;
    PanelInput: TPanel;
    PanelDashboard: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure CbPriorityChange(Sender: TObject);
    procedure FormCreate(Sender: TObject); // <-- ADDED THIS LINE HERE
    procedure Label1Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure PanelDashboardClick(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
  private
    laporan: array[1..100] of TReport;
    totalData: integer;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  CbPriority.Items.Clear;
  CbPriority.Items.Add('1');
  CbPriority.Items.Add('2');
  CbPriority.Items.Add('3');
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
end;

procedure TForm1.CbPriorityChange(Sender: TObject);
begin
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     Inc(totalData);
     laporan[totalData].id := totalData;
     laporan[totalData].nama := TextNama.Text;
     laporan[totalData].lokasi := TextLokasi.Text;
     laporan[totalData].kejadian := TextKejadian.Text;
     laporan[totalData].jam := TextJam.Text;
     laporan[totalData].prioritas := StrToInt(CbPriority.Text);
     laporan[totalData].status := 'Pending';
     ShowMessage('Data berhasil ditambahkan');
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  if CbPriority.Items.Count = 0 then FormCreate(Self);
  PanelDashboard.Visible := False;
  PanelInput.Visible := True;
  PanelQueue.Visible := False;
  PanelStatistik.Visible := False;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
end;

procedure TForm1.PanelDashboardClick(Sender: TObject);
begin
end;

procedure TForm1.ToggleBox1Change(Sender: TObject);
begin
end;

end.

