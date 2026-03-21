
$commitMessages = @(
    "Refactor: decouple utility functions", "Fix: resolve minor UI consistency issues",
    "Docs: update README", "Update: add support for dynamic config",
    "Style: improve accessibility", "Perf: optimize data processing",
    "Test: implement unit tests", "Chore: update dependencies",
    "Feature: add initial support for error logging", "Refactor: simplify data transformation",
    "Docs: add contributing guidelines", "Fix: handle potential null-reference"
)

# Function to commit on a specific day multiple times
function Commit-On-Date {
    param([datetime]$date, [int]$count)
    for ($i = 0; $i -lt $count; $i++) {
        $msg = Get-Random -InputObject $commitMessages
        $randomMin = Get-Random -Minimum 0 -Maximum 60
        $randomSec = Get-Random -Minimum 0 -Maximum 60
        $finalDate = $date.AddMinutes($randomMin).AddSeconds($randomSec)
        $formattedDate = $finalDate.ToString("yyyy-MM-ddTHH:mm:ss")
        $Env:GIT_AUTHOR_DATE = $formattedDate
        $Env:GIT_COMMITTER_DATE = $formattedDate
        git commit --allow-empty -m "$msg" --quiet
    }
}

# --- PART 1: "SUBASH" Contribution Art in 2023 ---
# 2023 starts on Week 0. We'll start letters at Week 8.
# Grid size: 7 rows (y: 0-6), 52/53 weeks (x: 0-52)
$charMap = @{
    'S' = @(@(0,0),@(1,0),@(2,0),@(3,0),@(4,0), @(0,1), @(0,2),@(1,2),@(2,2),@(3,2),@(4,2), @(4,3), @(0,4),@(1,4),@(2,4),@(3,4),@(4,4));
    'U' = @(@(0,0),@(0,1),@(0,2),@(0,3),@(0,4), @(4,0),@(4,1),@(4,2),@(4,3),@(4,4), @(1,4),@(2,4),@(3,4));
    'B' = @(@(0,0),@(0,1),@(0,2),@(0,3),@(0,4), @(1,0),@(2,0),@(3,0), @(4,1), @(1,2),@(2,2), @(4,3), @(1,4),@(2,4),@(3,4));
    'A' = @(@(0,1),@(0,2),@(0,3),@(0,4), @(4,1),@(4,2),@(4,3),@(4,4), @(1,0),@(2,0),@(3,0), @(1,2),@(2,2),(3,2));
    'H' = @(@(0,0),@(0,1),@(0,2),@(0,3),@(0,4), @(4,0),@(4,1),@(4,2),@(4,3),@(4,4), @(1,2),@(2,2),@(3,2));
}

$name = "SUBASH"
$startWeek = 8
$currentWeek = $startWeek
$commitCountPerPixel = 25 # High count for "Many Contribution" (Dark Green)

# Find Jan 1st of 2023
$jan1_2023 = [datetime]::new(2023, 1, 1, 12, 0, 0)
# Adjust to start of the first week of 2023 (Sunday)
$firstSunday = $jan1_2023.AddDays(-[int]$jan1_2023.DayOfWeek)

foreach ($c in $name.ToCharArray()) {
    $pixels = $charMap[$c.ToString()]
    foreach ($p in $pixels) {
        $x = $p[0] + $currentWeek
        $y = $p[1] + 1 # Offset y by 1 to center vertically (1-5 out of 0-6)
        $targetDate = $firstSunday.AddDays($x * 7 + $y)
        Commit-On-Date -date $targetDate -count $commitCountPerPixel
    }
    $currentWeek += 6 # 5 for char + 1 space
}

# --- PART 2: Random 1-10 Commits for 2024-2026 ---
$startDate = [datetime]::new(2024, 9, 12, 10, 0, 0)
$endDate = Get-Date # Today

$currentDate = $startDate
while ($currentDate -le $endDate) {
    if ((Get-Random -Minimum 1 -Maximum 11) -le 9) { # 90% chance of activity
        $numCommits = Get-Random -Minimum 1 -Maximum 11 # 1 to 10
        Commit-On-Date -date $currentDate.AddHours(12) -count $numCommits
        Start-Sleep -Milliseconds 10
    }
    $currentDate = $currentDate.AddDays(1)
}

Remove-Item Env:GIT_AUTHOR_DATE
Remove-Item Env:GIT_COMMITTER_DATE
Write-Host "Done! Art 'SUBASH' created for 2023 and random 1-10 history generated for 2024-today."
