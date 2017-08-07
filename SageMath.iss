#define MyAppName "SageMath"

#ifndef SageVersion
  #error SageVersion must be defined--pass /DSageVersion=<version> to InnoSetup with the correct version
#endif

#ifndef SageArch
  #define SageArch "x86_64"
#endif

#if SageArch == "x86_64"
  #define MyArchitecturesAllowed "x64"
#else
  #define MyArchitecturesAllowed "x86 x64"
#endif

#define MyAppVersion SageVersion
#define MyAppPublisher "SageMath"
#define MyAppURL "http://www.sagemath.org/"
#define MyAppContact "http://www.sagemath.org/"

#define SageGroupName MyAppName + " " + MyAppVersion

#ifndef Compression
  #define Compression "lzma"
#endif

#ifndef EnvsDir
  #define EnvsDir "envs"
#endif

#ifndef OutputDir
  #define OutputDir "dist"
#endif

#ifndef DiskSpanning
  #if Compression == "none"
    #define DiskSpanning="yes"
  #else
    #define DiskSpanning="no"
  #endif
#endif

#define Runtime     "{app}\runtime"
#define Bin         Runtime + "\bin"
#define SageRootWin Runtime + "\opt\sagemath-" + MyAppVersion
#define SageRootPosix "/opt/sagemath-" + MyAppVersion

[Setup]
AppCopyright={#MyAppPublisher}
AppId={#MyAppName}-{#MyAppVersion}
AppContact={#MyAppContact}
AppComments={#MyAppURL}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
ArchitecturesAllowed={#MyArchitecturesAllowed}
ArchitecturesInstallIn64BitMode=x64
DefaultDirName={pf}\{#SageGroupName}
DefaultGroupName={#SageGroupName}
DisableProgramGroupPage=yes
DisableWelcomePage=no
DiskSpanning={#DiskSpanning}
OutputDir={#OutputDir}
OutputBaseFilename={#MyAppName}-{#MyAppVersion}
Compression={#Compression}
SolidCompression=yes
WizardImageFile=resources\sage-banner.bmp
WizardSmallImageFile=resources\sage-sticker.bmp
WizardImageStretch=yes
UninstallDisplayIcon={app}\unins000.exe
SetupIconFile=resources\sage-floppy-disk.ico
ChangesEnvironment=true
SetupLogging=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: startmenu; Description: "Create &start menu icons"; GroupDescription: "Additional icons"
Name: desktop; Description: "Create &desktop icons"; GroupDescription: "Additional icons"

[Files]
Source: "dot_sage\*"; DestDir: "{#SageRootWin}\dot_sage"; Flags: recursesubdirs ignoreversion
Source: "{#EnvsDir}\runtime-{#SageVersion}-{#SageArch}\*"; DestDir: "{#Runtime}"; Flags: recursesubdirs ignoreversion
Source: "resources\sagemath.ico"; DestDir: "{app}"; Flags: ignoreversion; AfterInstall: FixupSymlinks

; InnoSetup will not create empty directories found when including files
; recursively in the [Files] section, so any directories that must exist
; (but start out empty) in the cygwin distribution must be created
;
; /etc/fstab.d is where user-specific mount tables go--this is used in
; sage for windows by /etc/sagerc to set up the /dot_sage mount point for
; each user's DOT_SAGE directory, since the actual path name might contain
; spaces and other special characters not handled well by some software that
; uses DOT_SAGE
;
; /dev/shm and /dev/mqueue are used by the system for POSIX semaphores, shared
; memory, and message queues and must be created world-writeable
[Dirs]
Name: "{#Runtime}\etc\fstab.d"; Permissions: users-modify
Name: "{#Runtime}\dev\shm"; Permissions: users-modify
Name: "{#Runtime}\dev\mqueue"; Permissions: users-modify

[UninstallDelete]
Type: filesandordirs; Name: "{#Runtime}\etc\fstab.d"
Type: filesandordirs; Name: "{#Runtime}\dev\shm"
Type: filesandordirs; Name: "{#Runtime}\dev\mqueue"

#define RunSage "/bin/bash --login -c '" + SageRootPosix + "/sage'"
#define RunSageName "SageMath " + SageVersion
#define RunSageTitle "SageMath " + SageVersion + " Console"
#define RunSageDoc "The SageMath console interface"

#define RunSageSh "/bin/bash --login -c '" + SageRootPosix + "/sage -sh'"
#define RunSageShName "SageMath " + SageVersion + " Shell"
#define RunSageShTitle RunSageShName
#define RunSageShDoc "Command prompt in the SageMath shell environment"

#define RunSageNb "/bin/bash --login -c '" + SageRootPosix + "/sage --notebook jupyter'"
#define RunSageNbName "SageMath " + SageVersion + " Notebook"
#define RunSageNbTitle "SageMath " + SageVersion + " Notebook Server"
#define RunSageNbDoc "Start SageMath notebook server"

[Icons]
Name: "{app}\{#RunSageName}"; Filename: "{#Bin}\mintty.exe"; Parameters: "-t '{#RunSageTitle}' -i sagemath.ico {#RunSage}"; WorkingDir: "{app}"; Comment: "{#RunSageDoc}"; IconFilename: "{app}\sagemath.ico"
Name: "{group}\{#RunSageName}"; Filename: "{#Bin}\mintty.exe"; Parameters: "-t '{#RunSageTitle}' -i sagemath.ico {#RunSage}"; WorkingDir: "{app}"; Comment: "{#RunSageDoc}"; IconFilename: "{app}\sagemath.ico"; Tasks: startmenu
Name: "{commondesktop}\{#RunSageName}"; Filename: "{#Bin}\mintty.exe"; Parameters: "-t '{#RunSageTitle}' -i sagemath.ico {#RunSage}"; WorkingDir: "{app}"; Comment: "{#RunSageDoc}"; IconFilename: "{app}\sagemath.ico"; Tasks: desktop

Name: "{app}\{#RunSageShName}"; Filename: "{#Bin}\mintty.exe"; Parameters: "-t '{#RunSageShTitle}' -i sagemath.ico {#RunSageSh}"; WorkingDir: "{app}"; Comment: "{#RunSageShDoc}"; IconFilename: "{app}\sagemath.ico"
Name: "{group}\{#RunSageShName}"; Filename: "{#Bin}\mintty.exe"; Parameters: "-t '{#RunSageShTitle}' -i sagemath.ico {#RunSageSh}"; WorkingDir: "{app}"; Comment: "{#RunSageShDoc}"; IconFilename: "{app}\sagemath.ico"; Tasks: startmenu
Name: "{commondesktop}\{#RunSageShName}"; Filename: "{#Bin}\mintty.exe"; Parameters: "-t '{#RunSageShTitle}' -i sagemath.ico {#RunSageSh}"; WorkingDir: "{app}"; Comment: "{#RunSageShDoc}"; IconFilename: "{app}\sagemath.ico"; Tasks: desktop

Name: "{app}\{#RunSageNbName}"; Filename: "{#Bin}\mintty.exe"; Parameters: "-t '{#RunSageNbTitle}' -i sagemath.ico {#RunSageNb}"; WorkingDir: "{app}"; Comment: "{#RunSageNbDoc}"; IconFilename: "{app}\sagemath.ico"
Name: "{group}\{#RunSageNbName}"; Filename: "{#Bin}\mintty.exe"; Parameters: "-t '{#RunSageNbTitle}' -i sagemath.ico {#RunSageNb}"; WorkingDir: "{app}"; Comment: "{#RunSageNbDoc}"; IconFilename: "{app}\sagemath.ico"; Tasks: startmenu
Name: "{commondesktop}\{#RunSageNbName}"; Filename: "{#Bin}\mintty.exe"; Parameters: "-t '{#RunSageNbTitle}' -i sagemath.ico {#RunSageNb}"; WorkingDir: "{app}"; Comment: "{#RunSageNbDoc}"; IconFilename: "{app}\sagemath.ico"; Tasks: desktop

[Code]
procedure FixupSymlinks();
var
    n: Integer;
    i: Integer;
    resultCode: Integer;
    filenames: TArrayOfString;
    filenam: String;
begin
    LoadStringsFromFile(ExpandConstant('{#Runtime}\etc\symlinks.lst'), filenames);
    n := GetArrayLength(filenames);
    WizardForm.ProgressGauge.Min := 0;
    WizardForm.ProgressGauge.Max := n - 1;
    WizardForm.ProgressGauge.Position := 0;
    WizardForm.StatusLabel.Caption := 'Fixing up symlinks...';
    for i := 0 to n - 1 do
    begin
        filenam := filenames[i];
        WizardForm.FilenameLabel.Caption := Copy(filenam, 2, Length(filenam));
        WizardForm.ProgressGauge.Position := i;
        Exec(ExpandConstant('{sys}\attrib.exe'), '+S ' + filenam,
                            ExpandConstant('{#Runtime}'), SW_HIDE,
                            ewNoWait, resultCode);
    end;
end;
