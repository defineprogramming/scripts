import ctypes

def elevate_privileges():
    PROCESS_ALL_ACCESS = 0x1F0FFF
    TOKEN_ADJUST_PRIVILEGES = 0x0020
    SE_PRIVILEGE_ENABLED = 0x00000002
    SE_DEBUG_NAME = "SeDebugPrivilege"

    LUID = ctypes.Structure._fields_ = [
        ("LowPart", ctypes.c_ulong),
        ("HighPart", ctypes.c_long)
    ]

    LUID_AND_ATTRIBUTES = ctypes.Structure._fields_ = [
        ("Luid", LUID),
        ("Attributes", ctypes.c_ulong)
    ]

    TOKEN_PRIVILEGES = ctypes.Structure._fields_ = [
        ("PrivilegeCount", ctypes.c_ulong),
        ("Privileges", LUID_AND_ATTRIBUTES * 1)
    ]

    Advapi32 = ctypes.windll.Advapi32
    Kernel32 = ctypes.windll.Kernel32

    hToken = ctypes.c_void_p()
    luid = LUID()
    new_state = TOKEN_PRIVILEGES()

    Kernel32.GetCurrentProcess.restype = ctypes.c_void_p
    h_process = Kernel32.GetCurrentProcess()

    Advapi32.OpenProcessToken.restype = ctypes.c_bool
    if not Advapi32.OpenProcessToken(h_process, TOKEN_ADJUST_PRIVILEGES, ctypes.byref(hToken)):
        raise ctypes.WinError()

    Advapi32.LookupPrivilegeValueA.restype = ctypes.c_bool
    if not Advapi32.LookupPrivilegeValueA(None, SE_DEBUG_NAME, ctypes.byref(luid)):
        raise ctypes.WinError()

    new_state.PrivilegeCount = 1
    new_state.Privileges[0].Luid = luid
    new_state.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED

    Advapi32.AdjustTokenPrivileges.restype = ctypes.c_bool
    if not Advapi32.AdjustTokenPrivileges(hToken, False, ctypes.byref(new_state), 0, None, None):
        raise ctypes.WinError()

    hToken = None
    h_process = None

if __name__ == "__main__":
    try:
        elevate_privileges()
        print("Elevated privileges, you're now a badass!")
    except Exception as e:
        print("Failed to elevate privileges: {0}".format(e))
