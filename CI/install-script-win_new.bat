
set DepsBaseOBS=%cd%\obs_deps_windows\
echo DepsBaseOBS %DepsBaseOBS%
dir

if defined GOOGLE_API_KEY (
  if "%GOOGLE_API_KEY%" == "$(GOOGLE_API_KEY)" (
    echo ignoring azure env arg
  ) else (
    echo building with hardcoded compiled API key
    set API_OR_UI_KEY_ARG="-DGOOGLE_API_KEY=%GOOGLE_API_KEY%"
  )
)

if not defined API_OR_UI_KEY_ARG (
    echo building with custom user API key UI
    set API_OR_UI_KEY_ARG="-DENABLE_CUSTOM_API_KEY=ON"
)

cd deps
cmd /C clone_plibsys.cmd
cd ..

:: 64 bit build
mkdir build_64
cd build_64

cmake.exe ../../ ^
-DSPEECH_API_GOOGLE_HTTP_OLD=ON ^
-DOBS_SOURCE_DIR='C:\Users\vikas\Documents\Brown_MSCS\Spring2021\CS1301\obs-studio-new' ^
-DOBS_LIB_DIR='C:\Users\vikas\Documents\Brown_MSCS\Spring2021\CS1301\obs-studio-new\build' ^
-DQT_DIR='C:\Qt\5.15.0\msvc2019_64' ^
 -G "Visual Studio 16 2019" ^
"%API_OR_UI_KEY_ARG%"
