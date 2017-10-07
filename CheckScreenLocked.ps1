<#


Checks if workstation is locked cntrl+alt+del



#>

$Source = @"
 using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;


namespace Sample
{
	public static class PSTest
	{
		private static string _result = "";
		const int DESKTOP_SWITCHDESKTOP = 256;

		[DllImport("user32", EntryPoint = "OpenDesktopA",
			 CharSet = CharSet.Ansi,
			 SetLastError = true,
			 ExactSpelling = true)]
		private static extern Int32 OpenDesktop(string lpszDesktop,
												Int32 dwFlags,
												bool fInherit,
												Int32 dwDesiredAccess);

		[DllImport("user32", CharSet = CharSet.Ansi,
							 SetLastError = true,
							 ExactSpelling = true)]
		private static extern Int32 CloseDesktop(Int32 hDesktop);

		[DllImport("user32", CharSet = CharSet.Ansi,
							 SetLastError = true,
							 ExactSpelling = true)]
		private static extern Int32 SwitchDesktop(Int32 hDesktop);

		public static string Get()
		{


			if (IsSystemLocked())
			{
				_result = "Workstation is Locked";
				return _result;
			}
			else
			{
				_result = "Workstation is Unlocked";
				return _result;

			}
		}
		public static bool IsSystemLocked()
		{

			int hwnd = -1;
			int rtn = -1;

			try
			{
				hwnd = OpenDesktop("Default", 0, false, DESKTOP_SWITCHDESKTOP);

				if (hwnd != 0)
				{
					rtn = SwitchDesktop(hwnd);
					if (rtn == 0)
					{
						// Locked
						CloseDesktop(hwnd);
						return true;
					}
					else
					{
						CloseDesktop(hwnd);
					}
				}
				else
				{
				}
			}
			catch
			{
				return false;
			}
			return false;

		}
	}

	}

"@


Add-Type -TypeDefinition $Source -Language CSharp 


[Sample.PSTest]::Get()

 