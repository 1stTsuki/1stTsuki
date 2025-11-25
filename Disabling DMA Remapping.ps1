# Script by 1stTsuki - All rights reserved
# WARNING: This script is intended for Windows 24H2 and above only! Do NOT use on older versions.

function Show-Dragon {
    $dragon = @"
                                            VVVVVVVVVVVVVVVV
                                      WVVVVVVVVVVVVVVVVVVVVVVVVVW
                                  WVVVVVVVVVVVVVVVVVVVWVVVVVVVVVVVVVV
                                  VVVVVVWVV                 VVVVVVVVVVVV
                               VV  VVV        W                  VVVVVVVVV
                           VVW  VV             VV                   WVVVVVVV
                          VVVV  WVVV           WVVV                   WVVVVVVV
                        VVVVVV   VVVVW           VVVVV                  VVVVVVV
                       VVVVVV     VVVVVVW          VVVVVV                 VVVVVV
                      VVVVVV       VVVVVVVVV        VVVVVVV                VVVVVVV
                     WVVVVV          VVVVVVVVVVVWV       WWW                 VVVVV
                    VVVVVV             VVVVVVVVVVVVVVVVVWVVVV                 VVVVW
                   WVVVVV           WVV    VVVVVVVVVVVVVVVVVVVVV              WVVVVV
                   VVVVV      VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV             VVVVVV
                  WVVVV         WVVVVVVVVVVVVVVVVVVVVVVVVVV    WVVV             VVVVV
                  VVVVW          VVVVVVVVVVVVVVVVVVVVVVVVVVVV   VVVW            VVVVV
                  VVVVV       WVVVVVVVVVVVVVVVWWWVVVVVVVVVVVVVVVVVVV            VVVVVW
                 VWVVWW     WVVVVVVVVVVVVVV     VVVVVVVVVVVVVVVVVVVVVVVWWVW      VVVVV
                 VVVVVW   VVVVVVVVVVVVVVW      WVVVVVVVVVVW        VVVVVW WVV    VVVVV
                 VVVVVW  VW  VVVVVVVVVVV  VV   VVVVVVVWVVVVVV         VVVVVVV    VVVVW
                  VVVVV     VVVVVVVVVV   VV              WVVVW    VV    VVVV     VVVVV
                  VVVVV    VVVVVVVVVVV   VV                WVVV    VV           VVVVVW
                  VVVVV   VVVVVVVVVVVV  WVVW                VVVVVW VVVW          WWVW
                   VVVVV  VVVVVVVVVVVV   VVW               WVVVW    VVVVVVVWVVWVVVW
                   VVVVVW VVVVVVVVVVVW   WVVV                       VVVVVVVVVVVVV
                    VVVVVVWVVVVVVVVVVV    VVVVV                     WVVVVVVVVVVVVVV
                     VVVVVWVVVVVVVVVVVY    VVVVVW                    VVVVWVWVVVVVVVVVVV
                      VVVVVVVVVVVVVVVVV     VVVVVVV                   VV     UVVVVVWVVW
                       VVVVVVVVVVVVVVVVV     VVVVVVVV                     WVVV
                        VVVVVVVVVVVVVVVVV      VVVVVVVVVW                VVVVVV
                         WVVVVVVVVVVVVVVVVW      VVVVVVVVVVVWW         WVVVVWW
                           VVVVVVVVVVVVVVVVV       VVVVVVVVVVVVVVVVVVVVVVVVV
                             VVVVVVVVVVVVVVVVV       VVWVVVVVVVVVVVVVVVVVV
                               WVVVVVVVVVVVVVVVVW        VVVVVVVVVVVVVVV
                                  VVVVVVVVVVVVVVVVVVUWVVVVVVVVVVVVVVV
                                     VVVVVVVVVVVVVVVVVVVVVVVVVVVVW
                                          XVVVVVVVVVVVVVVVVVW
"@
    Write-Host $dragon -ForegroundColor Red
    Write-Host ""
}

function Show-Menu($lastOption) {
    Write-Host ""
    Write-Host "Choose the operation (last used highlighted):"
    if ($lastOption -eq "1") {
        Write-Host "1 - Disable DMA remapping" -ForegroundColor Red
    } else {
        Write-Host "1 - Disable DMA remapping"
    }
    if ($lastOption -eq "2") {
        Write-Host "2 - Revert" -ForegroundColor Red
    } else {
        Write-Host "2 - Revert"
    }
    if ($lastOption -eq "3") {
        Write-Host "3 - Exit" -ForegroundColor Red
    } else {
        Write-Host "3 - Exit"
    }
}

function Is-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Is-Admin)) {
    Write-Host "ERROR: This script must be run as Administrator! Exiting..."
    exit
}

$basePath = "HKLM:\SYSTEM\CurrentControlSet\Enum\PCI"
$logPath = "$env:TEMP\LastOption.txt"
$lastOption = $null
if (Test-Path $logPath) {
    $lastOption = Get-Content $logPath
}

do {
    Clear-Host
    Show-Dragon
    Write-Host "WARNING: This script is intended for Windows 24H2 and above only! Do NOT use on older versions."
    Write-Host "Script by 1stTsuki - All rights reserved."
    Show-Menu $lastOption
    $option = Read-Host "Enter your choice"
    $devices = Get-ChildItem -Path $basePath -ErrorAction SilentlyContinue
    $lastOption = $option
    Set-Content -Path $logPath -Value $option

    if ($option -eq "1") {
        Clear-Host
        Show-Dragon
        Write-Host "Disabling DMA remapping for all supported devices..." -ForegroundColor Cyan
        foreach ($device in $devices) {
            $instances = Get-ChildItem -Path $device.PSPath -ErrorAction SilentlyContinue
            foreach ($instance in $instances) {
                $dmaPath = "$($instance.PSPath)\Device Parameters\DMA Management"
                if (Test-Path $dmaPath) {
                    try {
                        Set-ItemProperty -Path $dmaPath -Name "RemappingSupported" -Value 0 -Type DWord -ErrorAction Stop
                        $readValue = (Get-ItemProperty -Path $dmaPath -Name "RemappingSupported" -ErrorAction SilentlyContinue).RemappingSupported
                        Write-Host "[OK] Disabled for: $($instance.PSChildName) (Current value: $readValue)"
                    } catch {
                        Write-Host "[Error] Could not disable for: $($instance.PSChildName) | $($_.Exception.Message)" -ForegroundColor Red
                    }
                } else {
                    Write-Host "[Skip] $($instance.PSChildName) has no DMA Management key."
                }
            }
        }
        Write-Host "Supported PCI device instances updated. Script by 1stTsuki. Please reboot to apply changes."
        Write-Host ""
        Read-Host "Press Enter to return to menu..."
    }
    elseif ($option -eq "2") {
        Clear-Host
        Show-Dragon
        Write-Host "Reverting: setting RemappingSupported to 1 (default recommended)..." -ForegroundColor Magenta
        foreach ($device in $devices) {
            $instances = Get-ChildItem -Path $device.PSPath -ErrorAction SilentlyContinue
            foreach ($instance in $instances) {
                $dmaPath = "$($instance.PSPath)\Device Parameters\DMA Management"
                if (Test-Path $dmaPath) {
                    try {
                        Set-ItemProperty -Path $dmaPath -Name "RemappingSupported" -Value 1 -Type DWord -ErrorAction Stop
                        $readValue = (Get-ItemProperty -Path $dmaPath -Name "RemappingSupported" -ErrorAction SilentlyContinue).RemappingSupported
                        Write-Host "[OK] Reverted for: $($instance.PSChildName) (Current value: $readValue)"
                    } catch {
                        Write-Host "[Error] Could not revert for: $($instance.PSChildName) | $($_.Exception.Message)" -ForegroundColor Red
                    }
                } else {
                    Write-Host "[Skip] $($instance.PSChildName) has no DMA Management key."
                }
            }
        }
        Write-Host "PCI device instances reverted to opt-in. Script by 1stTsuki. Please reboot to apply changes."
        Write-Host ""
        Read-Host "Press Enter to return to menu..."
    }
    elseif ($option -eq "3") {
        Write-Host "Exiting script. Bye!" -ForegroundColor Yellow
        break
    }
    else {
        Write-Host "Invalid option! Please try again." -ForegroundColor Red
        Read-Host "Press Enter to return to menu..."
    }
} while ($true)
