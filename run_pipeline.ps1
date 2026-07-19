# 1. Run dbt to prepare the latest features
dbt run --select models/marts/ml

# 2. Run the python script to train the model
python train_model.py

Write-Host "Pipeline and Model Training Complete!"# 1. Define the project directory
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
