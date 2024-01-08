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
$counterM = $counter

for(;;)
{
	try
	{	
		$counter  = 0
		$Monitors = Get-WmiObject WmiMonitorID -Namespace root\wmi
		ForEach ($Monitor in $Monitors) {  
			$counter=$counter + 1
		}			
		#echo "Мониторов= $counter"  #посчитали количество строк		
		if ($counter -gt 1) {
			echo "Мониторов = $counter" 
			if ($counter -gt $counterM) {
				#echo "L Мониторов Не $counterM изменилось!"            
			} else {
				#echo "L Мониторов увеличилось!! ЗАПУСК !!!"
				# ТЕЛО ЗАПУСКА				
                		try { & 'C:\Windows\System32\taskkill.exe' '/F', '/IM', 'MacroscopClient.exe'} catch {}				
				& 'C:\Users\oxran\AppData\Local\Programs\Macroscop Client\MacroscopClient.exe'				
				# Программа перезапустилась, обнуляем счетчик				
				$counterM = $counter 
			}

		} else { #	($counter -eq 2)                        	
			$counterM = $counter
			#echo "L Мониторов меньше 2 ровняем переменные $counter  $counterM"  #Мониторов < 2
		}
	}
	catch
	{
	}
	Start-sleep -s 6
}
