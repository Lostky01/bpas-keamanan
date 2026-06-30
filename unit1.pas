unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ActnList, ExtCtrls, Grids, EditBtn, TAGraph, TASeries, DateUtils;

  type
    TReport = record
      id: integer;
      nama: string;
      lokasi: string;
      kejadian: string;
      jam: TDateTime;
      tanggal: TdateTime;
      prioritas: integer;
      status: string;
    end;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CbPriority: TComboBox;
    Chart1: TChart;
    Chart1BarSeries1: TBarSeries;
    DateEdit1: TDateEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuDashboard: TMenuItem;
    OpenDialog1: TOpenDialog;
    PanelJamRawan: TPanel;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;
    TextNama: TEdit;
    TextLokasi: TEdit;
    TextKejadian: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    ExitFunc: TMenuItem;
    AddLaporanMenu: TMenuItem;
    LihatLaporan: TMenuItem;
    CariLaporan: TMenuItem;
    MenuProcessQueue: TMenuItem;
    MenuItem15: TMenuItem;
    ClearQueueFunc: TMenuItem;
    MenuStatistik: TMenuItem;
    MenuJamRawan: TMenuItem;
    TimeEdit1: TTimeEdit;
    WilayahRawanMenu: TMenuItem;
    MenuItem2: TMenuItem;
    MenuRefreshDashboard: TMenuItem;
    MenuMonitoringAktif: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    SaveData: TMenuItem;
    LoadData: TMenuItem;
    ResetData: TMenuItem;
    PanelQueue: TPanel;
    PanelStatistik: TPanel;
    PanelInput: TPanel;
    PanelDashboard: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure CbPriorityChange(Sender: TObject);
    procedure FormCreate(Sender: TObject); // <-- ADDED THIS LINE HERE
    procedure Label1Click(Sender: TObject);
    procedure AddLaporanMenuClick(Sender: TObject);
    procedure LoadDataClick(Sender: TObject);
    procedure MenuJamRawanClick(Sender: TObject);
    procedure MenuProcessQueueClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuRefreshDashboardClick(Sender: TObject);
    procedure MenuDashboardClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuStatistikClick(Sender: TObject);
    procedure PanelDashboardClick(Sender: TObject);
    procedure PanelStatistikClick(Sender: TObject);
    procedure SaveDataClick(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
  private
    laporan: array[1..100] of TReport;
    totalData: integer;

    procedure UpdateGrid;
    procedure HitungStatistikJam;
    procedure TampilkanChart;

  public

  end;

var
  Form1: TForm1;
  i: Integer;
  statistikJam: array[0..23] of Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.HitungStatistikJam;
var
  i, jam: Integer;
begin
  for i := 0 to 23 do
    statistikJam[i] := 0;

  for i := 1 to totalData do
  begin
    jam := HourOf(laporan[i].jam);
    Inc(statistikJam[jam]);
  end;
end;

procedure TForm1.TampilkanChart;
var
  i: Integer;
begin
  Chart1BarSeries1.Clear;

  for i := 0 to 23 do
  begin
    Chart1BarSeries1.Add(statistikJam[i], Format('%.2d:00', [i]));
  end;
end;

procedure TForm1.UpdateGrid;
begin
  if totalData = 0 then
    StringGrid1.RowCount := 2
  else
    StringGrid1.RowCount := totalData + 1;

  StringGrid1.Cells[0, 0] := 'ID';
  StringGrid1.Cells[1, 0] := 'Nama';
  StringGrid1.Cells[2, 0] := 'Lokasi';
  StringGrid1.Cells[3, 0] := 'Kejadian';
  StringGrid1.Cells[4, 0] := 'Jam';
  StringGrid1.Cells[5, 0] := 'Tanggal';
  StringGrid1.Cells[6, 0] := 'Prioritas';
  StringGrid1.Cells[7, 0] := 'Status';

  for i := 1 to totalData do
  begin
    StringGrid1.Cells[0, i] := IntToStr(laporan[i].id);
    StringGrid1.Cells[1, i] := laporan[i].nama;
    StringGrid1.Cells[2, i] := laporan[i].lokasi;
    StringGrid1.Cells[3, i] := laporan[i].kejadian;
    StringGrid1.Cells[4, i] := TimeToStr(laporan[i].jam);
    StringGrid1.Cells[5, i] := DateToStr(laporan[i].tanggal);
    StringGrid1.Cells[6, i] := IntToStr(laporan[i].prioritas);
    StringGrid1.Cells[7, i] := laporan[i].status;
  end;

end;

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
       laporan[totalData].jam := TimeEdit1.Time;
       laporan[totalData].tanggal := DateEdit1.Date;
       laporan[totalData].prioritas := StrToInt(CbPriority.Text);
       laporan[totalData].status := 'Pending';
       ShowMessage('Data berhasil ditambahkan');
  end;

procedure TForm1.AddLaporanMenuClick(Sender: TObject);
begin
  if CbPriority.Items.Count = 0 then FormCreate(Self);
  PanelDashboard.Visible := False;
  PanelInput.Visible := True;
  PanelQueue.Visible := False;
  PanelStatistik.Visible := False;
  PanelJamRawan.Visible := False;
end;

procedure TForm1.LoadDataClick(Sender: TObject);
var
  TF: TextFile;
  BarisTeks: string;
  Kolom: TStringList;
begin
  // Atur filter pencarian file agar mempermudah user mencari file data
  OpenDialog1.Filter := 'CSV File (*.csv)|*.csv|Text File (*.txt)|*.txt';
  OpenDialog1.Title := 'Pilih File Data Laporan';

  // Membuka dialog pilih file
  if OpenDialog1.Execute then
  begin
    // Buat objek StringList untuk membantu memotong baris teks menjadi kolom
    Kolom := TStringList.Create;
    // Set pemisah kolom menggunakan titik koma (sesuai saat save data sebelumnya)
    Kolom.Delimiter := ';';
    Kolom.StrictDelimiter := True; // Memastikan spasi tidak dianggap sebagai pemisah baru

    // Hubungkan variabel file dengan lokasi file yang dipilih user
    AssignFile(TF, OpenDialog1.FileName);

    try
      Reset(TF); // Memuka file untuk dibaca (Read-Only)

      // Reset totalData ke 0 sebelum memuat data baru
      totalData := 0;

      // 1. Lewati Baris Pertama (Header) jika ada teks 'ID;Nama;...'
      if not Eof(TF) then
        Readln(TF, BarisTeks);

      // 2. Loop baca baris demi baris sampai file habis
      while not Eof(TF) do
      begin
        Readln(TF, BarisTeks);

        // Lewati jika ada baris kosong di dalam file
        if Trim(BarisTeks) = '' then Continue;

        // Potong baris teks berdasarkan tanda titik koma (;)
        Kolom.DelimitedText := BarisTeks;

        // Pastikan jumlah kolom pas (ada 8 kolom dari indeks 0 sampai 7)
        if Kolom.Count >= 8 then
        begin
          // Tambah counter jumlah data laporan
          Inc(totalData);

          // Masukkan data hasil potongan teks ke dalam array laporan
          // Catatan: Kolom[0] = ID, Kolom[1] = Nama, dst.
          laporan[totalData].id        := StrToInt(Kolom[0]);
          laporan[totalData].nama      := Kolom[1];
          laporan[totalData].lokasi    := Kolom[2];
          laporan[totalData].kejadian  := Kolom[3];
          laporan[totalData].jam       := StrToTime(Kolom[4]);
          laporan[totalData].tanggal   := ScanDateTime('dd/mm/yyyy', Kolom[5]);
          laporan[totalData].prioritas := StrToInt(Kolom[6]);
          laporan[totalData].status    := Kolom[7];
        end;
      end;

      // 3. WAJIB: Panggil UpdateGrid agar StringGrid Anda langsung terupdate di layar
      UpdateGrid;

      ShowMessage('Berhasil memuat ' + IntToStr(totalData) + ' data laporan!');

    finally
      // Tutup file dan hapus objek pembantu dari memori RAM
      CloseFile(TF);
      Kolom.Free;
    end;
  end;
end;

procedure TForm1.MenuJamRawanClick(Sender: TObject);
begin
  if CbPriority.Items.Count = 0 then FormCreate(Self);
  HitungStatistikJam;
  TampilkanChart;
  UpdateGrid;
  PanelDashboard.Visible := True;
  PanelQueue.Visible := False;
  PanelStatistik.Visible := False;
  PanelJamRawan.Visible := False;
end;

procedure TForm1.MenuProcessQueueClick(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
end;

procedure TForm1.MenuRefreshDashboardClick(Sender: TObject);
begin
    UpdateGrid;
end;

procedure TForm1.MenuDashboardClick(Sender: TObject);
begin
  if CbPriority.Items.Count = 0 then FormCreate(Self);

  UpdateGrid;
  PanelDashboard.Visible := True;
  PanelInput.Visible := False;
  PanelQueue.Visible := False;
  PanelStatistik.Visible := False;
  PanelJamRawan.Visible := False;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
end;

procedure TForm1.MenuStatistikClick(Sender: TObject);
begin
  HitungStatistikJam;
  TampilkanChart;
  PanelDashboard.Visible := False;
  PanelQueue.Visible := False;
  PanelStatistik.Visible := True;
  PanelJamRawan.Visible := False;
end;

procedure TForm1.PanelDashboardClick(Sender: TObject);
begin
end;

procedure TForm1.PanelStatistikClick(Sender: TObject);
begin

end;

procedure TForm1.SaveDataClick(Sender: TObject);
var
  TF: TextFile;
  i: Integer;
  BarisData: string;
begin
  // Jika tidak ada data, batalkan ekspor
  if totalData = 0 then
  begin
    ShowMessage('Tidak ada data laporan untuk diekspor!');
    Exit;
  end;

  // Mengatur ekstensi file default menjadi .csv
  SaveDialog1.DefaultExt := 'csv';
  SaveDialog1.Filter := 'CSV File (*.csv)|*.csv|Text File (*.txt)|*.txt';
  SaveDialog1.Title := 'Simpan Data Laporan';

  // Membuka dialog simpan file
  if SaveDialog1.Execute then
  begin
    // Hubungkan variabel file dengan lokasi yang dipilih user
    AssignFile(TF, SaveDialog1.FileName);

    // Gunakan blok try...finally untuk mencegah file error / corrupt jika proses gagal
    try
      Rewrite(TF); // Membuat file baru atau menimpa file lama

      // 1. Tulis Header Kolom ke File CSV
      Writeln(TF, 'ID;Nama;Lokasi;Kejadian;Jam;Tanggal;Prioritas;Status');

      // 2. Loop semua data array laporan dan tulis ke file
      for i := 1 to totalData do
      begin
        // Gabungkan semua data menjadi satu baris teks dipisahkan oleh tanda titik koma (;)
        // Titik koma (;) digunakan agar Excel regional Indonesia langsung otomatis membagi kolom dengan rapi
        BarisData := IntToStr(laporan[i].id) + ';' +
                     laporan[i].nama + ';' +
                     laporan[i].lokasi + ';' +
                     laporan[i].kejadian + ';' +
                     FormatDateTime('hh:nn:ss', laporan[i].jam) + ';' +
                     FormatDateTime('yyyy-mm-dd', laporan[i].tanggal) + ';' +
                     IntToStr(laporan[i].prioritas) + ';' +
                     laporan[i].status;

        // Tulis baris tersebut ke dalam file
        Writeln(TF, BarisData);
      end;

      // Beritahu user jika sukses
      ShowMessage('Data berhasil diekspor ke: ' + SaveDialog1.FileName);

    finally
      // WAJIB: Tutup file agar data benar-benar tersimpan di harddisk
      CloseFile(TF);
    end;
  end;
end;

procedure TForm1.ToggleBox1Change(Sender: TObject);
begin
end;

end.

