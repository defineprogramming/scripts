import ctypes

def reset_group_policies():
    try:
        # Load the necessary DLLs
        kernel32 = ctypes.WinDLL('kernel32')
        advapi32 = ctypes.WinDLL('Advapi32')
        
        # Enable privileges
        hToken = ctypes.c_void_p()
        TOKEN_ADJUST_PRIVILEGES = 0x0020
        kernel32.OpenProcessToken(kernel32.GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES, ctypes.byref(hToken))

        # Set up the privilege structure
        class LUID(ctypes.Structure):
            _fields_ = [('LowPart', ctypes.c_ulong), ('HighPart', ctypes.c_long)]
        
        luid = LUID()
        advapi32.LookupPrivilegeValueA(None, "SeRestorePrivilege".encode('utf-8'), ctypes.byref(luid))

        class LUID_AND_ATTRIBUTES(ctypes.Structure):
            _fields_ = [('Luid', LUID), ('Attributes', ctypes.c_ulong)]
        
        class TOKEN_PRIVILEGES(ctypes.Structure):
            _fields_ = [('PrivilegeCount', ctypes.c_ulong), ('Privileges', LUID_AND_ATTRIBUTES)]

        privs = TOKEN_PRIVILEGES()
        privs.PrivilegeCount = 1
        privs.Privileges = LUID_AND_ATTRIBUTES(Luid=luid, Attributes=0x2)
        advapi32.AdjustTokenPrivileges(hToken, False, ctypes.byref(privs), 0, None, None)

        # Modify the registry & delete the group policy keys
        key = ctypes.c_ulong()
        advapi32.RegOpenKeyExA(0x80000002, "SOFTWARE\\Policies\\Microsoft".encode('utf-8'), 0, 0x20019, ctypes.byref(key))
        advapi32.RegDeleteTreeA(key, None)

        advapi32.RegCloseKey(key)
        print("Group policies have been reset.")

    except Exception as e:
        print(f"Unexpected error: {str(e)}")
        print("You might need admin privileges for executing this.")

if __name__ == "__main__":
    reset_group_policies()
