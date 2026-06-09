# Check disk space usage
$folders = @(
    @{Path='C:\Users\ASUS\AppData\Local\Temp'; Desc='Temp (Local)'},
    @{Path='C:\Windows\Temp'; Desc='Temp (Windows)'},
    @{Path='C:\Users\ASUS\AppData\Local\npm-cache'; Desc='npm cache'},
    @{Path='C:\Users\ASUS\.gradle'; Desc='Gradle cache'},
    @{Path='C:\Users\ASUS\.m2'; Desc='Maven cache'},
    @{Path='C:\Users\ASUS\.cargo'; Desc='Cargo cache'},
    @{Path='C:\Users\ASUS\.rustup'; Desc='Rust toolchain'},
    @{Path='C:\Users\ASUS\AppData\Local\pip'; Desc='pip cache'},
    @{Path='C:\Users\ASUS\AppData\Roaming\npm'; Desc='npm global'},
    @{Path='C:\Users\ASUS\AppData\Local\Microsoft'; Desc='Microsoft data'},
    @{Path='C:\Users\ASUS\AppData\Roaming\Code'; Desc='VS Code data'},
    @{Path='C:\Users\ASUS\AppData\Local\Programs'; Desc='User programs'},
    @{Path='C:\Users\ASUS\AppData\Local\Docker'; Desc='Docker data'},
    @{Path='C:\$Recycle.Bin'; Desc='Recycle Bin'},
    @{Path='C:\Windows\SoftwareDistribution'; Desc='Win Update cache'},
    @{Path='C:\Windows\Installer'; Desc='MSI installers'},
    @{Path='C:\Users\ASUS\AppData\Local\pnpm-cache'; Desc='pnpm cache'},
    @{Path='C:\Users\ASUS\AppData\Local\Yarn'; Desc='Yarn cache'},
    @{Path='C:\Windows\Prefetch'; Desc='Prefetch'},
    @{Path='C:\Users\ASUS\AppData\Local\CrashDumps'; Desc='Crash dumps'},
    @{Path='C:\Users\ASUS\.cache'; Desc='Generic cache'},
    @{Path='C:\Users\ASUS\scoop'; Desc='Scoop package manager'},
    @{Path='C:\Users\ASUS\AppData\Local\electron'; Desc='Electron cache'},
    @{Path='C:\Users\ASUS\AppData\Local\pnpm'; Desc='pnpm store'}
)

Write-Host "=== Scanning C drive folders ==="
Write-Host ""

foreach ($item in $folders) {
    $size = 0
    if (Test-Path $item.Path) {
        try {
            $size = (Get-ChildItem -Path $item.Path -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
        } catch {}
    }
    $sizeMB = [math]::Round($size / 1MB, 1)
    if ($sizeMB -gt 0.1) {
        Write-Host ("{0,8} MB - {1,-25} [{2}]" -f $sizeMB, $item.Desc, $item.Path)
    } elseif ($sizeMB -gt 0) {
        Write-Host ("    <0.1 MB - {0,-25} [{1}]" -f $item.Desc, $item.Path)
    } else {
        Write-Host ("   (empty/none) - {0}" -f $item.Desc)
    }
}

Write-Host ""
Write-Host "=== Top 15 largest AppData/Local subfolders ==="
Get-ChildItem -Path "C:\Users\ASUS\AppData\Local" -Directory -ErrorAction SilentlyContinue |
    ForEach-Object {
        $size = 0
        try { $size = (Get-ChildItem $_.FullName -Recurse -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum } catch {}
        [PSCustomObject]@{Name=$_.Name; SizeMB=[math]::Round($size/1MB,1)}
    } |
    Sort-Object -Property SizeMB -Descending |
    Select-Object -First 15 |
    ForEach-Object { Write-Host ("{0,8} MB - {1}" -f $_.SizeMB, $_.Name) }

Write-Host ""
Write-Host "=== Top 15 largest AppData/Roaming subfolders ==="
Get-ChildItem -Path "C:\Users\ASUS\AppData\Roaming" -Directory -ErrorAction SilentlyContinue |
    ForEach-Object {
        $size = 0
        try { $size = (Get-ChildItem $_.FullName -Recurse -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum } catch {}
        [PSCustomObject]@{Name=$_.Name; SizeMB=[math]::Round($size/1MB,1)}
    } |
    Sort-Object -Property SizeMB -Descending |
    Select-Object -First 15 |
    ForEach-Object { Write-Host ("{0,8} MB - {1}" -f $_.SizeMB, $_.Name) }
