# Windows post-processing script for HTML files
param($BuildDir)

Write-Host "Post-processing HTML titles..."

# Update page titles
if (Test-Path "$BuildDir/cv.html") {
    (Get-Content "$BuildDir/cv.html") -replace '<title>Curriculum Vitae</title>', '<title>CV | Siipola</title>' | Set-Content "$BuildDir/cv.html"
}
if (Test-Path "$BuildDir/research.html") {
    (Get-Content "$BuildDir/research.html") -replace '<title>Research</title>', '<title>Research | Siipola</title>' | Set-Content "$BuildDir/research.html"
}
if (Test-Path "$BuildDir/teaching.html") {
    (Get-Content "$BuildDir/teaching.html") -replace '<title>Teaching</title>', '<title>Teaching | Siipola</title>' | Set-Content "$BuildDir/teaching.html"
}
if (Test-Path "$BuildDir/misc.html") {
    (Get-Content "$BuildDir/misc.html") -replace '<title>Miscellaneous</title>', '<title>Misc | Siipola</title>' | Set-Content "$BuildDir/misc.html"
}
if (Test-Path "$BuildDir/notes/2025-08-note-test.html") {
    (Get-Content "$BuildDir/notes/2025-08-note-test.html") -replace '<title>[^<]*</title>', '<title>Notes | Siipola</title>' | Set-Content "$BuildDir/notes/2025-08-note-test.html"
}

Write-Host "Fixing paths in subdirectory files..."

# Fix CSS and JS paths for notes subdirectory
if (Test-Path "$BuildDir/notes/") {
    Get-ChildItem -Path "$BuildDir/notes/" -Filter "*.html" -ErrorAction SilentlyContinue | ForEach-Object {
        (Get-Content $_.FullName) -replace 'href="static/', 'href="../static/' -replace 'src="static/', 'src="../static/' | Set-Content $_.FullName
    }
}

# Fix CSS and JS paths for blog subdirectory  
if (Test-Path "$BuildDir/blog/") {
    Get-ChildItem -Path "$BuildDir/blog/" -Filter "*.html" -ErrorAction SilentlyContinue | ForEach-Object {
        (Get-Content $_.FullName) -replace 'href="static/', 'href="../static/' -replace 'src="static/', 'src="../static/' | Set-Content $_.FullName
    }
}

Write-Host "Removing duplicate title tags..."

# Remove duplicate title tags (except index.html)
Get-ChildItem -Path "$BuildDir/" -Filter "*.html" | Where-Object { $_.Name -ne "index.html" } | ForEach-Object {
    (Get-Content $_.FullName) -replace '<title>Arttu Siipola</title>', '' | Set-Content $_.FullName
}

Write-Host "Windows post-processing complete!"
