param(
    $templatePath = "c:\temp\template.json",
    $parametersPath = "c:\temp\parameter.json",
    $resourceGroupName = "MyResourceGroup"
)
$subscriptionIds = @("","")

workflow RunArmDeploy
{
    param (
    $templatePath,
    $parametersPath,
    $subscriptionIds,
    $resourceGroupName)
  
    
    foreach -parallel ($subscriptionId in $subscriptionIds)
    {
        $deployDateTime = (get-date).ToString("yyyy-MM-dd-HH:mm:ss")
        $deployName = "$subscriptionId-Deploy-$deployDateTime"
        Select-AzureRmSubscription $subscriptionId
        New-AzureRmResourceGroupDeployment -Name $deployName -ResourceGroupName $resourceGroupName -TemplateParameterFile $parametersPath -TemplateFile $templatePath
    }
}

RunArmDeploy -templatePath $templatePath -parametersPath $parametersPath -subscriptionIds $subscriptionIds -resourceGroupName $resourceGroupName