$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Write-host "My directory is $dir"

cd $dir 
cd ../
pwd
$SolutionDir = Get-Location
$SolutionDir
pwd
#########
#https://coderwall.com/p/0ycecq
#Note this currently works on the debug build, and is not currently integrated into the build process
$OutDir = "$dir\bin\Release"

# Set nunit path test runner
$nunit = "$SolutionDir\packages\NUnit.Runners.2.6.3\tools\nunit-console.exe"

#Find tests in OutDir
$tests = (Get-ChildItem $OutDir -Recurse -Include *qdf.AcceptanceTests.dll)

# Run tests
# & $nunit /noshadow /framework:"net-4.5" /xml:"$OutDir\TestResult.xml" $tests "/out:$OutDir\TestResult.txt" "/include=Pickles" "/labels"
& $nunit /noshadow /framework:"net-4.5" /xml:"$OutDir\TestResult.xml" $tests "/out:$OutDir\TestResult.txt" "/labels"
######
Write-host "My package is in $SolutionDir/packages\Pickles.0.13.1.0\tools\PicklesDoc.Pickles.PowerShell.dll"
Import-Module $SolutionDir/packages\Pickles.0.13.1.0\tools\PicklesDoc.Pickles.PowerShell.dll
Pickle-Features -FeatureDirectory $dir\Specs -OutputDirectory $dir\Pickles -SystemUnderTestName qdf.AcceptanceTests -DocumentationFormat DHTML -TestResultsFile $dir\bin\Release\TestResult.xml

cd $dir
$specflowReporter = "$SolutionDir\packages\SpecFlow.1.9.0\tools\specflow.exe"
$proj = "qdf.AcceptanceTests.csproj"
$xml = "$OutDir\TestResult.xml"

#run report
& $specflowReporter nunitexecutionreport $proj /xmlTestResult:"$xml" /out:"$OutDir\TestResult.html"

#open report
start "$OutDir\TestResult.html"

#open pickle
start "$dir\Pickles\Index.html"

#open docs
#start iexplore.exe "$dir\docs\Help\Index.html"
#start "$dir\docs\Help\Documentation.chm"



