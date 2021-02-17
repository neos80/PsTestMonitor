#####################################################################
# Oleg Kosorukov (c) 2021
#####################################################################

$Monitors = Get-WmiObject WmiMonitorID -Namespace root\wmi
$LogFile  = "Log.txt"
$counter  = 0
$counterM = 0

#Первичное наполнение, текущее количество мониторов
$Monitors = Get-WmiObject WmiMonitorID -Namespace root\wmi
ForEach ($Monitor in $Monitors) {  
	$counter=$counter + 1
} 
if ($counter -eq 2) { $counterM = $counter}

for(;;)
{
	try
	{	
		$counter  = 0
		$Monitors = Get-WmiObject WmiMonitorID -Namespace root\wmi
		ForEach ($Monitor in $Monitors) {  
			$counter=$counter + 1
		}			
		#echo "1L Мониторов= $counter"  #посчитали количество строк		
		if ($counter -eq 2) {
			echo "2L Мониторов = $counter = 2"  #Мониторов 2
			if ($counter -eq $counterM) {
				#echo "5L Мониторов Не $counterM изменилось!"            
			} else {
				#echo "4L Мониторов стало 2!! ЗАПУСК !!!"
				# ТЕЛО ЗАПУСКА				
                		try { & 'C:\Windows\System32\taskkill.exe' '/F', '/IM', 'MacroscopClient.exe'} catch {}				
				& 'C:\Users\oxran\AppData\Local\Programs\Macroscop Client\MacroscopClient.exe' '-server', '192.168.1.100', '-port', '8080', '-user', 'admin', '-password', 'admin'				
				# Программа перезапустилась, обнуляем счетчик				
				$counterM = $counter 
			}

		} else { #	($counter -eq 2)                        	
			$counterM = $counter
			#echo "3L Мониторов != 2 ровняем переменные $counter  $counterM"  #Мониторов < 2
		}
	}
	catch
	{
	}
	Start-sleep -s 6
}
