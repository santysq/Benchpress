$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
$myName = $MyInvocation.MyCommand.Name -replace '\.ezformat\.ps1', ''
 
$formatting = @(
    $groupBy = { $_.FileName + ' ' + $_.GroupName }

    Write-FormatView -TypeName Benchmark.Detail -Property Command, 
        RepeatCount, TotalTime, AverageTime,FastestTime,SlowestTime -Width 40 -AutoSize -Wrap -GroupByScript $groupBy -GroupLabel 'Benchmark' 

    Write-FormatView -TypeName Benchmark.Relative.Summary -Property Technique, Timing, RelativeSpeed -GroupByScript  $groupBy -GroupLabel 'Benchmark'
)

$formatting | Out-FormatData | Set-Content -Path (Join-Path $myRoot "$myName.format.ps1xml")
