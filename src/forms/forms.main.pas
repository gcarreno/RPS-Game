unit Forms.Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ActnList,
  StdActns, StdCtrls, Buttons, ExtCtrls;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    actGameRock: TAction;
    actGamePaper: TAction;
    actGameScissors: TAction;
    actGameDraw: TAction;
    alMain: TActionList;
    actFileExit: TFileExit;
    imgGameDraw: TImage;
    imlRBS: TImageList;
    lblUserScore: TLabel;
    lblAIScore: TLabel;
    mnuGameSep1: TMenuItem;
    mnuGameDraw: TMenuItem;
    mnuGame: TMenuItem;
    mnuGameRock: TMenuItem;
    mnuGamePaper: TMenuItem;
    mnuGameScissors: TMenuItem;
    mnuFile: TMenuItem;
    mnuFileSep1MenuItem2: TMenuItem;
    mnuFileExit: TMenuItem;
    mmMain: TMainMenu;
    spbGameRock: TSpeedButton;
    spbGamePaper: TSpeedButton;
    spbGameScissors: TSpeedButton;
    procedure actGameDrawExecute(Sender: TObject);
    procedure actGameRockExecute(Sender: TObject);
    procedure actGamePaperExecute(Sender: TObject);
    procedure actGameScissorsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure InitShortcuts;
    procedure ClearButtons;
    procedure SetScores;
    procedure DecideWinner(const aChoice: Integer);
  public

  end;

const
  cVersionMajor = 0;
  cVersionMinor = 1;
  cVersionPatch = 1;

resourcestring
  rcFormCaption = 'Rock-Paper-Scrissor Game v%d.%d.%d';
  rcUserScore = 'User Score: %d';
  rcAIScore = 'A.I. Score: %d';

var
  frmMain: TfrmMain;

implementation

uses
  LCLType
;

var
  UserChoice: Integer;
  UserScore: Integer;
  AIScore: Integer;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.actGameRockExecute(Sender: TObject);
begin
  if spbGameRock.ImageIndex = 0 then
  begin
    spbGameRock.ImageIndex:= 3;
  end
  else
  begin
    spbGameRock.ImageIndex:= 0;
  end;
  spbGamePaper.ImageIndex:= 1;
  spbGameScissors.ImageIndex:= 2;
  UserChoice:= 1;
end;

procedure TfrmMain.actGamePaperExecute(Sender: TObject);
begin
  if spbGamePaper.ImageIndex = 1 then
  begin
    spbGamePaper.ImageIndex:= 4;
  end
  else
  begin
    spbGamePaper.ImageIndex:= 1;
  end;
  spbGameRock.ImageIndex:= 0;
  spbGameScissors.ImageIndex:= 2;
  UserChoice:= 2;
end;

procedure TfrmMain.actGameScissorsExecute(Sender: TObject);
begin
  if spbGameScissors.ImageIndex = 2 then
  begin
    spbGameScissors.ImageIndex:= 5;
  end
  else
  begin
    spbGameScissors.ImageIndex:= 2;
  end;
  spbGameRock.ImageIndex:= 0;
  spbGamePaper.ImageIndex:= 1;
  UserChoice:= 3;
end;

procedure TfrmMain.actGameDrawExecute(Sender: TObject);
var
  aiChoice: Integer;
begin
  if (UserChoice > 0) and  (UserChoice < 4) then
  begin
    aiChoice:= Random(3) + 1;
    DecideWinner(aiChoice);
  end
  else
  begin
    ShowMessage('Please make a choice');
  end;
end;

procedure TfrmMain.DecideWinner(const aChoice: Integer);
begin
  case UserChoice of
    1: case aChoice of
      1: ShowMessage('AI: Rock'#13#10'Its'' a DRAW!!');
      2: begin
        ShowMessage('AI: Paper'#13#10'You loose!!');
        Inc(AIScore);
      end;
      3: begin
        ShowMessage('AI: Scissors'#13#10'You win!!');
        Inc(UserScore);
      end;
    end;
    2: case aChoice of
      1: begin
        ShowMessage('AI: Rock'#13#10'You win!!');
        Inc(UserScore);
      end;
      2: ShowMessage('AI: Paper'#13#10'Its'' a DRAW');
      3: begin
        ShowMessage('AI: Scissors'#13#10'You loose!!');
        Inc(AIScore);
      end;
    end;
    3: case aChoice of
      1: begin
        ShowMessage('AI: Rock'#13#10'You lose!!');
        Inc(AIScore);
      end;
      2: begin
        ShowMessage('AI: Paper'#13#10'You win!!');
        Inc(UserScore);
      end;
      3: ShowMessage('AI: Scissors'#13#10'Its'' a DRAW');
    end;
  end;
  ClearButtons;
  SetScores;
  UserChoice:= -1;
end;

procedure TfrmMain.InitShortcuts;
begin
{$IFDEF UNIX}
  actFileExit.ShortCut := KeyToShortCut(VK_Q, [ssCtrl]);
{$ENDIF}
{$IFDEF WINDOWS}
  actFileExit.ShortCut := KeyToShortCut(VK_X, [ssAlt]);
{$ENDIF}
end;

procedure TfrmMain.ClearButtons;
begin
  spbGameRock.ImageIndex:= 0;
  spbGamePaper.ImageIndex:= 1;
  spbGameScissors.ImageIndex:= 2;
end;

procedure TfrmMain.SetScores;
begin
  lblUserScore.Caption:= Format(rcUserScore, [UserScore]);
  lblAIScore.Caption:= Format(rcAIScore,[AIScore]);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Caption:= Format(rcFormCaption, [cVersionMajor, cVersionMinor, cVersionPatch]);

  UserChoice:= -1;
  UserScore:= 0;
  AIScore:= 0;

  InitShortcuts;
  ClearButtons;
  SetScores;
end;

end.

