#requires -Module Pester
#requires -Module PSScriptAnalyzer
#requires -Module InjectionHunter

$ScriptDirectory = "C:\Users\tg4445\Code\pwsh\stuff"

Import-Module -Name Pester -MinimumVersion 5.5.0 -Force -ErrorAction Stop
Import-Module -Name PSScriptAnalyzer -MinimumVersion 1.0.0 -Force -ErrorAction Stop
Import-Module -Name InjectionHunter -MinimumVersion 1.0.0  -Force -ErrorAction Stop

# $injectionHunterModulePath = Get-Module -Name InjectionHunter -ListAvailable | Select-Object -ExpandProperty Path

BeforeDiscovery {
    $scriptFiles = Get-ChildItem -Path $ScriptDirectory -Filter *.ps1
}

Clear-Host
Describe "Code Structure and Validation Tests" {
    Context "Code Validation" -ForEach $scriptFiles {
        It 'has no syntax errors' {

            $functionContents = $null
            $psParserErrorOutput = $null
            $functionContents = Get-Content -Path $_.FullName
            [System.Management.Automation.PSParser]::Tokenize($functionContents, [ref]$psParserErrorOutput)

			($psParserErrorOutput | Measure-Object).Count | Should -Be 0

        }
    }
}
