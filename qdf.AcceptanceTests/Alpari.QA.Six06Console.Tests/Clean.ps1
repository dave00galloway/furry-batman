try
{

	$cleanDir = $args[1]
	#$cleanDir = "C:\Projects\qdf.acceptancetests\qdf.acceptancetests\Alpari.QA.Six06Console.Tests\bin\Debug"
	if(Test-Path -Path $cleanDir)
	{
		Remove-Item -Recurse -Force $cleanDir
	}
}
catch
{
	
} 
finally
{
	exit 0
}