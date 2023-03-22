@echo off
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
powershell -Command "& {$dll = '[DllImport(\"wininet.dll\", SetLastError = true)] public static extern bool InternetSetOption(IntPtr hInternet, int dwOption, IntPtr lpBuffer, int dwBufferLength); public static bool Refresh() { return InternetSetOption(IntPtr.Zero, 39, IntPtr.Zero, 0) && InternetSetOption(IntPtr.Zero, 37, IntPtr.Zero, 0); }'; add-type -MemberDefinition $dll -name wininet -namespace pinvoke; [pinvoke.wininet]::Refresh()}"
echo Proxy disabled.
pause
