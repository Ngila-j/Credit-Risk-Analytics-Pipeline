# 1. Define the project directory
$projectPath = "C:\Users\Josphat\local-de-sandbox\dbt_project"
$dbtPath = "C:\Users\Josphat\AppData\Roaming\Python\Python314\Scripts\dbt.exe"

# 2. Move to the project folder
Set-Location -Path $projectPath

# 3. Execute Production Run and Tests
# --target prod ensures we write to our production database
& $dbtPath run --target prod
& $dbtPath test --target prod

# 4. Generate updated documentation for the production state
& $dbtPath docs generate --target prod

Write-Host "Production pipeline update completed successfully!" -ForegroundColor Green
