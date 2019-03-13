Func Install($config)
   Local $install = $config.Item("install")
   ConsoleWrite($install & @LF)
   ; Run installation program
   Run($install)

   WinWaitActive("CLICK Programming Software Version 2.30", "Welcome to the InstallShield")
   Send("!n")
   WinWaitActive("CLICK Programming Software Version 2.30", "Before continuing")
   Send("{ENTER}")
   WinWaitActive("CLICK Programming Software Version 2.30", "IMPORTANT")
   Send("!a")
   WinWaitActive("CLICK Programming Software Version 2.30", "IMPORTANT")
   Send("!n")
   WinWaitActive("CLICK Programming Software Version 2.30", "Please enter your name")
   Send("!n")
   WinWaitActive("CLICK Programming Software Version 2.30", "Choose Destination")
   Send("!n")
   WinWaitActive("CLICK Programming Software Version 2.30", "begin the installation")
   Send("!i")
   WinWaitActive("CLICK Programming Software Version 2.30", "Create a Desktop")
   Send("!n")
   WinWaitActive("CLICK Programming Software Version 2.30", "InstallShield Wizard Complete")
   Send("{ENTER}")

EndFunc

Local $config = ObjCreate("Scripting.Dictionary")
$config.Add("install", $CmdLine[1])

Install($config)
ConsoleWrite("End of click-pcl" & @LF)