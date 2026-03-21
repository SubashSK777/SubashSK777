
$charMap = @{
    'S' = @(@(0,0),@(1,0),@(2,0),@(3,0),@(4,0), @(0,1), @(0,2),@(1,2),@(2,2),@(3,2),@(4,2), @(4,3), @(0,4),@(1,4),@(2,4),@(3,4),@(4,4));
    'U' = @(@(0,0),@(0,1),@(0,2),@(0,3), @(4,0),@(4,1),@(4,2),@(4,3), @(0,4),@(1,4),@(2,4),@(3,4),@(4,4));
    'B' = @(@(0,0),@(0,1),@(0,2),@(0,3),@(0,4), @(1,0),@(2,0),@(3,0), @(4,1), @(1,2),@(2,2),@(3,2), @(4,3), @(1,4),@(2,4),@(3,4));
    'A' = @(@(0,1),@(0,2),@(0,3),@(0,4), @(4,1),@(4,2),@(4,3),@(4,4), @(1,0),@(2,0),@(3,0), @(1,2),@(2,2),@(3,2));
    'H' = @(@(0,0),@(0,1),@(0,2),@(0,3),@(0,4), @(4,0),@(4,1),@(4,2),@(4,3),@(4,4), @(1,2),@(2,2),@(3,2));
}

function Commit-On-Date {
    param([datetime]$date, [int]$count)
    for ($i = 0; $i -lt $count; $i++) {
        $msg = "SUBASH Art Pixel"
        
        $formattedDate = $date.AddMinutes($i).ToString("yyyy-MM-ddTHH:mm:ss")
        $Env:GIT_AUTHOR_DATE = $formattedDate
        $Env:GIT_COMMITTER_DATE = $formattedDate
        git commit --allow-empty -m "$msg" --quiet
    }
}

$name = "SUBASH"
$startWeek = 8
$currentWeek = $startWeek
$commitCountPerPixel = 30 # Generates extremely dark green

# First Sunday of the chart for the year 2024
$firstSunday = [datetime]::new(2023, 12, 31, 12, 0, 0)

foreach ($c in $name.ToCharArray()) {
    $pixels = $charMap[$c.ToString()]
    foreach ($p in $pixels) {
        $x = $p[0] + $currentWeek
        $y = $p[1] + 1 # Shift down by 1 row out of 7, to center vertically
        $targetDate = $firstSunday.AddDays($x * 7 + $y)
        Commit-On-Date -date $targetDate -count $commitCountPerPixel
    }
    $currentWeek += 6
}

Remove-Item Env:GIT_AUTHOR_DATE -ErrorAction SilentlyContinue
Remove-Item Env:GIT_COMMITTER_DATE -ErrorAction SilentlyContinue

Write-Host "2024 SUBASH graph commits generated successfully!"
